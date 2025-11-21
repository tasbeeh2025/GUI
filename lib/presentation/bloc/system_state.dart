import 'package:sysguard/domain/entities/system_stats.dart';

class SystemState {
  final bool loading;
  final SystemStats? stats;
  final String? error;
  SystemState({this.loading = false, this.stats, this.error});
}
