import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysguard/domain/usecases/get_system_stats.dart';
import 'package:sysguard/presentation/bloc/system_state.dart';

class SystemCubit extends Cubit<SystemState> {
  final GetSystemStatsUseCase usecase;
  Timer? _timer;
  // bool _firstLoad = true; // track first load

  SystemCubit(this.usecase) : super(SystemState()) {
    _startAutoRefresh();
  }

  Future<void> loadStats({bool showLoading = false}) async {
    if (showLoading) emit(SystemState(loading: true));

    try {
      final data = await usecase();
      emit(SystemState(stats: data));
    } catch (e) {
      emit(SystemState(error: e.toString()));
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
