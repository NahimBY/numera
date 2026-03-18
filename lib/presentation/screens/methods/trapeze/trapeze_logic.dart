import 'package:math_expressions/math_expressions.dart';

class TrapezeIteration {
  final int index;
  final double x;
  final double fx;

  TrapezeIteration({
    required this.index,
    required this.x,
    required this.fx,
  });
}

class TrapezeLogic {
  final String functionString;
  final double lowerLimit;
  final double upperLimit;
  final int n; // número de subintervalos

  TrapezeLogic({
    required this.functionString,
    required this.lowerLimit,
    required this.upperLimit,
    required this.n,
  }) : assert(n > 0, 'El número de subintervalos debe ser mayor que cero');

  double _evaluateFunction(double xValue) {
    final Parser p = Parser();
    final Expression exp = p.parse(functionString.replaceAll('X', 'x'));
    final ContextModel cm = ContextModel()
      ..bindVariable(Variable('x'), Number(xValue))
      ..bindVariable(Variable('e'), Number(2.718281828459045))
      ..bindVariable(Variable('pi'), Number(3.141592653589793));

    return exp.evaluate(EvaluationType.REAL, cm);
  }

  /// Ejecuta la Regla del Trapecio compuesta.
  /// Devuelve la aproximación de la integral y la tabla de puntos evaluados.
  (double integral, List<TrapezeIteration> iterations) calculate() {
    final double a = lowerLimit;
    final double b = upperLimit;

    if (a == b) {
      throw Exception('Los límites de integración no pueden ser iguales.');
    }

    if (n <= 0) {
      throw Exception('El número de subintervalos debe ser mayor que cero.');
    }

    final double h = (b - a) / n;
    final List<TrapezeIteration> table = [];

    double sumInterior = 0;

    try {
      for (int i = 0; i <= n; i++) {
        final double x = a + i * h;
        final double fx = _evaluateFunction(x);

        table.add(
          TrapezeIteration(
            index: i,
            x: x,
            fx: fx,
          ),
        );

        if (i != 0 && i != n) {
          sumInterior += fx;
        }
      }
    } catch (e) {
      throw Exception(
        'Expresión matemática inválida. Verifica la sintaxis de la función.',
      );
    }

    final double fa = table.first.fx;
    final double fb = table.last.fx;

    final double integral = (h / 2) * (fa + 2 * sumInterior + fb);

    return (integral, table);
  }
}
