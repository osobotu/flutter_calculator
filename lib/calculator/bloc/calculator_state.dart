part of 'calculator_bloc.dart';

class CalculatorState extends Equatable {
  const CalculatorState({
    this.leftOperand = 0,
    this.operation = Operation.none,
    this.result = 0,
    this.rightOperand = 0,
  });
  final double result;
  final double leftOperand;
  final double rightOperand;
  final Operation operation;

  CalculatorState copyWith({
    double? result,
    double? leftOperand,
    double? rightOperand,
    Operation? operation,
  }) {
    return CalculatorState(
      result: result ?? this.result,
      leftOperand: leftOperand ?? this.leftOperand,
      rightOperand: rightOperand ?? this.rightOperand,
      operation: operation ?? this.operation,
    );
  }

  @override
  List<Object?> get props => [result, leftOperand, rightOperand, operation];
}

enum Operation { none, add, subtract, multiply, divide }
