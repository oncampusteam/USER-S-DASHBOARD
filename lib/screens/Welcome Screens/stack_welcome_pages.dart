import 'package:flutter/material.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_1.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_2.dart';
import 'package:on_campus/screens/Welcome%20Screens/welcome_screen_3.dart';

class StackWelcomePages extends StatefulWidget {
  const StackWelcomePages({super.key});

  @override
  State<StackWelcomePages> createState() => _StackWelcomePagesState();
}

class _StackWelcomePagesState extends State<StackWelcomePages>
    with SingleTickerProviderStateMixin {
  int currentPage = 0;
  int nextPage = 1;
  int temp = 2;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    animations.add(_animation);
    animations.add(_animation);
    animations.add(_animation);
    animations.add(_animation);
  }

  List<Animation<double>> animations = [];
  // List<AnimationController>> animationcontrollers = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              setState(() {
                _animationController.reverse();
                if (details.primaryVelocity! > 7) {
                  if (currentPage == 2) {
                    currentPage = 2;
                  } else {
                    currentPage++;
                  }
                }
              });
            } else if (details.primaryVelocity! < 0) {
              setState(() {
                _animationController.forward();
                if (currentPage == 0) {
                  currentPage = 0;
                } else {
                  currentPage--;
                }
              });
            }
          },
          child: IndexedStack(
            index: currentPage,
            children: [
              Opacity(
                  opacity: animations[currentPage].value,
                  child: const WelcomeScreen1()),
              Opacity(
                  opacity: animations[nextPage].value, child: const WelcomeScreen2()),
              Opacity(opacity: animations[temp].value, child: const WelcomeScreen3())
            ],
          ),
        ));
  }
}
