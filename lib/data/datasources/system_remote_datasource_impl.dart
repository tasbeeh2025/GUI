import 'dart:convert';

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
    final procRes = await dio.get('$baseUrl/api/processes');

    if (statusRes.statusCode != 200 || procRes.statusCode != 200) {
      throw Exception("Failed to load");
    }

    final statusJson = jsonDecode(statusRes.data);
    final processJson = jsonDecode(procRes.data);

    return SystemStatsModel.fromJson(
      statusJson: statusJson,
      processJson: processJson,
    );
  }
}
