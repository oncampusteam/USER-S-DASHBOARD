import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GetIcon extends StatelessWidget {
  final String text;
  const GetIcon({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final normalizedText = text.toLowerCase().trim().replaceAll(
      RegExp(r'\s+'),
      ' ',
    );
    if (normalizedText == "bed") {
      return SvgPicture.asset("assets/home/bed.svg");
    } else if (normalizedText.contains("bathroom")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/amenities_icons/Water heater.svg',
      );
    } else if (normalizedText.contains("heater")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/amenities_icons/Water heater.svg',
      );
    } else if (normalizedText.contains("aircondition") ||
        normalizedText.contains("air") ||
        normalizedText.contains("conditioner")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/Hostel_detail_screens/AC.svg',
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("commonarea") ||
        normalizedText.contains("common")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/amenities_icons/Common Area.svg',
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("washroom")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/Hostel_detail_screens/washroom.svg',
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("studentshop") ||
        normalizedText.contains("shop")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/amenities_icons/mini shop.svg',
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("wardrobe")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/Hostel_detail_screens/Wardrobe.svg',
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("sports") ||
        normalizedText.contains("field")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/amenities_icons/Sports field.svg',
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("mirror")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/amenities_icons/Mirror.svg',
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("balcony")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/amenities_icons/Balcony.svg',
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("elevator")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/amenities_icons/Elevator.svg',
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("dining")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/amenities_icons/Dining Area.svg',
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("gym")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/amenities_icons/Gym.svg',
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("salon") ||
        normalizedText.contains("barber")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/amenities_icons/Salon & Barber.svg',
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("car") ||
        normalizedText.contains("carpark")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/amenities_icons/Car park.svg',
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("clinic") ||
        normalizedText.contains("pharmacy")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/amenities_icons/Mini clinic.svg',
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("atm")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/amenities_icons/ATM.svg',
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("cafeteria")) {
      return SvgPicture.asset(
        'assets/user_interface_icons/amenities_icons/Cafeteria.svg',
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("swimming") ||
        normalizedText.contains("pool")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/amenities_icons/Swimming pool.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("kitchen")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/Hostel_detail_screens/Kitchen icon.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("study") ||
        normalizedText.contains("desk")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/Hostel_detail_screens/Study Desk.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("fan")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/Hostel_detail_screens/Fan.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("generator")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/bills_icons/Generator.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("wi-fi") ||
        normalizedText.contains("wifi")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/Hostel_detail_screens/wifi.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("electricity")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/Hostel_detail_screens/Electricity.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("waste") ||
        normalizedText.contains("bins") ||
        normalizedText.contains("bin")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/bills_icons/Waste bins.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("housekeeping")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/bills_icons/House keeping.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("shuttle")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/bills_icons/Shuttle services.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("well") ||
        normalizedText.contains("borehole")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/bills_icons/Well or borehole.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("tap")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/Hostel_detail_screens/Tap water.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("laundry")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/bills_icons/Laundry Services.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("24") ||
        normalizedText.contains("247") ||
        normalizedText.contains("247security")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/security_and_safety_icons/247 Security.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("fireextinguishers") ||
        normalizedText.contains("extinguisher")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/security_and_safety_icons/Fire Extinguishers.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("cctv")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/security_and_safety_icons/CCTV.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("firstaid")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/security_and_safety_icons/first aid.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("dogs")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/security_and_safety_icons/Security Dogs.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("accesscontrol")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/security_and_safety_icons/Access Control.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("visitorchecks")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/security_and_safety_icons/Visitor Checks.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("smoke") ||
        normalizedText.contains("firealarm")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/security_and_safety_icons/Smoke Detectors & Fire Alarms.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("emergencyexits") ||
        normalizedText.contains("exit")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/security_and_safety_icons/Emergency Exits.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("fencing")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/security_and_safety_icons/Fencing & Gated Entry.svg",
        width: 24,
        height: 24,
      );
    } else if (normalizedText.contains("noicon")) {
      return SvgPicture.asset(
        "assets/user_interface_icons/Hostel_detail_screens/ic_add.svg",
        width: 24,
        height: 24,
      );
    }
    return SizedBox.shrink();
  }
}

Widget getIcon({required String text}) {
  final normalizedText = text.toLowerCase().trim().replaceAll(
    RegExp(r'\s+'),
    ' ',
  );
  if (normalizedText == "bed") {
    return SvgPicture.asset("assets/home/bed.svg");
  } else if (normalizedText.contains("bathroom")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/amenities_icons/Water heater.svg',
    );
  } else if (normalizedText.contains("heater")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/amenities_icons/Water heater.svg',
    );
  } else if (normalizedText.contains("aircondition") ||
      normalizedText.contains("air") ||
      normalizedText.contains("conditioner")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/Hostel_detail_screens/AC.svg',
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("commonarea") ||
      normalizedText.contains("common")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/amenities_icons/Common Area.svg',
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("washroom")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/Hostel_detail_screens/washroom.svg',
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("studentshop") ||
      normalizedText.contains("shop")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/amenities_icons/mini shop.svg',
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("wardrobe")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/Hostel_detail_screens/Wardrobe.svg',
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("sports") ||
      normalizedText.contains("field")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/amenities_icons/Sports field.svg',
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("mirror")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/amenities_icons/Mirror.svg',
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("balcony")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/amenities_icons/Balcony.svg',
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("elevator")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/amenities_icons/Elevator.svg',
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("dining")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/amenities_icons/Dining Area.svg',
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("gym")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/amenities_icons/Gym.svg',
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("salon") ||
      normalizedText.contains("barber")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/amenities_icons/Salon & Barber.svg',
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("car") ||
      normalizedText.contains("carpark")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/amenities_icons/Car park.svg',
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("clinic") ||
      normalizedText.contains("pharmacy")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/amenities_icons/Mini clinic.svg',
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("atm")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/amenities_icons/ATM.svg',
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("cafeteria")) {
    return SvgPicture.asset(
      'assets/user_interface_icons/amenities_icons/Cafeteria.svg',
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("swimming") ||
      normalizedText.contains("pool")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/amenities_icons/Swimming pool.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("kitchen")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/Hostel_detail_screens/Kitchen icon.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("study") ||
      normalizedText.contains("desk")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/Hostel_detail_screens/Study Desk.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("fan")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/Hostel_detail_screens/Fan.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("generator")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/bills_icons/Generator.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("wi-fi") ||
      normalizedText.contains("wifi")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/Hostel_detail_screens/wifi.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("electricity")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/Hostel_detail_screens/Electricity.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("waste") ||
      normalizedText.contains("bins") ||
      normalizedText.contains("bin")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/bills_icons/Waste bins.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("housekeeping")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/bills_icons/House keeping.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("shuttle")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/bills_icons/Shuttle services.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("well") ||
      normalizedText.contains("borehole")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/bills_icons/Well or borehole.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("tap")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/Hostel_detail_screens/Tap water.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("laundry")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/bills_icons/Laundry Services.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("24") ||
      normalizedText.contains("247") ||
      normalizedText.contains("247security")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/security_and_safety_icons/247 Security.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("fireextinguishers") ||
      normalizedText.contains("extinguisher")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/security_and_safety_icons/Fire Extinguishers.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("cctv")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/security_and_safety_icons/CCTV.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("firstaid") ||
      normalizedText.contains("first")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/security_and_safety_icons/first aid.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("dogs")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/security_and_safety_icons/Security Dogs.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("accesscontrol")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/security_and_safety_icons/Access Control.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("visitorchecks")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/security_and_safety_icons/Visitor Checks.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("smoke") ||
      normalizedText.contains("firealarm")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/security_and_safety_icons/Smoke Detectors & Fire Alarms.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("emergencyexits") ||
      normalizedText.contains("exit")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/security_and_safety_icons/Emergency Exits.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("fencing")) {
    return SvgPicture.asset(
      "assets/user_interface_icons/security_and_safety_icons/Fencing & Gated Entry.svg",
      width: 24,
      height: 24,
    );
  } else if (normalizedText.contains("noicon")) {
    return SvgPicture.asset(
      "assets/hostels_detail/view_more.png",
      width: 24,
      height: 24,
    );
  }
  return SizedBox.shrink();
}
