import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:project20/core/utils.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/widgets/texts/text_r.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.income,
    required this.expense,
  });

  final int income;
  final int expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      decoration: BoxDecoration(
        color: AppColors.main,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Stack(
        children: [
          // LINE CHART
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 50),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      isStrokeCapRound: true,
                      isCurved: true,
                      color: AppColors.text1,
                      barWidth: 7,
                      dotData: const FlDotData(show: false), // Hide dots
                      belowBarData: BarAreaData(
                        show: false, // Hide shaded area below the line
                      ),
                      spots: [
                        FlSpot(0, normalizeIncomes(1)),
                        FlSpot(1, normalizeIncomes(2)),
                        FlSpot(2, normalizeIncomes(3)),
                        FlSpot(3, normalizeIncomes(4)),
                        FlSpot(4, normalizeIncomes(5)),
                        FlSpot(5, normalizeIncomes(6)),
                        FlSpot(6, normalizeIncomes(7)),
                        FlSpot(7, normalizeIncomes(8)),
                        FlSpot(8, normalizeIncomes(9)),
                        FlSpot(9, normalizeIncomes(10)),
                        FlSpot(10, normalizeIncomes(11)),
                        FlSpot(11, normalizeIncomes(12)),
                      ],
                    ),
                  ],
                  titlesData: const FlTitlesData(
                    show: false, // Hide labels on x and y axis
                  ),
                  gridData: const FlGridData(show: false), // Hide grid lines
                  borderData: FlBorderData(show: false), // Hide border lines
                  minY: 0, // Minimum y-value
                  maxY: 24, // Maximum y-value with padding added
                ),
              ),
            ),
          ),

          const Positioned(
            top: 28,
            left: 23,
            child: TextR('Available balance', fontSize: 16),
          ),
          Positioned(
            top: 65,
            left: 23,
            child: TextM('\$${income - expense}', fontSize: 32),
          ),
          Positioned(
            bottom: 18,
            left: 45,
            child: Row(
              children: [
                TextM(
                  'Income \$$income',
                  fontSize: 16,
                  color: AppColors.text2,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 18,
            right: 45,
            child: Row(
              children: [
                TextM(
                  'Expense \$$expense',
                  fontSize: 16,
                  color: AppColors.text2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
