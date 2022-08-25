import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calculator/calculator/bloc/calculator_bloc.dart';
import 'package:flutter_calculator/calculator/widgets/digit_button.dart';
import 'package:flutter_calculator/calculator/widgets/operator_widget.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<CalculatorBloc, CalculatorState>(
          builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is CalculatorInitial)
                Text(
                  state.result,
                  style: textTheme.headline3!.copyWith(color: Colors.white),
                ),
              if (state is CalculatorTyping &&
                  state.operation == Operation.none)
                Text(
                  state.leftOperand,
                  style: textTheme.headline3!.copyWith(color: Colors.white),
                ),
              if (state is CalculatorTyping &&
                  state.operation != Operation.none)
                Text(
                  state.rightOperand,
                  style: textTheme.headline3!.copyWith(color: Colors.white),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DigitButton(
                    digit: 1,
                    onDigitTapped: () => context.read<CalculatorBloc>()
                      ..add(DigitTappedEvent('1')),
                  ),
                  DigitButton(
                    digit: 2,
                    onDigitTapped: () => context.read<CalculatorBloc>()
                      ..add(DigitTappedEvent('2')),
                  ),
                  DigitButton(
                    digit: 3,
                    onDigitTapped: () => context.read<CalculatorBloc>()
                      ..add(DigitTappedEvent('3')),
                  ),
                  DigitButton(
                    digit: 4,
                    onDigitTapped: () => context.read<CalculatorBloc>()
                      ..add(CalculatorResetEvent()),
                  ),
                ],
              ),
              Row(
                children: [
                  OperatorButton(
                    isSelected: state.operation == Operation.add,
                    operation: Operation.add,
                    onOperationTapped: () => context.read<CalculatorBloc>()
                      ..add(OperationTappedEvent(Operation.add)),
                  ),
                  OperatorButton(
                    operation: Operation.subtract,
                  ),
                  OperatorButton(
                    operation: Operation.multiply,
                  ),
                  OperatorButton(
                    operation: Operation.divide,
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
