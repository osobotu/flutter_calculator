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
  }

  void _onDigitTapped(DigitTappedEvent event, Emitter<CalculatorState> emit) {
    if (state.operation == Operation.none) {
      String lhs = state.leftOperand;
      emit(CalculatorTyping(leftOperand: lhs += event.digit));
    }
  }

  void _onCalculatorReset(
      CalculatorResetEvent event, Emitter<CalculatorState> emit) {
    emit(CalculatorInitial());
  }

  void _onOperationTapped(
      OperationTappedEvent event, Emitter<CalculatorState> emit) {
    emit(CalculatorTyping(operation: event.operation));
  }
}
