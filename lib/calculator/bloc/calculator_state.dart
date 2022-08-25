part of 'calculator_bloc.dart';

// class CalculatorState extends Equatable {
//   const CalculatorState({
//     this.leftOperand = '',
//     this.operation = Operation.none,
//     this.result = '0',
//     this.rightOperand = '',
//   });
//   final String result;
//   final String leftOperand;
//   final String rightOperand;
//   final Operation operation;

//   CalculatorState copyWith({
//     String? result,
//     String? leftOperand,
//     String? rightOperand,
//     Operation? operation,
//   }) {
//     return CalculatorState(
//       result: result ?? this.result,
//       leftOperand: leftOperand ?? this.leftOperand,
//       rightOperand: rightOperand ?? this.rightOperand,
//       operation: operation ?? this.operation,
//     );
//   }

//   @override

// }

class CalculatorState extends Equatable {
  CalculatorState({
    this.leftOperand = '',
    this.operation = Operation.none,
    this.result = '0',
    this.rightOperand = '',
  });
  final String result;
  final String leftOperand;
  final String rightOperand;
  final Operation operation;

  CalculatorState copyWith({
    String? result,
    String? leftOperand,
    String? rightOperand,
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

class CalculatorInitial extends CalculatorState {
  CalculatorInitial({
    super.result,
  });
  // @override
  // CalculatorInitial copyWith({
  //   String? result,
  // }) {
  //   return CalculatorInitial(
  //     result: result ?? this.result,
  //   );
  // }
}

class CalculatorTyping extends CalculatorState {
  CalculatorTyping({
    super.leftOperand,
    super.operation,
    super.rightOperand,
  });
  // CalculatorTyping copyWith({
  //   String? leftOperand,
  //   String? rightOperand,
  //   Operation? operation,
  // }) {
  //   return CalculatorTyping(
  //     leftOperand: leftOperand ?? this.leftOperand,
  //     rightOperand: rightOperand ?? this.rightOperand,
  //     operation: operation ?? this.operation,
  //   );
  // }
}

class CalculatorResult extends CalculatorState {
  CalculatorResult({
    super.result,
  });
  // CalculatorResult copyWith({
  //   String? result,
  // }) {
  //   return CalculatorResult(
  //     result: result ?? this.result,
  //   );
  // }
}

enum Operation { none, add, subtract, multiply, divide }
