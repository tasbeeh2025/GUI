import 'package:sysguard/domain/entities/system_stats.dart';
import 'package:sysguard/domain/repository/system_repo.dart';

class GetSystemStatsUseCase {
  final SystemRepository repo;
  GetSystemStatsUseCase(this.repo);

  Future<SystemStats> call() async {
    return await repo.getSystemStats();
  }
}
