import 'package:flutter/material.dart';
import 'package:sysguard/core/app_const.dart';

class WarningCard extends StatelessWidget {
  const WarningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppConst.primaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppConst.warrningColor, width: 1.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "System Warnings",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 12),
          warningCard("High CPU usage detected: 92%"),
          SizedBox(height: 4),
          warningCard("Memory near limit: 85%"),
          SizedBox(height: 4),
          warningCard("Disk space low: 15% remaining"),
        ],
      ),
    );
  }
}

Widget warningCard(String text) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: AppConst.warrningBackgroundColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppConst.warrningColor, width: 1.3),
    ),
    child: Row(
      children: [
        Icon(
          Icons.warning_amber_rounded,
          color: AppConst.warrningColor,
          size: 26,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ],
    ),
  );
}
