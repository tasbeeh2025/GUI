// repository/system_repo_impl.dart
import '../datasources/system_remote_datasource.dart';
import '../../domain/entities/system_stats.dart';
import '../../domain/repository/system_repo.dart';

class SystemRepositoryImpl implements SystemRepository {
  final SystemRemoteDataSource remote;

  SystemRepositoryImpl(this.remote);

  @override
  Future<SystemStats> getSystemStats() async {
    return await remote.fetchSystemStats();
  }
}
