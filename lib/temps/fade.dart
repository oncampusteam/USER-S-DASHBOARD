import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SwipeFadeTransitionExample(),
    );
  }
}

class SwipeFadeTransitionExample extends StatefulWidget {
  const SwipeFadeTransitionExample({super.key});

  @override
  _SwipeFadeTransitionExampleState createState() => _SwipeFadeTransitionExampleState();
}

class _SwipeFadeTransitionExampleState extends State<SwipeFadeTransitionExample> {
  double _opacity = 1.0;

  void _handlePanUpdate(DragUpdateDetails details) {
    // Calculate opacity based on the horizontal velocity (details.delta.dx)
    setState(() {
      _opacity = (1 - (details.delta.dx.abs() / 300)).clamp(0.0, 1.0);
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    double velocity = details.primaryVelocity ?? 0;

    // Decide what to do based on the final velocity
    if (velocity.abs() > 500) {
      // If the swipe was fast enough, fade out completely
      setState(() {
        _opacity = 0.0;
      });
    } else {
      // If the swipe was slow, reset opacity
      setState(() {
        _opacity = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swipe to Fade Example')),
      body: GestureDetector(
        onPanUpdate: _handlePanUpdate,
        onPanEnd: _handlePanEnd,
        child: Stack(
          children: [
            Opacity(
              opacity: _opacity,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'First Screen',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
            // This second widget could be another screen or element
            Positioned.fill(
              child: Opacity(
                opacity: 1.0 - _opacity,
                child: Container(
                  color: Colors.green,
                  child: const Center(
                    child: Text(
                      'Second Screen',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
