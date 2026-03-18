import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../bisection_logic.dart';

part 'bisection_state.dart';

class BisectionCubit extends Cubit<BisectionState> {
  BisectionCubit() : super(const BisectionState());

  void calculate({
    required String functionString,
    required String lowerLimitStr,
    required String upperLimitStr,
    required String toleranceStr,
  }) {
    if (functionString.trim().isEmpty ||
        lowerLimitStr.trim().isEmpty ||
        upperLimitStr.trim().isEmpty ||
        toleranceStr.trim().isEmpty) {
      emit(
        state.copyWith(
          status: BisectionStatus.failure,
          errorMessage: 'Todos los campos son obligatorios.',
        ),
      );
      return;
    }

    final double? lowerLimit = double.tryParse(
      lowerLimitStr.trim().replaceAll(',', '.'),
    );
    final double? upperLimit = double.tryParse(
      upperLimitStr.trim().replaceAll(',', '.'),
    );
    final double? tolerance = double.tryParse(
      toleranceStr.trim().replaceAll(',', '.'),
    );

    if (lowerLimit == null || upperLimit == null || tolerance == null) {
      emit(
        state.copyWith(
          status: BisectionStatus.failure,
          errorMessage: 'Por favor, ingresa valores numéricos válidos.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: BisectionStatus.calculating, errorMessage: ''));

    try {
      final logic = BisectionLogic(
        functionString: functionString,
        lowerLimit: lowerLimit,
        upperLimit: upperLimit,
        tolerance: tolerance,
      );

      final results = logic.calculate();

      emit(state.copyWith(status: BisectionStatus.success, results: results));
    } catch (e) {
      emit(
        state.copyWith(
          status: BisectionStatus.failure,
          errorMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  void clear() {
    emit(const BisectionState());
  }
}
