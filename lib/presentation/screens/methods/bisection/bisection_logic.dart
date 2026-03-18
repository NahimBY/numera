import 'package:math_expressions/math_expressions.dart';

class BisectionIteration {
  final int iteration;
  final double a;
  final double b;
  final double xr;
  final double fa;
  final double fxr;
  final double error;

  BisectionIteration({
    required this.iteration,
    required this.a,
    required this.b,
    required this.xr,
    required this.fa,
    required this.fxr,
    required this.error,
  });
}

class BisectionLogic {
  final String functionString;
  final double lowerLimit;
  final double upperLimit;
  final double tolerance;

  BisectionLogic({
    required this.functionString,
    required this.lowerLimit,
    required this.upperLimit,
    required this.tolerance,
  });

  double _evaluateFunction(double xValue) {
    Parser p = Parser();
    // Reemplazamos posibles x mayúsculas para evitar errores
    Expression exp = p.parse(functionString.replaceAll('X', 'x'));
    ContextModel cm = ContextModel();
    cm.bindVariable(Variable('x'), Number(xValue));
    return exp.evaluate(EvaluationType.REAL, cm);
  }

  /// Ejecuta el algoritmo de bisección. Lanza una excepción si no hay cambio de signo o sintaxis inválida.
  List<BisectionIteration> calculate() {
    double a = lowerLimit;
    double b = upperLimit;
    
    double fa;
    double fb;
    
    try {
      fa = _evaluateFunction(a);
      fb = _evaluateFunction(b);
    } catch (e) {
      throw Exception('Expresión matemática inválida. Asegúrate de usar operadores como *, / o ^ correctamente.');
    }

    if (fa * fb > 0) {
      throw Exception('No hay raíz en este intervalo ( f(a) y f(b) tienen el mismo signo )');
    }

    List<BisectionIteration> iterations = [];
    double error = double.infinity;
    double previousXr = a;
    int i = 1;

    // Límite de seguridad de 100 iteraciones
    while (error > tolerance && i <= 100) {
      double xr = (a + b) / 2;
      double fxr = _evaluateFunction(xr);

      if (i > 1) {
        error = ((xr - previousXr) / xr).abs();
      } else {
        error = double.infinity; // En la primera iteración no hay error relativo
      }

      iterations.add(BisectionIteration(
        iteration: i,
        a: a,
        b: b,
        xr: xr,
        fa: fa,
        fxr: fxr,
        error: error,
      ));

      if (fxr == 0.0) {
        break; 
      }

      if (fa * fxr < 0) {
        b = xr;
      } else {
        a = xr;
        fa = fxr; 
      }

      previousXr = xr;
      i++;
    }

    return iterations;
  }
}
