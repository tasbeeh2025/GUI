import 'package:fl_chart/fl_chart.dart';
import 'package:sysguard/domain/entities/system_stats.dart';

class SystemState {
  final bool loading;
  final SystemStats? stats;
  final String? error;
  final List<FlSpot>? cpuHistory;
  SystemState({
    this.loading = false,
    this.stats,
    this.error,
    required this.cpuHistory,
  });
  SystemState copyWith({List<FlSpot>? cpuHistory}) {
    return SystemState(cpuHistory: cpuHistory ?? this.cpuHistory);
  }
}
