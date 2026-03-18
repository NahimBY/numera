import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../bisection_logic.dart';

part 'bisection_state.dart';

class BisectionCubit extends Cubit<BisectionState> {
  BisectionCubit() : super(const BisectionState());

  void calculate({
    required String functionString,
    required double lowerLimit,
    required double upperLimit,
    required double tolerance,
  }) {
    emit(state.copyWith(status: BisectionStatus.calculating, errorMessage: ''));

    try {
      final logic = BisectionLogic(
        functionString: functionString,
        lowerLimit: lowerLimit,
        upperLimit: upperLimit,
        tolerance: tolerance,
      );

      final results = logic.calculate();

      emit(state.copyWith(
        status: BisectionStatus.success,
        results: results,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BisectionStatus.failure,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }

  void clear() {
    emit(const BisectionState());
  }
}
