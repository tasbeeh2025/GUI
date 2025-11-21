// models/system_stats_model.dart
import '../../domain/entities/system_stats.dart';

class SystemStatsModel extends SystemStats {
  SystemStatsModel({
    required super.cpuUsage,
    required super.ramUsage,
    required super.activeProcesses,
    required super.alerts,
  });

  factory SystemStatsModel.fromJson({
    required Map<String, dynamic> statusJson,
    required Map<String, dynamic> processJson,
  }) {
    return SystemStatsModel(
      cpuUsage: statusJson["system"]["cpu_percent"]?.toDouble() ?? 0.0,
      ramUsage: statusJson["system"]["memory_percent"]?.toDouble() ?? 0.0,
      activeProcesses: processJson["total"] ?? 0,
      alerts: List<String>.from(statusJson["recent_alerts"] ?? []),
    );
  }
}
