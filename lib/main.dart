import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_calculator/app.dart';
import 'package:flutter_calculator/simple_app_observer.dart';

void main() {
  Bloc.observer = SimpleAppObserver();
  runApp(const CalculatorApp());
}
