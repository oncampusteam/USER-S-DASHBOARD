import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_campus/classes/classes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: "Poppins",
              useMaterial3: true,
            ),
            home: const Gallery(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = -1;
    List<Photos> tileList = [
      Photos(name: "Bedroom"),
      Photos(name: "Bathroom"),
      Photos(name: "Kitchen"),
      Photos(name: "Videos"),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromRGBO(56, 163, 244, .1),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Gallery",
                      style: TextStyle(
                        fontSize: 16.sp.clamp(0, 16),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, .4),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        height: 40.h,
                        width: 40.w,
                        child: const Icon(Icons.close, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3.r,
                      blurRadius: 8.r,
                    ),
                  ],
                ),
                height: 50.h,
                width: 600.w,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tileList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Photos tile = tileList[index];
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? Colors.transparent
                                : null,
                            border: selectedIndex == index
                                ? Border(
                                    bottom: BorderSide(
                                      color: const Color.fromARGB(
                                          255, 33, 243, 201),
                                      width: 3.w,
                                    ),
                                  )
                                : null,
                          ),
                          child: Container(
                            child: Text(
                              tile.name,
                              style: TextStyle(
                                fontSize: 12.sp.clamp(0, 12),
                                fontWeight: FontWeight.w500,
                                color: selectedIndex == index
                                    ? null
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 8.0.h),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Bedroom",
                          style: TextStyle(
                            fontSize: 14.sp.clamp(0, 14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 7,
                          crossAxisCount: 2,
                          mainAxisSpacing: 7,
                        ),
                        itemBuilder: (context, index) {
                          return Image.asset(
                            "assets/gallery/hostel-2.png",
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Bathroom",
                          style: TextStyle(
                            fontSize: 14.sp.clamp(0, 14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 7,
                          crossAxisCount: 2,
                          mainAxisSpacing: 7,
                        ),
                        itemBuilder: (context, index) {
                          return Image.asset(
                            "assets/gallery/hostel-2.png",
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Kitchen",
                          style: TextStyle(
                            fontSize: 14.sp.clamp(0, 14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 7,
                          crossAxisCount: 2,
                          mainAxisSpacing: 7,
                        ),
                        itemBuilder: (context, index) {
                          return Image.asset(
                            "assets/gallery/hostel-2.png",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Videos",
                          style: TextStyle(
                            fontSize: 14.sp.clamp(0, 14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 7,
                            crossAxisCount: 2,
                            mainAxisSpacing: 7,
                          ),
                          itemBuilder: (context, index) {
                            return Image.asset(
                              "assets/gallery/hostel-2.png",
                              // width: 100,
                              // height: 100,
                              fit: BoxFit.cover,
                            );
                          }),
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
