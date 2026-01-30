import 'package:flutter/material.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Enquire extends StatelessWidget {
  final Hostels hostel;
  Enquire({super.key, required this.hostel});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Enquire Now",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
        ),
        elevation: 1,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, size: 15),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 124, 241, 225).withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: hostel.hostel_images![0]["imageUrl"] ?? "",
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hostel.name,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: hostel.region),
                                TextSpan(text: ", "),
                                TextSpan(text: hostel.city),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: "From "),
                                TextSpan(
                                  text: "GH₵${hostel.amt_per_year}/",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(text: " year"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              const Text.rich(
                style: TextStyle(height: 2),
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Great choice at the perfect moment! ",
                      style: TextStyle(color: Color(0xFF00EFD1)),
                    ),
                    TextSpan(
                      text:
                          "Feel free to make an enquiry-it's completely free",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              customTextField(controller: nameController, hintText: "Your Full Name"),
              SizedBox(height: 15),
              customTextField(controller: emailController, hintText: ""),
              SizedBox(height: 15),
              customTextField(controller: contactController, hintText: ""),
              Spacer(),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  height: 100,
                  child: Column(
                    children: [
                      Text("I agree with all terms and privacy of oncampus"),
                      ElevatedButton(child: Text("Submit"), onPressed: () {}),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customTextField({required TextEditingController controller, required String hintText}) {
  return TextField(
    //   onChanged: (){},
    //   focusNode:,
    controller: controller,
    obscureText: false,
    enableSuggestions: true,
    autocorrect: false,
    cursorColor: Colors.white,
    style: const TextStyle(color: Colors.grey),
    decoration: InputDecoration(
      labelText: hintText,
      labelStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.white,

      // prefixIcon: Icon(widget.icon),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 1,
          style: BorderStyle.none,
          color: Colors.grey.withOpacity(0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 1,
          // style: BorderStyle.none,
          color: Color(0xFF00EFD1),
        ),
      ),
    ),
    keyboardType: TextInputType.visiblePassword,
  );
}
