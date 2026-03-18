import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:numera/config/router/app_router.dart';
import 'package:numera/config/theme/app_theme.dart';
import 'package:numera/widgets/math_method_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 38),
          child: Text('Numera', style: AppFonts.title),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: [
          MathMethodCard(
            title: 'Método de Bisección',
            description:
                'Encuentra las raíces de una función en un intervalo dado dividiendo este por la mitad repetidamente.',
            icon: Icons.functions_rounded,
            formulaMain: 'c = (a+b)/2',
            formulaSub: 'ƒ(a)·ƒ(c) < 0',
            onTap: () {
              context.read<RouterSimpleCubit>().pushRoute('bisection');
            },
          ),
          const SizedBox(height: 10),
          MathMethodCard(
            title: 'Método de la Secante',
            description:
                'Busca las raíces aproximando la derivada mediante una línea secante entre dos puntos iniciales.',
            icon: Icons.show_chart_rounded,
            formulaMain: 'xₙ₊₁ = xₙ - ...',
            formulaSub: 'ƒ(xₙ)(xₙ-xₙ₋₁)',
            onTap: () {
              context.read<RouterSimpleCubit>().pushRoute('secant');
            },
          ),
          const SizedBox(height: 10),
          MathMethodCard(
            title: 'Regla del Trapecio',
            description:
                'Aproximación numérica de integrales definidas dividiendo el área bajo la curva en trapecios.',
            icon: Icons.area_chart_rounded,
            formulaMain: '∫ f(x) dx',
            formulaSub: 'h/2 (y₀ + y₁)',
            onTap: () {
              context.read<RouterSimpleCubit>().pushRoute('trapeze');
            },
          ),
          const SizedBox(height: 10),
          MathMethodCard(
            title: 'Método de Falsa Posición',
            description:
                'Encuentra raíces uniendo los extremos del intervalo con una línea recta e iterando sobre su intersección (Regula Falsi).',
            icon: Icons.timeline_rounded,
            formulaMain: 'c = b - ƒ(b)·...',
            formulaSub: '(b-a)/(ƒ(b)-ƒ(a))',
            onTap: () {
              context.read<RouterSimpleCubit>().pushRoute('false_position');
            },
          ),
        ],
      ),
    );
  }
}
