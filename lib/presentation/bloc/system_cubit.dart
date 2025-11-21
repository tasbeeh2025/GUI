import 'package:sysguard/presentation/bloc/system_state.dart';

import '../../domain/usecases/get_system_stats.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SystemCubit extends Cubit<SystemState> {
  final GetSystemStatsUseCase usecase;
  SystemCubit(this.usecase) : super(SystemState());

  Future<void> loadStats() async {
    emit(SystemState(loading: true));
    try {
      final data = await usecase();
      emit(SystemState(stats: data));
    } catch (e) {
      emit(SystemState(error: e.toString()));
    }
  }
}
