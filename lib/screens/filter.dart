import 'package:flutter/material.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/firebase/firestore_db.dart';

class HostelFilter {
  double minPrice;
  double maxPrice;
  List<String> amenities;
  String? gender;

  HostelFilter({
    this.minPrice = 1000,
    this.maxPrice = 10000,
    List<String>? amenities,
    this.gender,
  }) : amenities = amenities ?? [];

  void reset() {
    minPrice = 1000;
    maxPrice = 10000;
    amenities.clear();
    gender = null;
  }
}

class Filter extends StatefulWidget {
  final List<Hostels> hostels;
  final Function(List<Hostels>) onApply;
  const Filter({super.key, required this.hostels, required this.onApply});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool isChecked = false;
  bool isOn = true;
  bool isLoading = false;
  final HostelFilter filter = HostelFilter();
  final List<String> availableAmenities = const [
    'wifi',
    'Water Supply',
    'Electricity',
    'Private Washroom',
    'Furnished Rooms',
  ];

  List<Hostels> applyHostelFilters({
    required List<Hostels> hostels,
    required HostelFilter filter,
  }) {
    return hostels.where((hostel) {
      /// PRICE FILTER
      if (hostel.amt_per_year != null) {
        if (hostel.amt_per_year! < filter.minPrice ||
            hostel.amt_per_year! > filter.maxPrice) {
          return false;
        }
      }

      /// AMENITIES FILTER (ALL must match)
      if (filter.amenities.isNotEmpty) {
        final hostelAmenities = hostel.amenities ?? [{}];
        // print("hostel.amenities ${hostel.amenities}");
        // print("filter.amenities ${filter.amenities}");

        final hasAllAmenities = filter.amenities.any(
          (a) => hostelAmenities.contains(a),
        );

        if (!hasAllAmenities) return false;
      }

      // / GENDER FILTER
      if (filter.gender != null && filter.gender != 'All') {
        if (hostel.gender != filter.gender) return false;
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text("Filter"),
                    TextButton(
                      child: Text("Apply"),
                      onPressed: () {
                        final filtered = applyHostelFilters(
                          hostels: widget.hostels,
                          filter: filter,
                        );
                        print("before filtered: ${widget.hostels}");
                        widget.onApply(filtered);
                        Navigator.pop(context);
                        print("filtered: ${filtered}");
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                const Text(
                  "price",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),

                RangeSlider(
                  values: RangeValues(filter.minPrice, filter.maxPrice),
                  min: 1000,
                  max: 10000,
                  divisions: 3, // 4 stops
                  activeColor: Color.fromARGB(255, 0, 239, 209),
                  inactiveColor: Colors.grey[300],
                  // labels: const RangeLabels('', ''),
                  labels: RangeLabels(
                    'GHS ${filter.minPrice.toInt()}',
                    'GHS ${filter.maxPrice.toInt()}',
                  ),
                  onChanged: (value) {
                    setState(() {
                      filter.minPrice = value.start;
                      filter.maxPrice = value.end;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "GHS 1000",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "GHS 4,000",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "GHS 7,000",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "GHS 10,000",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Text("Amenities"),

                // Row(
                //   children: [
                //     Checkbox(value: isChecked, onChanged: (bool? newValue) {}),
                //     Text("Wifi"),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Checkbox(value: isChecked, onChanged: (bool? newValue) {}),
                //     Text("Water Supply"),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Checkbox(value: isChecked, onChanged: (bool? newValue) {}),
                //     Text("Electricity"),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Checkbox(value: isChecked, onChanged: (bool? newValue) {}),
                //     Text("Private Washroom"),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Checkbox(value: isChecked, onChanged: (bool? newValue) {}),
                //     Text("Furnished Rooms"),
                //   ],
                // ),
                ...availableAmenities.map(
                  (amenity) => Container(
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      title: Text(amenity, style: TextStyle(fontSize: 14)),
                      value: filter.amenities.contains(amenity),
                      onChanged: (value) {
                        setState(() {
                          value!
                              ? filter.amenities.add(amenity)
                              : filter.amenities.remove(amenity);
                        });
                      },
                    ),
                  ),
                ),
                // Row(
                //   children: [
                //     Checkbox(value: isChecked, onChanged: (bool? newValue) {}),
                //     Text("Kitchen Access"),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Checkbox(value: isChecked, onChanged: (bool? newValue) {}),
                //     Text("Study Area"),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Checkbox(value: isChecked, onChanged: (bool? newValue) {}),
                //     Text("Security(CCTV, Gate, Guard)"),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Checkbox(value: isChecked, onChanged: (bool? newValue) {}),
                //     Text("Shuttle Service"),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Checkbox(value: isChecked, onChanged: (bool? newValue) {}),
                //     Text("Air Conditioning or Fan"),
                //   ],
                // ),
                Center(
                  child: TextButton(
                    child: Row(
                      children: [
                        Icon(Icons.arrow_drop_up_outlined),
                        Text("Show less"),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
                // Text("Duration"),
                // SizedBox(height: 10),
                // Row(
                //   children: [
                //     Expanded(
                //       child: ElevatedButton(
                //         style: ElevatedButton.styleFrom(elevation: 0),
                //         child: Text("<1 year"),
                //         onPressed: () {},
                //       ),
                //     ),
                //     Expanded(
                //       child: ElevatedButton(
                //         style: ElevatedButton.styleFrom(elevation: 0),
                //         child: Text("1-2 years"),
                //         onPressed: () {},
                //       ),
                //     ),
                //     Expanded(
                //       child: ElevatedButton(
                //         style: ElevatedButton.styleFrom(elevation: 0),
                //         child: Text(">3 years"),
                //         onPressed: () {},
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 10), Text("Gender"), SizedBox(height: 10),

                Row(
                  children: ['Male', 'Female'].map((g) {
                    final bool isSelected = filter.gender == g;

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              filter.gender = g;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: isSelected
                                ? Color.fromARGB(255, 0, 239, 209)
                                : Colors.grey.shade200,
                            foregroundColor: isSelected
                                ? Colors.white
                                : Colors.black87,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(g),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 10),
                Text("Location"),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 0),
                        child: Text("Near me"),
                        onPressed: () {},
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      child: Text("My campus"),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 0),
                        child: Text("All"),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        SizedBox(width: 5),
                        Text("Current Location"),
                      ],
                    ),
                    Switch(
                      value: isOn,
                      onChanged: (value) {
                        setState(() {
                          isOn = value;
                        });
                      },
                      activeColor: Colors.white,
                      activeTrackColor: Colors.tealAccent,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey.shade300,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Center(
                  child: TextButton(
                    child: Text(
                      "Reset filter",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      filter.reset();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
