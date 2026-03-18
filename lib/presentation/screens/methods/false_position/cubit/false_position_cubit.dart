import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../false_position_logic.dart';

part 'false_position_state.dart';

class FalsePositionCubit extends Cubit<FalsePositionState> {
  FalsePositionCubit() : super(const FalsePositionState());

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
          status: FalsePositionStatus.failure,
          errorMessage: 'Todos los campos son obligatorios.',
        ),
      );
      return;
    }

    final double? lowerLimit =
        double.tryParse(lowerLimitStr.trim().replaceAll(',', '.'));
    final double? upperLimit =
        double.tryParse(upperLimitStr.trim().replaceAll(',', '.'));
    final double? tolerance =
        double.tryParse(toleranceStr.trim().replaceAll(',', '.'));

    if (lowerLimit == null || upperLimit == null || tolerance == null) {
      emit(
        state.copyWith(
          status: FalsePositionStatus.failure,
          errorMessage: 'Por favor, ingresa valores numéricos válidos.',
        ),
      );
      return;
    }

    if (tolerance <= 0) {
      emit(
        state.copyWith(
          status: FalsePositionStatus.failure,
          errorMessage: 'La tolerancia debe ser mayor que cero.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: FalsePositionStatus.calculating,
        errorMessage: '',
      ),
    );

    try {
      final logic = FalsePositionLogic(
        functionString: functionString,
        lowerLimit: lowerLimit,
        upperLimit: upperLimit,
        tolerance: tolerance,
      );

      final results = logic.calculate();

      emit(
        state.copyWith(
          status: FalsePositionStatus.success,
          results: results,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FalsePositionStatus.failure,
          errorMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  void clear() {
    emit(const FalsePositionState());
  }
}

