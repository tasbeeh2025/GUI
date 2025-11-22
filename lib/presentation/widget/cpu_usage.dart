import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:sysguard/core/app_const.dart';

class CpuUsage extends StatelessWidget {
  const CpuUsage({super.key, required this.cpu, required this.cpuHistory});
  final double cpu;
  final List<FlSpot> cpuHistory;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 600,
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
              "CPU Usage",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 12.0),
            SizedBox(
              width: 400,
              height: 150,
              child: LineChart(
                LineChartData(
                  borderData: FlBorderData(show: false),
                  backgroundColor: AppConst.primaryColor,
                  minY: 0,
                  maxY: cpuHistory.last.y > 100 ? cpuHistory.last.y : 100,

                  minX: cpuHistory[0].x,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 20,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.white12,
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),

                  lineBarsData: [
                    LineChartBarData(
                      spots: cpuHistory,
                      isCurved: true,
                      color: AppConst.indicatorColor,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              "${cpu.toStringAsFixed(2)}%",
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
