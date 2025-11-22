import 'package:dio/dio.dart';
import 'package:sysguard/data/datasources/system_remote_datasource.dart';
import 'package:sysguard/data/model/system_stats_model.dart';

class SystemRemoteDataSourceImpl implements SystemRemoteDataSource {
  final String baseUrl;

  SystemRemoteDataSourceImpl(this.baseUrl);

  @override
  Future<SystemStatsModel> fetchSystemStats() async {
    final dio = Dio();

    final statusRes = await dio.get('$baseUrl/api/status');
    // test it on linux if error fix it
    // final procRes = await dio.get('$baseUrl/api/processes');

    if (statusRes.statusCode !=
        200 //|| procRes.statusCode != 200
        ) {
      throw Exception("Failed to load");
    }

    final statusJson = statusRes.data; // already Map
    // test it on linux if error fix it
    // final processJson = procRes.data; // already Map

    return SystemStatsModel.fromJson(
      statusJson: statusJson,
      // test it on linux if error fix it
      processJson: {"total": 11111},
    );
  }
}
