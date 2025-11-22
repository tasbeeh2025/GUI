import 'package:sysguard/data/model/system_stats_model.dart';

abstract class SystemRemoteDataSource {
  Future<SystemStatsModel> fetchSystemStats();
}
