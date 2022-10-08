part of 'calculator_bloc.dart';

class CalculatorState extends Equatable {
  CalculatorState({
    this.leftOperand = '',
    this.operation = Operation.none,
    this.result = '0',
    this.rightOperand = '',
    this.status = CalculatorStatus.initial,
  });
  final String result;
  final String leftOperand;
  final String rightOperand;
  final Operation operation;
  final CalculatorStatus status;

  CalculatorState copyWith({
    String? result,
    String? leftOperand,
    String? rightOperand,
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
