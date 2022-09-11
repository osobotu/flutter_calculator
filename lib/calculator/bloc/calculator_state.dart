part of 'calculator_bloc.dart';

class CalculatorState extends Equatable {
  CalculatorState({
    this.leftOperand = 0,
    this.operation = Operation.none,
    this.result = 0,
    this.rightOperand = 0,
    this.status = CalculatorStatus.initial,
  });
  final double result;
  final double leftOperand;
  final double rightOperand;
  final Operation operation;
  final CalculatorStatus status;

  CalculatorState copyWith({
    double? result,
    double? leftOperand,
    double? rightOperand,
    Operation? operation,
    CalculatorStatus? status,
  }) {
    return CalculatorState(
      status: status ?? this.status,
      result: result ?? this.result,
      leftOperand: leftOperand ?? this.leftOperand,
      rightOperand: rightOperand ?? this.rightOperand,
      operation: operation ?? this.operation,
    );
  }

  @override
  List<Object?> get props =>
      [status, result, leftOperand, rightOperand, operation];
}

enum Operation { none, add, subtract, multiply, divide }

enum CalculatorStatus { initial, leftOperandTyping, rightOperandTyping, done }
