import 'package:flutter/material.dart';
import 'package:flutter_calculator/calculator/bloc/calculator_bloc.dart';

class OperatorButton extends StatelessWidget {
  const OperatorButton({
    Key? key,
    this.onOperationTapped,
    this.operation = Operation.none,
    this.isSelected = false,
  }) : super(key: key);
  final Operation operation;
  final VoidCallback? onOperationTapped;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    String text = '';
    // Widget icon = Icon(Icons)
    switch (operation) {
      case Operation.add:
        {
          text = '+';
          break;
        }
      case Operation.none:
        break;
      case Operation.subtract:
        text = '−';
        break;
      case Operation.multiply:
        text = '×';
        break;
      case Operation.divide:
        text = '÷';
        break;
    }
    return GestureDetector(
      onTap: onOperationTapped,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.orange,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: isSelected ? Colors.orange : Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
