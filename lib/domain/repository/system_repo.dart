import 'package:sysguard/domain/entities/system_stats.dart';

abstract class SystemRepository {
  Future<SystemStats> getSystemStats();
}
