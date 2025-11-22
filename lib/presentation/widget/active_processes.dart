import 'package:flutter/material.dart';
import 'package:sysguard/core/app_const.dart';

class ActiveProcesses extends StatefulWidget {
  const ActiveProcesses({super.key});

  @override
  State<ActiveProcesses> createState() => _ActiveProcessesState();
}

class _ActiveProcessesState extends State<ActiveProcesses> {
  //represed to api
  final List<Map<String, dynamic>> processes = [
    {"pid": 1042, "name": "chrome.exe", "cpu": 12.5, "memory": 5.1},
    {"pid": 2228, "name": "python.exe", "cpu": 25.3, "memory": 3.7},
    {"pid": 3104, "name": "explorer.exe", "cpu": 2.1, "memory": 1.2},
    {"pid": 5678, "name": "vscode.exe", "cpu": 8.9, "memory": 6.8},
    {"pid": 9012, "name": "system.exe", "cpu": 0.8, "memory": 0.5},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppConst.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Active Processes (Top 5)",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              column_titles("PID"),
              column_titles("NAME"),
              column_titles("CPU%"),
              column_titles("MEMORY%"),
            ],
          ),
          Expanded(
            child: ListView.builder(
              // shrinkWrap: true,
              itemBuilder: (context, index) {
                final p = processes[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      data_from_api(p["pid"].toString()),
                      data_from_api(p["name"]),
                      data_from_api(p["cpu"].toString()),
                      data_from_api(p["memory"].toString()),
                    ],
                  ),
                );
              },
              itemCount: processes.length,
            ),
          ),
        ],
      ),
    );
  }
}

Widget column_titles(String text) {
  return Expanded(
    child: Text(
      text,
      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
    ),
  );
}

Widget data_from_api(String text) {
  return Expanded(
    child: Text(text, style: TextStyle(color: Colors.white)),
  );
}
