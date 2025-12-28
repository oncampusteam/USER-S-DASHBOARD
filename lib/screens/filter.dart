import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final List<double> stops = [0, 1, 2, 3];
  RangeValues selected = const RangeValues(1, 2);
  bool isChecked = false;
  bool isOn = true;

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
                    TextButton(child: Text("Cancel"), onPressed: () {}),
                    Text("Filter"),
                    TextButton(child: Text("Apply"), onPressed: () {}),
                  ],
                ),
                SizedBox(height: 10),
                const Text(
                  "price",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),

                RangeSlider(
                  values: selected,
                  min: 0,
                  max: 3,
                  divisions: 3, // 4 stops
                  activeColor: Color.fromARGB(255, 0, 239, 209),
                  inactiveColor: Colors.grey[300],
                  // labels: const RangeLabels('', ''),
                  onChanged: (RangeValues v) {
                    setState(() {
                      selected = RangeValues(
                        v.start.round().toDouble(),
                        v.end.round().toDouble(),
                      );
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "GHS 10,000",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "GHS 8,000",
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
                        "GHS 1,000",
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
                Row(
                  children: [
                    Checkbox(value: isChecked, onChanged: (bool? newValue) {}),
                    Text("Wifi"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: isChecked, onChanged: (bool? newValue) {}),
                    Text("Water Supply"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: isChecked, onChanged: (bool? newValue) {}),
                    Text("Electricity"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: isChecked, onChanged: (bool? newValue) {}),
                    Text("Private Washroom"),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(value: isChecked, onChanged: (bool? newValue) {}),
                    Text("Furnished Rooms"),
                  ],
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
                Text("Duration"),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 0),
                        child: Text("<1 year"),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 0),
                        child: Text("1-2 years"),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 0),
                        child: Text(">3 years"),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10), Text("Gender"), SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 0),
                        child: Text("Male"),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 0),
                        child: Text("Female"),
                        onPressed: () {},
                      ),
                    ),
                  ],
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
                    onPressed: () {},
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
