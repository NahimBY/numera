import 'package:math_expressions/math_expressions.dart';

class SecantIteration {
  final int iteration;
  final double xiMinus1;
  final double xi;
  final double fXiMinus1;
  final double fXi;
  final double xiPlus1;
  final double error;

  SecantIteration({
    required this.iteration,
    required this.xiMinus1,
    required this.xi,
    required this.fXiMinus1,
    required this.fXi,
    required this.xiPlus1,
    required this.error,
  });
}

class SecantLogic {
  final Parser _parser = Parser();
  final ContextModel _cm = ContextModel();

  double _evaluateFunction(String function, double x) {
    try {
      Expression exp = _parser.parse(function);
      _cm.bindVariable(Variable('x'), Number(x));
      // Bind usual constants if needed
      _cm.bindVariable(Variable('e'), Number(2.718281828459045));
      _cm.bindVariable(Variable('pi'), Number(3.141592653589793));
      
      return exp.evaluate(EvaluationType.REAL, _cm);
    } catch (e) {
      throw Exception('Error al evaluar la función. Verifica la sintaxis ($e)');
    }
  }

  List<SecantIteration> calculate({
    required String function,
    required double x0,
    required double x1,
    required double tolerance,
    required int maxIterations,
  }) {
    List<SecantIteration> iterations = [];
    double currentX0 = x0;
    double currentX1 = x1;
    double error = double.infinity;
    int iter = 1;

    // Verificar sintaxis antes de iniciar el ciclo
    _evaluateFunction(function, currentX0);

    while (iter <= maxIterations) {
      double fX0 = _evaluateFunction(function, currentX0);
      double fX1 = _evaluateFunction(function, currentX1);

      double denominator = fX1 - fX0;
      
      if (denominator == 0.0 || denominator.abs() < 1e-15) {
        throw Exception('División por cero detectada. La recta secante es horizontal.');
      }

      double x2 = currentX1 - (fX1 * (currentX1 - currentX0)) / denominator;

      error = (x2 - currentX1).abs();

      iterations.add(SecantIteration(
        iteration: iter,
        xiMinus1: currentX0,
        xi: currentX1,
        fXiMinus1: fX0,
        fXi: fX1,
        xiPlus1: x2,
        error: error,
      ));

      if (error <= tolerance) {
        break;
      }

      currentX0 = currentX1;
      currentX1 = x2;
      iter++;
    }

    return iterations;
  }
}
