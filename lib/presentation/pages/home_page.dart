import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysguard/domain/repository/system_repo.dart';
import 'package:sysguard/domain/usecases/get_system_stats.dart';
import 'package:sysguard/presentation/bloc/system_state.dart';
import 'package:sysguard/presentation/widget/active_processes.dart';
import 'package:sysguard/presentation/widget/alerts.dart';
import '../bloc/system_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("System Monitor")),
      body: BlocProvider(
        create: (context) => SystemCubit(
          GetSystemStatsUseCase(
            RepositoryProvider.of<SystemRepository>(context),
          ),
        )..loadStats(),
        child: BlocBuilder<SystemCubit, SystemState>(
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
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                   childAspectRatio: 3,
                ),
                children: [
                  ActiveProcesses(),
                  WarningCard(),
                  // _TileWidget(
                  //   title: "CPU Usage",
                  //   value: "${stats.cpuUsage.toStringAsFixed(1)}%",
                  // ),
                  // _TileWidget(
                  //   title: "RAM Usage",
                  //   value: "${stats.ramUsage.toStringAsFixed(1)}%",
                  // ),
                  // _TileWidget(
                  //   title: "Active Processes",
                  //   value: stats.activeProcesses.toString(),
                  // ),
                  // _TileWidget(title: "Alerts", value: stats.alerts.join(", ")),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
