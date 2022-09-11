import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorState()) {
    on<DigitTappedEvent>(_onDigitTapped);
    on<CalculatorResetEvent>(_onCalculatorReset);
    on<OperationTappedEvent>(_onOperationTapped);
    on<CalculateResultEvent>(_onCalculatorResult);
  }

  void _onDigitTapped(DigitTappedEvent event, Emitter<CalculatorState> emit) {
    if (state.operation == Operation.none) {
      String lhs = state.leftOperand.toStringAsFixed(0);
      if (lhs.length < 9) {
        lhs += event.digit.toString();
      }

      emit(
        state.copyWith(
          leftOperand: double.parse(lhs),
          status: CalculatorStatus.leftOperandTyping,
        ),
      );
    } else {
      String rhs = state.rightOperand.toStringAsFixed(0);
      if (rhs.length < 9) {
        rhs += event.digit.toString();
      }

      emit(
        state.copyWith(
          rightOperand: double.parse(rhs),
          status: CalculatorStatus.rightOperandTyping,
        ),
      );
    }
  }

  void _onCalculatorReset(
      CalculatorResetEvent event, Emitter<CalculatorState> emit) {
    emit(
      state.copyWith(
          status: CalculatorStatus.initial,
          leftOperand: 0,
          rightOperand: 0,
          result: 0,
          operation: Operation.none),
    );
  }

  void _onOperationTapped(
      OperationTappedEvent event, Emitter<CalculatorState> emit) {
    if (state.operation != Operation.none) {
      final result = _performOperation(state.operation);
      emit(state.copyWith(
        status: CalculatorStatus.leftOperandTyping,
        rightOperand: 0,
        leftOperand: result,
      ));
    }
    emit(state.copyWith(operation: event.operation));
  }

  void _onCalculatorResult(
      CalculateResultEvent event, Emitter<CalculatorState> emit) {
    final result = _performOperation(state.operation);
    emit(
      state.copyWith(
        result: result,
        leftOperand: result,
        rightOperand: 0,
        operation: Operation.none,
        status: CalculatorStatus.done,
      ),
    );
  }

  double _performOperation(Operation operation) {
    final double lhs = state.leftOperand;
    final double rhs = state.rightOperand;
    double result = 0;
    switch (state.operation) {
      case Operation.none:
        return result;
      case Operation.add:
        result = lhs + rhs;
        return result;
      case Operation.subtract:
        result = lhs - rhs;
        return result;
      case Operation.multiply:
        result = lhs * rhs;
        return result;
      case Operation.divide:
        result = lhs / rhs;

        return result;
    }
  }
}
