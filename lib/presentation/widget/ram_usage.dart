import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:sysguard/core/app_const.dart';

class RamUsage extends StatelessWidget {
  const RamUsage({super.key, required this.ram});
  final double ram;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: 300,
      decoration: BoxDecoration(
        color: AppConst.primaryColor,
        border: Border.all(color: const Color(0xFF000000)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ram Usage",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 12.0),
            SizedBox(
              height: 40,
              child: RotatedBox(
                quarterTurns: 3,
                child: BarChart(
                  BarChartData(
                    maxY: 100,
                    minY: 0,
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: ram,
                            width: 20,
                            color: AppConst.indicatorColor,
                            borderRadius: BorderRadius.circular(8),
                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              toY: 100,
                              color: Colors.white12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              "${ram.toStringAsFixed(2)}%",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              "Graph updates every 2 second",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white38),
            ),
          ],
        ),
      ),
    );
  }
}
