import 'package:math_expressions/math_expressions.dart';

class FalsePositionIteration {
  final int iteration;
  final double a;
  final double b;
  final double c;
  final double fa;
  final double fb;
  final double fc;
  final double error;

  FalsePositionIteration({
    required this.iteration,
    required this.a,
    required this.b,
    required this.c,
    required this.fa,
    required this.fb,
    required this.fc,
    required this.error,
  });
}

class FalsePositionLogic {
  final String functionString;
  final double lowerLimit;
  final double upperLimit;
  final double tolerance;
  final int maxIterations;

  FalsePositionLogic({
    required this.functionString,
    required this.lowerLimit,
    required this.upperLimit,
    required this.tolerance,
    this.maxIterations = 100,
  });

  double _evaluateFunction(double xValue) {
    final Parser p = Parser();
    final Expression exp = p.parse(functionString.replaceAll('X', 'x'));
    final ContextModel cm = ContextModel()
      ..bindVariable(Variable('x'), Number(xValue))
      ..bindVariable(Variable('e'), Number(2.718281828459045))
      ..bindVariable(Variable('pi'), Number(3.141592653589793));

    return exp.evaluate(EvaluationType.REAL, cm);
  }

  /// Ejecuta el método de Falsa Posición (Regula Falsi).
  /// Lanza excepciones con mensajes amigables en caso de errores.
  List<FalsePositionIteration> calculate() {
    double a = lowerLimit;
    double b = upperLimit;

    if (a == b) {
      throw Exception('Los límites no pueden ser iguales.');
    }

    if (a > b) {
      final double temp = a;
      a = b;
      b = temp;
    }

    double fa;
    double fb;

    try {
      fa = _evaluateFunction(a);
      fb = _evaluateFunction(b);
    } catch (e) {
      throw Exception(
        'Expresión matemática inválida. Verifica la sintaxis de la función.',
      );
    }

    if (fa == 0.0) {
      return [
        FalsePositionIteration(
          iteration: 1,
          a: a,
          b: b,
          c: a,
          fa: fa,
          fb: fb,
          fc: fa,
          error: 0.0,
        ),
      ];
    }

    if (fb == 0.0) {
      return [
        FalsePositionIteration(
          iteration: 1,
          a: a,
          b: b,
          c: b,
          fa: fa,
          fb: fb,
          fc: fb,
          error: 0.0,
        ),
      ];
    }

    if (fa * fb > 0) {
      throw Exception(
        'No hay garantía de raíz en este intervalo: f(a) y f(b) tienen el mismo signo.',
      );
    }

    final List<FalsePositionIteration> iterations = [];
    double error = double.infinity;
    double previousC = 0.0;
    int i = 1;

    while (i <= maxIterations) {
      final double denominator = (fb - fa);

      if (denominator == 0.0 || denominator.abs() < 1e-15) {
        throw Exception(
          'División por cero detectada. Verifica que la función cambie de signo en el intervalo.',
        );
      }

      final double c = b - fb * (b - a) / denominator;
      final double fc = _evaluateFunction(c);

      if (i > 1) {
        error = c != 0
            ? ((c - previousC) / c).abs()
            : (c - previousC).abs();
      } else {
        error = double.infinity;
      }

      iterations.add(
        FalsePositionIteration(
          iteration: i,
          a: a,
          b: b,
          c: c,
          fa: fa,
          fb: fb,
          fc: fc,
          error: error,
        ),
      );

      if (fc.abs() < tolerance) {
        break;
      }

      if (i > 1 && error <= tolerance) {
        break;
      }

      if (fa * fc < 0) {
        b = c;
        fb = fc;
      } else {
        a = c;
        fa = fc;
      }

      previousC = c;
      i++;
    }

    return iterations;
  }
}
