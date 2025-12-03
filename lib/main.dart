import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_campus/classes/screen_details.dart';
import 'package:on_campus/screens/initialPage_0.dart';
import 'package:on_campus/screens/initial_page.dart';
import 'package:on_campus/firebase_options.dart';



void main() async {
  // DependencyInjection.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    debugPrint(
      "${MediaQuery.of(context).size.height}, ${MediaQuery.of(context).size.width}",
    );
    return GetMaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F8FF),
        fontFamily: "Poppins",
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StartupScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  late Future<void> future;
  @override
  void initState() {
    super.initState();
    future = Future.delayed(const Duration(milliseconds: 100));
  }

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    ScreenDetails().screenDimensions(
      screenWidth: MediaQuery.of(context).size.width,
      screenHeight: MediaQuery.of(context).size.height,
    );
    return ScreenUtilInit(
      designSize: const Size(390, 690),
      minTextAdapt: true,
      builder: (BuildContext context, widget) {
        return SafeArea(
          child: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const InitialPage();
              }
              return const Initialpage0();
            },
          ),
        );
      },
    );
  }
}


