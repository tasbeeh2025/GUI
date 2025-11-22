import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysguard/core/app_const.dart';
import 'package:sysguard/domain/repository/system_repo.dart';
import 'package:sysguard/domain/usecases/get_system_stats.dart';
import 'package:sysguard/presentation/bloc/system_state.dart';
import 'package:sysguard/presentation/widget/active_processes.dart';
import 'package:sysguard/presentation/widget/alerts.dart';
import 'package:sysguard/presentation/widget/cpu_usage.dart';
import 'package:sysguard/presentation/widget/ram_usage.dart';
import '../bloc/system_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                  childAspectRatio: 2,
                ),
                children: [
                  CpuUsage(cpu: stats.cpuUsage, cpuHistory: state.cpuHistory!),
                  RamUsage(ram: stats.ramUsage),
                  ActiveProcesses(),
                  WarningCard(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
