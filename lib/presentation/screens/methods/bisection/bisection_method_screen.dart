import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:numera/config/theme/app_theme.dart';
import 'package:numera/widgets/custom_text_field.dart';
import 'package:numera/widgets/custom_button.dart';

import 'cubit/bisection_cubit.dart';
import 'widgets/results_table.dart';

class BisectionMethodScreen extends StatelessWidget {
  static const name = 'bisection_method_screen';
  const BisectionMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BisectionCubit(),
      child: _BisectionMethodView(),
    );
  }
}

class _BisectionMethodView extends StatelessWidget {
  final _functionController = TextEditingController();
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  final _toleranceController = TextEditingController();

  _BisectionMethodView();

  void _calculate(BuildContext context) {
    FocusScope.of(context).unfocus();

    context.read<BisectionCubit>().calculate(
      functionString: _functionController.text,
      lowerLimitStr: _aController.text,
      upperLimitStr: _bController.text,
      toleranceStr: _toleranceController.text,
    );
  }

  void _clear(BuildContext context) {
    _functionController.clear();
    _aController.clear();
    _bController.clear();
    _toleranceController.clear();
    context.read<BisectionCubit>().clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Método de Bisección', style: AppFonts.appBarTitle),
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<BisectionCubit, BisectionState>(
        listener: (context, state) {
          if (state.status == BisectionStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                  style: AppFonts.bodyText5.copyWith(
                    color: AppColors.textWhite,
                  ),
                ),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primaryDark.withOpacity(0.2),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Row(
                    spacing: 10,
                    children: [
                      HeroIcon(
                        HeroIcons.informationCircle,
                        color: AppColors.primaryDark.withOpacity(0.8),
                      ),
                      Expanded(
                        child: Text(
                          'Para escribir funciones como x^2 + 2x + 1, escriba: x^2 + 2*x + 1',
                          style: AppFonts.bodyText5.copyWith(
                            color: AppColors.primaryDark.withOpacity(0.8),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: 'Función f(x)',
                  hint: 'Ej: x^3 - 4*x - 9',
                  controller: _functionController,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: 'Límite Inf. (a)',
                        hint: 'Ej: 2',
                        controller: _aController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: CustomTextField(
                        label: 'Límite Sup. (b)',
                        hint: 'Ej: 3',
                        controller: _bController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: 'Tolerancia / Error esp.',
                  hint: 'Ej: 0.001',
                  controller: _toleranceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Calcular',
                        isLoading: state.status == BisectionStatus.calculating,
                        onPressed: () => _calculate(context),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: CustomButton(
                        text: 'Limpiar',
                        isMainButton: false,
                        isLoading: state.status == BisectionStatus.calculating,
                        onPressed: () => _clear(context),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                if (state.status == BisectionStatus.success &&
                    state.results.isNotEmpty) ...[
                  // Resumen destacado
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDark.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.primaryDark.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Raíz Aproximada (xr)',
                          style: AppFonts.headline6.copyWith(
                            color: AppColors.textDarkGray,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.results.last.xr.toStringAsFixed(6),
                          style: AppFonts.headline1.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Iteraciones',
                                  style: AppFonts.bodyText5.copyWith(
                                    color: AppColors.textGray,
                                  ),
                                ),
                                Text(
                                  state.results.last.iteration.toString(),
                                  style: AppFonts.headline4,
                                ),
                              ],
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: AppColors.fillPaleGray,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Error Final',
                                  style: AppFonts.bodyText5.copyWith(
                                    color: AppColors.textGray,
                                  ),
                                ),
                                Text(
                                  '${(state.results.last.error * 100).toStringAsFixed(4)}%',
                                  style: AppFonts.headline4,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  Text('Tabla de Resultados', style: AppFonts.headline5),
                  const SizedBox(height: 10),
                  ResultsTable(iterations: state.results),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
