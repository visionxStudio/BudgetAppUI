import 'package:budgetapp/data/data.dart';
import 'package:budgetapp/models/category_model.dart';
import 'package:budgetapp/models/expense_model.dart';
import 'package:budgetapp/widgets/bar_chart.dart';
import 'package:flutter/material.dart';

import 'categorypage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  _buildCategory(Category category, double totalAmountSpend) {
    Color? determineColor() {
      final spendPercentage =
          (category.maxAmount! - totalAmountSpend) / category.maxAmount!;
      if (spendPercentage > 0.4 && spendPercentage < 0.7) {
        return Colors.orange;
      } else if (spendPercentage > 0.7) {
        return Colors.redAccent;
      } else {
        return Colors.green;
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CategoryScreen(category: category)));
      },
      child: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name!,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
                Text(
                  "\$${(category.maxAmount! - totalAmountSpend).toStringAsFixed(2)} / \$${(category.maxAmount!).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double maxBarWidth = constraints.maxWidth;
                final double percent =
                    (category.maxAmount! - totalAmountSpend) /
                        category.maxAmount!;
                double barWidth = percent * maxBarWidth;
                if (barWidth < 0) {
                  barWidth = 0;
                }
                return Stack(
                  children: [
                    Container(
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    Container(
                      height: 20.0,
                      width: barWidth,
                      decoration: BoxDecoration(
                        color: determineColor(),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            forceElevated: true,
            floating: true,
            expandedHeight: 100.0,
            leading: IconButton(
              onPressed: () {},
              iconSize: 30.0,
              icon: Icon(Icons.settings),
            ),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "BUDGET APP UI",
                style: TextStyle(letterSpacing: 1.2),
              ),
              centerTitle: true,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                iconSize: 30.0,
                icon: Icon(Icons.add),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BarChart(
                        expenses: weeklySpending,
                      ),
                    ),
                  );
                } else {
                  final Category category = categories[index - 1];
                  double totalAmountSpend = 0;
                  category.expenses!.forEach((Expense expense) {
                    totalAmountSpend += expense.cost!;
                  });
                  return _buildCategory(category, totalAmountSpend);
                }
              },
              childCount: 1 + categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
