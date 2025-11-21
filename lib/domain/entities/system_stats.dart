class SystemStats {
  final double cpuUsage;
  final double ramUsage;
  final int activeProcesses;
  final List<String> alerts;

  SystemStats({
    required this.cpuUsage,
    required this.ramUsage,
    required this.activeProcesses,
    required this.alerts,
  });
}
