import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Custom PageView Transition')),
        body: CustomPageView(),
      ),
    );
  }
}

class CustomPageView extends StatefulWidget {
  const CustomPageView({super.key});

  @override
  _CustomPageViewState createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 1.0;

            if (_pageController.position.haveDimensions) {
              value = _pageController.page! - index;
              value = (1 - value.abs()).clamp(0.0, 1.0);
            }

            return Opacity(
              opacity: value,
              child: child,
            );
          },
          child: Container(
            color: Colors.primaries[index % Colors.primaries.length],
            child: Center(
              child: Text(
                'Page $index',
                style: const TextStyle(fontSize: 32, color: Colors.white),
              ),
            ),
          ),
        );
      },
      itemCount: 5,
    );
  }
}
