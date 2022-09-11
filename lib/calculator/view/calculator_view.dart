import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calculator/calculator/bloc/calculator_bloc.dart';

import '../widgets/widgets.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<CalculatorBloc, CalculatorState>(
            builder: (context, state) {
          final isLeftHandTyping =
              state.status == CalculatorStatus.leftOperandTyping;
          return Padding(
            padding: const EdgeInsets.all(0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.status == CalculatorStatus.initial ||
                      state.status == CalculatorStatus.done)
                    _DisplayText(text: state.result.toString()),
                  if (state.status == CalculatorStatus.leftOperandTyping)
                    _DisplayText(text: state.leftOperand.toStringAsFixed(0)),
                  if (state.status == CalculatorStatus.rightOperandTyping)
                    _DisplayText(text: state.rightOperand.toStringAsFixed(0)),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Button(
                                text: 'C',
                                backgroundColor: Color(0xFFA8A6A3),
                                onTap: () => context
                                    .read<CalculatorBloc>()
                                    .add(CalculatorResetEvent()),
                              ),
                              Button(
                                text: '+/-',
                                backgroundColor: Color(0xFFA8A6A3),
                              ),
                              Button(
                                text: '%',
                                backgroundColor: Color(0xFFA8A6A3),
                              ),
                              OperatorButton(
                                isSelected:
                                    (state.operation == Operation.divide),
                                operation: Operation.divide,
                                onOperationTapped: () => context
                                    .read<CalculatorBloc>()
                                    .add(
                                        OperationTappedEvent(Operation.divide)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Button(
                                text: '7',
                                onTap: () => context
                                    .read<CalculatorBloc>()
                                    .add(DigitTappedEvent(7)),
                              ),
                              Button(
                                text: '8',
                                onTap: () => context
                                    .read<CalculatorBloc>()
                                    .add(DigitTappedEvent(8)),
                              ),
                              Button(
                                text: '9',
                                onTap: () => context
                                    .read<CalculatorBloc>()
                                    .add(DigitTappedEvent(9)),
                              ),
                              OperatorButton(
                                isSelected:
                                    (state.operation == Operation.multiply),
                                operation: Operation.multiply,
                                onOperationTapped: () => context
                                    .read<CalculatorBloc>()
                                    .add(OperationTappedEvent(
                                        Operation.multiply)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Button(
                                text: '4',
                                onTap: () => context
                                    .read<CalculatorBloc>()
                                    .add(DigitTappedEvent(4)),
                              ),
                              Button(
                                text: '5',
                                onTap: () => context
                                    .read<CalculatorBloc>()
                                    .add(DigitTappedEvent(5)),
                              ),
                              Button(
                                text: '6',
                                onTap: () => context
                                    .read<CalculatorBloc>()
                                    .add(DigitTappedEvent(6)),
                              ),
                              OperatorButton(
                                isSelected:
                                    (state.operation == Operation.subtract),
                                operation: Operation.subtract,
                                onOperationTapped: () => context
                                    .read<CalculatorBloc>()
                                    .add(OperationTappedEvent(
                                        Operation.subtract)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Button(
                                text: '1',
                                onTap: () => context
                                    .read<CalculatorBloc>()
                                    .add(DigitTappedEvent(1)),
                              ),
                              Button(
                                text: '2',
                                onTap: () => context
                                    .read<CalculatorBloc>()
                                    .add(DigitTappedEvent(2)),
                              ),
                              Button(
                                text: '3',
                                onTap: () => context
                                    .read<CalculatorBloc>()
                                    .add(DigitTappedEvent(3)),
                              ),
                              OperatorButton(
                                isSelected: (state.operation == Operation.add),
                                operation: Operation.add,
                                onOperationTapped: () => context
                                    .read<CalculatorBloc>()
                                    .add(OperationTappedEvent(Operation.add)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Button(
                                text: '0',
                                isLarge: true,
                                onTap: () => context
                                    .read<CalculatorBloc>()
                                    .add(DigitTappedEvent(0)),
                              ),
                              Button(text: '.'),
                              Button(
                                text: '=',
                                backgroundColor: Colors.orange,
                                onTap: () => context
                                    .read<CalculatorBloc>()
                                    .add(CalculateResultEvent()),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _DisplayText extends StatelessWidget {
  const _DisplayText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Container(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.white),
            ),
          ),
        ));
  }
}
