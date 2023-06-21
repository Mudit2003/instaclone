import 'package:flutter/material.dart';

class OnTap extends ChangeNotifier {
  bool toggleA = true;
  bool toggleB = true;

  OnTap({
    required this.toggleA,
    required this.toggleB,
  });

  void toggleStateA() {
    toggleA = !toggleA; 
  }
  void toggleStateB() {
    toggleB = !toggleB; 
  }
  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}
