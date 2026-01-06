import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_campus/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:on_campus/screens/initialPage_0.dart';
import 'package:on_campus/classes/screen_details.dart';
import 'package:on_campus/screens/welcome_page_views.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:on_campus/screens/initial_page.dart';

void main() async {
  // DependencyInjection.init();
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: Colors.blue,
  //     statusBarIconBrightness: Brightness.dark,
  //   ),
  // );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

double screenHeight = 0;
double screenWidth = 0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return GetMaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F8FF),
        fontFamily: "Poppins",
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        // scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
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
    future = Future.delayed(const Duration(seconds: 5));
  }

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    ScreenDetails().screenDimensions(
      screenWidth: MediaQuery.of(context).size.width,
      screenHeight: MediaQuery.of(context).size.height,
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        builder: (BuildContext context, widget) {
          return FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Material(child: const Initialpage0());
              }
              return Material(child: const WelcomePageViews());
              // return Material(child:Scaffold(
              //   body: Center(
              //     child: Column(
              //       children: [
              //         SizedBox(height : 200.h),
              //         Text("this is a"),
              //         Container(
              //             padding: EdgeInsets.symmetric(horizontal: 10.h),
              //             height: 60,
              //             child: CustomBottomNavBar(height: 60, dip: 50))
              //       ],
              //     ),
              //   ),
              // ));
            },
          );
        },
      ),
    );
  }
}
