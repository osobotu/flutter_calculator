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
    on<PercentageTappedEvent>(_onPercentageTapped);
    on<DecimalTappedEvent>(_onDecimalTapped);
    on<PlusMinusTappedEvent>(_onPlusMinusTapped);
  }

  void _onDigitTapped(DigitTappedEvent event, Emitter<CalculatorState> emit) {
    if (state.operation == Operation.none) {
      String lhs = state.leftOperand;
      final canAppend = operandStateValidity(lhs);
      if (canAppend) {
        lhs += event.digit.toString();
      }

      emit(
        state.copyWith(
          leftOperand: lhs,
          status: CalculatorStatus.leftOperandTyping,
        ),
      );
    } else {
      String rhs = state.rightOperand;
      final canAppend = operandStateValidity(rhs);
      if (canAppend) {
        rhs += event.digit.toString();
      }

      emit(
        state.copyWith(
          rightOperand: rhs,
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
          leftOperand: '',
          rightOperand: '',
          result: '0',
          operation: Operation.none),
    );
  }

  void _onOperationTapped(
      OperationTappedEvent event, Emitter<CalculatorState> emit) {
    if (state.operation != Operation.none && state.rightOperand.isNotEmpty) {
      final result = _performOperation(state.operation);
      emit(
        state.copyWith(
          status: CalculatorStatus.leftOperandTyping,
          rightOperand: '',
          leftOperand: result.toString(),
        ),
      );
    }
    emit(state.copyWith(operation: event.operation));
  }

  void _onCalculatorResult(
      CalculateResultEvent event, Emitter<CalculatorState> emit) {
    if (state.leftOperand.isNotEmpty && state.rightOperand.isNotEmpty) {
      final result = _performOperation(state.operation);
      emit(
        state.copyWith(
          result: parseResult(result.toString()),
          leftOperand: parseResult(result.toString()),
          rightOperand: '',
          status: CalculatorStatus.done,
        ),
      );
    }
  }

  void _onPercentageTapped(
      PercentageTappedEvent event, Emitter<CalculatorState> emit) {
    if (state.status == CalculatorStatus.leftOperandTyping) {
      if (state.leftOperand.isNotEmpty) {
        final lhs = double.parse(state.leftOperand);
        final value = lhs / 100.0;
        emit(
          state.copyWith(
            result: parseResult(value.toString()),
            leftOperand: value.toString(),
            status: CalculatorStatus.done,
          ),
        );
      }
    } else {
      if (state.rightOperand.isEmpty) {
        final result = double.parse(state.result);

        final value = result / 100.0;
        emit(
          state.copyWith(
            result: parseResult(value.toString()),
          ),
        );
      } else {
        final rhs = double.parse(state.rightOperand);
        final value = rhs / 100.0;
        emit(
          state.copyWith(
            result: parseResult(value.toString()),
          ),
        );
      }
    }
  }

  void _onDecimalTapped(
      DecimalTappedEvent event, Emitter<CalculatorState> emit) {
    if (state.operation == Operation.none) {
      if (!state.leftOperand.contains('.')) {
        String lhs = state.leftOperand;
        if (lhs.isEmpty) {
          lhs += '0.';
        } else if (lhs.length < 10) {
          lhs += '.';
        }

        emit(
          state.copyWith(
            leftOperand: lhs,
            status: CalculatorStatus.leftOperandTyping,
          ),
        );
      }
    } else {
      if (!state.rightOperand.contains('.')) {
        String rhs = state.rightOperand;
        if (rhs.isEmpty) {
          rhs += '0.';
        } else if (rhs.length < 10) {
          rhs += '.';
        }

        emit(
          state.copyWith(
            rightOperand: rhs,
            status: CalculatorStatus.rightOperandTyping,
          ),
        );
      }
    }
  }

  void _onPlusMinusTapped(
      PlusMinusTappedEvent event, Emitter<CalculatorState> emit) {
    String minus = '-';
    if (state.operation == Operation.none) {
      String lhs = state.leftOperand;

      if (lhs.startsWith('-')) {
        // remove minus sign
        lhs = lhs.split('-')[1];
        emit(
          state.copyWith(
            leftOperand: lhs,
            status: CalculatorStatus.leftOperandTyping,
          ),
        );
      } else {
        emit(
          state.copyWith(
            leftOperand: minus + lhs,
            status: CalculatorStatus.leftOperandTyping,
          ),
        );
      }
    } else {
      String rhs = state.rightOperand;
      if (rhs.startsWith('-')) {
        // remove minus sign
        rhs = rhs.split('-')[1];
        emit(
          state.copyWith(
            rightOperand: rhs,
            status: CalculatorStatus.leftOperandTyping,
          ),
        );
      } else {
        emit(
          state.copyWith(
            rightOperand: minus + rhs,
            status: CalculatorStatus.leftOperandTyping,
          ),
        );
      }
    }
  }

  double _performOperation(Operation operation) {
    final double lhs = double.parse(state.leftOperand);
    final double rhs = double.parse(state.rightOperand);
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
        result = double.parse((lhs * rhs).toStringAsFixed(6));
        return result;
      case Operation.divide:
        result = double.parse((lhs / rhs).toStringAsFixed(6));

        return result;
    }
  }

  bool operandStateValidity(String operandStateValue) {
    return (operandStateValue.contains('.') && operandStateValue.length < 10) ||
        (operandStateValue.length < 9);
  }

  String parseResult(String result) {
    return result.length > 9
        ? double.parse(result).toStringAsExponential(5)
        : result.toString();
  }
}
