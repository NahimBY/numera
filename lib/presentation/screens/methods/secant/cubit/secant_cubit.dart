import 'package:flutter_bloc/flutter_bloc.dart';
import 'secant_state.dart';
import '../secant_logic.dart';

class SecantCubit extends Cubit<SecantState> {
  final SecantLogic _logic;

  SecantCubit(this._logic) : super(SecantInitial());

  void calculate({
    required String function,
    required String x0Str,
    required String x1Str,
    required String toleranceStr,
    required String maxIterationsStr,
  }) {
    // 1. Validar que no haya campos vacíos
    if (function.trim().isEmpty || 
        x0Str.trim().isEmpty || 
        x1Str.trim().isEmpty || 
        toleranceStr.trim().isEmpty || 
        maxIterationsStr.trim().isEmpty) {
      emit(const SecantError('Todos los campos son obligatorios.'));
      return;
    }

    // 2. Validar tipos de datos
    final double? x0 = double.tryParse(x0Str.trim());
    final double? x1 = double.tryParse(x1Str.trim());
    final double? tolerance = double.tryParse(toleranceStr.trim());
    final int? maxIterations = int.tryParse(maxIterationsStr.trim());

    if (x0 == null || x1 == null || tolerance == null || maxIterations == null) {
      emit(const SecantError('Por favor, ingresa valores numéricos válidos.'));
      return;
    }

    if (maxIterations <= 0) {
      emit(const SecantError('Las iteraciones deben ser un número entero mayor a cero.'));
      return;
    }

    if (tolerance <= 0) {
      emit(const SecantError('La tolerancia debe ser mayor a cero.'));
      return;
    }

    emit(SecantCalculating());

    try {
      final iterations = _logic.calculate(
        function: function,
        x0: x0,
        x1: x1,
        tolerance: tolerance,
        maxIterations: maxIterations,
      );

      if (iterations.isEmpty) {
        emit(const SecantError('No se pudo calcular la raíz.'));
        return;
      }

      final last = iterations.last;

      emit(SecantSuccess(
        iterations: iterations,
        root: last.xiPlus1,
        finalError: last.error,
        totalIterations: iterations.length,
      ));
    } catch (e) {
      emit(SecantError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  void clear() {
    emit(SecantInitial());
  }
}
