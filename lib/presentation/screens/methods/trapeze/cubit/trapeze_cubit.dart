import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../trapeze_logic.dart';

part 'trapeze_state.dart';

class TrapezeCubit extends Cubit<TrapezeState> {
  TrapezeCubit() : super(const TrapezeState());

  void calculate({
    required String functionString,
    required String lowerLimitStr,
    required String upperLimitStr,
    required String nStr,
  }) {
    if (functionString.trim().isEmpty ||
        lowerLimitStr.trim().isEmpty ||
        upperLimitStr.trim().isEmpty ||
        nStr.trim().isEmpty) {
      emit(
        state.copyWith(
          status: TrapezeStatus.failure,
          errorMessage: 'Todos los campos son obligatorios.',
        ),
      );
      return;
    }

    final double? lowerLimit =
        double.tryParse(lowerLimitStr.trim().replaceAll(',', '.'));
    final double? upperLimit =
        double.tryParse(upperLimitStr.trim().replaceAll(',', '.'));
    final int? n = int.tryParse(nStr.trim());

    if (lowerLimit == null || upperLimit == null || n == null) {
      emit(
        state.copyWith(
          status: TrapezeStatus.failure,
          errorMessage: 'Por favor, ingresa valores numéricos válidos.',
        ),
      );
      return;
    }

    if (n <= 0) {
      emit(
        state.copyWith(
          status: TrapezeStatus.failure,
          errorMessage:
              'El número de subintervalos (n) debe ser un entero mayor que cero.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: TrapezeStatus.calculating,
        errorMessage: '',
      ),
    );

    try {
      final logic = TrapezeLogic(
        functionString: functionString,
        lowerLimit: lowerLimit,
        upperLimit: upperLimit,
        n: n,
      );

      final (integral, iterations) = logic.calculate();

      emit(
        state.copyWith(
          status: TrapezeStatus.success,
          integralResult: integral,
          iterations: iterations,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TrapezeStatus.failure,
          errorMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  void clear() {
    emit(const TrapezeState());
  }
}

