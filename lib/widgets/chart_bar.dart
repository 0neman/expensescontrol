import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;
  ChartBar(
      {required this.label,
      required this.spendingAmount,
      required this.spendingPctOfTotal});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      return Column(
        children: [
          Container(
              width: 40,
              height: Constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text("${spendingAmount.toStringAsFixed(0)} DA"))),
          SizedBox(
            height: Constraints.maxHeight * 0.05,
          ),
          Container(
            height: Constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(220, 220, 220, 1),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(220, 220, 220, 1),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: Constraints.maxHeight * 0.05,
          ),
          Container(
              height: Constraints.maxHeight * 0.10,
              child: FittedBox(child: Text(label))),
        ],
      );
    });
  }
}
