import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_campus/firebase/classes.dart';
import 'package:on_campus/classes/user_file.dart';
import 'package:on_campus/classes/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
      ),
      child: Material(
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                padding: EdgeInsets.only(left: 25.h),
                onPressed: () {},
                icon: Icon(Icons.chevron_left, color: Colors.black, size: 30),
              ),
              title: SizedBox(
                height: Constant.height * 0.03,
                child: FittedBox(
                  child: Text(
                    "Wishlist",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0A0A0A),
                    ),
                  ),
                ),
              ),
            ),
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Column(
                children: [
                SizedBox(height: 20.h,),
                wishListCard(
                hostel: userInformation["wish_list"].toList()[0]
              )]),
            ),
          ),
        ),
      ),
    );
  }

  Widget wishListCard({
    required Hostels hostel
  }) {
    return SizedBox(child: Row(
      children: [
        Container(
        height: Constant.height * 0.07,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r)
        ),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12.r),
            child: CachedNetworkImage(
                  imageUrl: hostel.hostel_images?[0] ?? "",   // Network image
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Image.asset(
                    "assets/notification/default.png",
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/notification/default.png",
                    fit: BoxFit.cover,
                  ),
                ),
          ),
        ),
        SizedBox(width: 10.h,),
        Column(
          children: [
            SizedBox(
              height: Constant.height * 0.03,
              child: FittedBox(
                child: Text(
                  hostel.name,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0A0A0A)
                  ),
                  ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
