import 'package:flutter/material.dart';

class Notifier extends ChangeNotifier {
  void triggerAnimation() {
    notifyListeners();
  }
}

Notifier notify = Notifier();
