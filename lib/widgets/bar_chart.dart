import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<double>? expenses;

  const BarChart({Key? key, this.expenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    expenses!.forEach((double price) {
      if (price > mostExpensive) {
        mostExpensive = price;
      }
    });
    return Column(
      children: [
        Text(
          "Weekly Spending",
          style: TextStyle(
            fontSize: 20.0,
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            Text(
              'Nov 10 2021 - Noc 16 2021',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Bar(
              label: 'Sun',
              amountSpend: expenses![0],
              mostExpensive: mostExpensive,
            ),
            Bar(
              label: 'Mon',
              amountSpend: expenses![1],
              mostExpensive: mostExpensive,
            ),
            Bar(
              label: 'Tue',
              amountSpend: expenses![2],
              mostExpensive: mostExpensive,
            ),
            Bar(
              label: 'Wed',
              amountSpend: expenses![3],
              mostExpensive: mostExpensive,
            ),
            Bar(
              label: 'Thu',
              amountSpend: expenses![4],
              mostExpensive: mostExpensive,
            ),
            Bar(
              label: 'Fri',
              amountSpend: expenses![5],
              mostExpensive: mostExpensive,
            ),
            Bar(
              label: 'Sat',
              amountSpend: expenses![6],
              mostExpensive: mostExpensive,
            ),
          ],
        ),
      ],
    );
  }
}

class Bar extends StatelessWidget {
  final String? label;
  final double? amountSpend;
  final double? mostExpensive;
  final _maxBarHeight = 150.0;

  const Bar({
    Key? key,
    @required this.label,
    @required this.amountSpend,
    @required this.mostExpensive,
  }) : super(key: key);

  Color? determineColor() {
    final spendPercentage = amountSpend! / mostExpensive!;
    if (spendPercentage > 0.4 && spendPercentage < 0.8) {
      return Colors.orange;
    } else if (spendPercentage > 0.8) {
      return Colors.redAccent;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpend! / mostExpensive! * _maxBarHeight;
    return Column(
      children: [
        Text(
          "\$${amountSpend!.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),
        ),
        SizedBox(
          height: 6.0,
        ),
        Container(
          decoration: BoxDecoration(
            color: determineColor(),
            borderRadius: BorderRadius.circular(6.0),
          ),
          height: barHeight,
          width: 18.0,
        ),
        SizedBox(
          height: 6.0,
        ),
        Text(
          label!,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
