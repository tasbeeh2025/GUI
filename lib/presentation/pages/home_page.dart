import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysguard/presentation/bloc/system_state.dart';
import '../bloc/system_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("System Monitor")),
      body: BlocBuilder<SystemCubit, SystemState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text("Error: ${state.error}"));
          }

          final stats = state.stats;
          if (stats == null) return const SizedBox();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TileWidget(
                  title: "CPU Usage",
                  value: "${stats.cpuUsage.toStringAsFixed(1)}%",
                ),
                _TileWidget(
                  title: "RAM Usage",
                  value: "${stats.ramUsage.toStringAsFixed(1)}%",
                ),
                _TileWidget(
                  title: "Active Processes",
                  value: stats.activeProcesses.toString(),
                ),
                _TileWidget(title: "Alerts", value: stats.alerts.join(", ")),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Helper widget
class _TileWidget extends StatelessWidget {
  final String title;
  final String value;
  const _TileWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(title: Text(title), subtitle: Text(value)),
    );
  }
}
