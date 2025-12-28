import 'package:flutter/material.dart';

class SwipeFadeWidget extends StatefulWidget {
  const SwipeFadeWidget({super.key});

  @override
  _SwipeFadeWidgetState createState() => _SwipeFadeWidgetState();
}

class _SwipeFadeWidgetState extends State<SwipeFadeWidget> {
  double swipePosition = 0.0;
  double swipePosition_ = 0.0;
  double primaryDelta = 0;
  int currentPosition = 0;
  int nextPosition = 1;
  int numberOfSwipe = 0;
  String swipeDirection = "";
  double delta = 0;

  List<double> opacities = [1.0, 0.0, 0.0];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
            // onHorizontalDragStart: (details) {
            //   debugPrint(
            //       "This is the global position of the drag: ${details.globalPosition}");
            //   debugPrint(
            //       "This is the local position of the drag: ${details.localPosition}");
            // },
            onHorizontalDragEnd: (details) {
              // debugPrint("#####");
              if (swipeDirection == "left") {
                debugPrint("Drag from right");
                debugPrint("${details.velocity}");
                if (swipePosition > 0.5) {
                  setState(() {
                    debugPrint("Swipe Position is greater than 0.5");
                    swipePosition = 1;
                    opacities[currentPosition] = 1 - swipePosition;
                    opacities[nextPosition] = swipePosition;
                    debugPrint(
                        "This is the vale of swipe Position at the end of the drag: $swipePosition");
                    opacities[currentPosition] = 0;
                    if (currentPosition == 2) {
                      currentPosition = 2;
                    } else {
                      debugPrint("Current Position is increasing");
                      currentPosition++;
                      opacities[currentPosition] = 1;
                      if (nextPosition == 2) {
                        nextPosition = 2;
                      } else {
                        nextPosition++;
                        opacities[nextPosition] = 0;
                      }
                      swipePosition = 0;
                    }
                  });
                } else if (swipePosition < 0.5) {
                  setState(() {
                    debugPrint("Swipe Position is less than 0.5");
                    if (currentPosition == 2) {
                      debugPrint("Don't do anything");
                    } else {
                      swipePosition = 0;
                      opacities[currentPosition] = 1 - swipePosition;
                      opacities[nextPosition] = swipePosition;
                      // debugPrint(
                      //     "This is the vale of swipe Position at the end of the drag: $swipePosition");
                    }
                  });
                }
                delta = 0;
              } else if (swipeDirection == "Right") {}
            },
            onHorizontalDragUpdate: (details) {
              if (details.primaryDelta! < 0) {
                debugPrint("Right to left swipe");
                setState(() {
                  if (currentPosition == 2) {
                    debugPrint("CurrentPosition is 2 and there is no update");
                  } else {
                    swipeDirection = "left";
                    delta = (details.primaryDelta! / 300) * -1;

                    // Adjust swipe position based on normalized drag details
                    swipePosition = swipePosition + delta;

                    // Clamp swipePosition to keep it between 0 and 1
                    swipePosition = swipePosition.clamp(0.0, 1.0);
                    opacities[currentPosition] = 1 - swipePosition;
                    opacities[nextPosition] = swipePosition;

                      debugPrint("Swipe Position: $swipePosition");
                debugPrint("Primary Delta: ${details.primaryDelta!}");
                debugPrint("Delta: $delta");
                  }
                  // Assuming 300 is the width of the area you're swiping across
                });
              }

              if (details.primaryDelta! > 0 && details.localPosition.dx > 0) {
                debugPrint("Left to Right swipe");
                debugPrint("This is the value of swipePosition: $swipePosition");
                if (swipePosition > 0.5) {
                  setState(() {
                    swipePosition = 0;
                  });
                } else if (swipePosition < 0.5) {
                  setState(() {
                    swipePosition = 1;
                  });
                }
                swipeDirection = "Right";
                double delta_ = (details.primaryDelta! / 300);

                // Adjust swipe position based on normalized drag details
                swipePosition_ = swipePosition_ + delta_;

                // Clamp swipePosition to keep it between 0 and 1
                swipePosition_ = swipePosition_.clamp(0.0, 1.0);

                debugPrint("Swipe Position: $swipePosition_");
                debugPrint("Primary Delta: ${details.primaryDelta!}");
                debugPrint("Delta: $delta_");

                // if (details.primaryDelta! > 0.5) {
                //   debugPrint("Swipe is greater than 5");
                //   if (currentPosition == 0) {
                //     swipePosition_ = 0;
                //   }
                // } else if (details.primaryDelta! < 0.5) {
                //   debugPrint("Swipe is less than 5");
                //   if (currentPosition == 0) {
                //     swipePosition_ = 0;
                //   }
                // }
              }
            },
            child: Stack(
              children: [
                Opacity(
                    opacity: opacities[0],
                    child: Image.asset("assets/welcomeImage_1.jpg",
                        fit: BoxFit.fitHeight)),
                Opacity(
                    opacity: opacities[1],
                    child: Image.asset("assets/welcomeImage_2.jpg",
                        fit: BoxFit.fitHeight)),
                Opacity(
                    opacity: opacities[2],
                    child: Image.asset("assets/welcomeImage_3.png",
                        fit: BoxFit.fitHeight))
              ],
            )
            // Stack(
            //   children: [
            //     // Background Widget (fades out)
            //     Opacity(
            //       opacity: 1 - swipePosition, // Decrease opacity as swipe progresses
            //       child: Transform.translate(
            //         offset:
            //             Offset(swipePosition * 100, 0), // Translate based on swipe
            //         child: Container(
            //           color: Colors.blue,
            //           height: 300,
            //           width: double.infinity,
            //           child: Center(
            //             child: Text(
            //               'Widget 1',
            //               style: TextStyle(color: Colors.white, fontSize: 24),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     // Foreground Widget (fades in)
            //     Opacity(
            //       opacity: swipePosition, // Increase opacity as swipe progresses
            //       child: Transform.translate(
            //         offset: Offset(
            //             (1 - swipePosition) * -100, 0), // Translate based on swipe
            //         child: Container(
            //           color: Colors.red,
            //           height: 300,
            //           width: double.infinity,
            //           child: Center(
            //             child: Text(
            //               'Widget 2',
            //               style: TextStyle(color: Colors.white, fontSize: 24),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: Scaffold(body: SwipeFadeWidget())));
