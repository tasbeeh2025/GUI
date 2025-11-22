import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysguard/domain/usecases/get_system_stats.dart';
import 'package:sysguard/presentation/bloc/system_state.dart';

class SystemCubit extends Cubit<SystemState> {
  final GetSystemStatsUseCase usecase;
  Timer? _timer;
  double x = 0;
  // bool _firstLoad = true; // track first load

  SystemCubit(this.usecase) : super(SystemState(cpuHistory: [])) {
    _startAutoRefresh();
  }

  Future<void> loadStats({bool showLoading = false}) async {
    if (showLoading) emit(SystemState(loading: true, cpuHistory: []));

    try {
      final data = await usecase();
      final newY = data.cpuUsage; // or the real CPU %
      x++;

      final List<FlSpot> newList = List<FlSpot>.from(state.cpuHistory ?? [])
        ..add(FlSpot(x, newY));

      // keep only last 30 points
      if (newList.length > 30) newList.removeAt(0);

      emit(SystemState(stats: data, cpuHistory: newList));
      // print("Emitted new state with CPU: ${newList}");
    } catch (e) {
      emit(
        SystemState(error: e.toString(), cpuHistory: state.cpuHistory ?? []),
      );
    } finally {
      // _firstLoad = false;
    }
  }

  void _startAutoRefresh() {
    // first fetch with loading indicator
    loadStats(showLoading: true);

    // refresh every 5 seconds WITHOUT loading indicator
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      loadStats(showLoading: false);
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
