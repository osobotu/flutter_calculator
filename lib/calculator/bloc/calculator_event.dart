part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorEvent {}

class DigitTappedEvent extends CalculatorEvent {
  DigitTappedEvent(this.digit);
  final int digit;
}

class OperationTappedEvent extends CalculatorEvent {
  OperationTappedEvent(this.operation);
  final Operation operation;
}

class DecimalTappedEvent extends CalculatorEvent {
  DecimalTappedEvent();
}

class CalculateResultEvent extends CalculatorEvent {
  CalculateResultEvent();
}

class CalculatorResetEvent extends CalculatorEvent {
  CalculatorResetEvent();
}
