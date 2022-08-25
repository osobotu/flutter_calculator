import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorInitial()) {
    on<DigitTappedEvent>(_onDigitTapped);
    on<CalculatorResetEvent>(_onCalculatorReset);
    on<OperationTappedEvent>(_onOperationTapped);
    on<CalculateResultEvent>(_onCalculatorResult);
  }

  void _onDigitTapped(DigitTappedEvent event, Emitter<CalculatorState> emit) {
    if (state.operation == Operation.none) {
      String lhs = state.leftOperand;
      emit(state.copyWith(leftOperand: lhs += event.digit));
    }
    if (state.operation != Operation.none) {
      String rhs = state.rightOperand;
      emit(state.copyWith(rightOperand: rhs += event.digit));
    }
  }

  void _onCalculatorReset(
      CalculatorResetEvent event, Emitter<CalculatorState> emit) {
    emit(CalculatorInitial());
  }

  void _onOperationTapped(
      OperationTappedEvent event, Emitter<CalculatorState> emit) {
    emit(state.copyWith(operation: event.operation));
  }

  void _onCalculatorResult(
      CalculateResultEvent event, Emitter<CalculatorState> emit) {
    final double lhs = double.parse(state.leftOperand);
    final double rhs = double.parse(state.rightOperand);
    double result = 0;
    switch (state.operation) {
      case Operation.none:
        break;
      case Operation.add:
        result = lhs + rhs;
        break;
      case Operation.subtract:
        result = lhs - rhs;
        break;
      case Operation.multiply:
        result = lhs * rhs;
        break;
      case Operation.divide:
        result = lhs / rhs;
        break;
    }
    emit(state.copyWith(result: result.toStringAsFixed(1)));
  }
}
