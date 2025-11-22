import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysguard/core/app_const.dart';
import 'package:sysguard/data/datasources/system_remote_datasource.dart';
import 'package:sysguard/data/datasources/system_remote_datasource_impl.dart';
import 'package:sysguard/data/repository/system_repo_impl.dart';
import 'package:sysguard/domain/repository/system_repo.dart';

import 'package:sysguard/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConst.appName,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<SystemRemoteDataSource>(
            create: (_) => SystemRemoteDataSourceImpl("http://localhost:8080"),
          ),
          RepositoryProvider<SystemRepository>(
            create: (context) =>
                SystemRepositoryImpl(context.read<SystemRemoteDataSource>()),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}
