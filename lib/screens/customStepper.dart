import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  final ValueChanged<int>? onStepTapped;
  final List<String> stepTitles;

  const CustomStepper({super.key, 
    required this.currentStep,
    this.onStepTapped,
    required this.stepTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(stepTitles.length, (index) {
        return GestureDetector(
          onTap: () => onStepTapped?.call(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Step indicator
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentStep >= index
                      ? Colors.transparent
                      : Colors.grey[300],
                  border: currentStep >= index
                      ? Border.all(
                          color: Color.fromARGB(255, 124, 241, 225),
                          width: currentStep >= index ? 2 : 0,
                        )
                      : Border.all(color: Colors.transparent),
                ),
                child: Center(
                  child: currentStep > index
                      ? Icon(Icons.check, size: 18, color: Colors.white)
                      : Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: currentStep >= index
                                ? Colors.black
                                : Colors.grey[700],
                            fontSize: 10,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 8),
              // Step title
              Text(
                stepTitles[index],
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: currentStep == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: currentStep >= index ? Colors.grey[850] : Colors.grey,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
