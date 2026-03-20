import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:numera/config/theme/app_theme.dart';
import 'package:numera/widgets/custom_button.dart';
import 'package:numera/widgets/custom_text_field.dart';
import 'package:numera/widgets/custom_appbar.dart';

import 'cubit/trapeze_cubit.dart';
import 'widgets/trapeze_results_table.dart';

class TrapezeRuleScreen extends StatelessWidget {
  static const name = 'trapeze_rule_screen';

  const TrapezeRuleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TrapezeCubit(),
      child: _TrapezeRuleView(),
    );
  }
}

class _TrapezeRuleView extends StatelessWidget {
  final _functionController = TextEditingController();
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  final _nController = TextEditingController();

  _TrapezeRuleView();

  void _calculate(BuildContext context) {
    FocusScope.of(context).unfocus();

    context.read<TrapezeCubit>().calculate(
      functionString: _functionController.text,
      lowerLimitStr: _aController.text,
      upperLimitStr: _bController.text,
      nStr: _nController.text,
    );
  }

  void _clear(BuildContext context) {
    FocusScope.of(context).unfocus();
    _functionController.clear();
    _aController.clear();
    _bController.clear();
    _nController.clear();
    context.read<TrapezeCubit>().clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TrapezeCubit, TrapezeState>(
        listener: (context, state) {
          if (state.status == TrapezeStatus.failure) {
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
          return CustomScrollView(
            slivers: [
              const CustomAppBar(title: 'Regla del Trapecio'),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 20,
                        ),
                        child: Row(
                          spacing: 10,
                          children: [
                            HeroIcon(
                              HeroIcons.informationCircle,
                              color: AppColors.primaryDark.withOpacity(0.8),
                            ),
                            Expanded(
                              child: Text(
                                'Para escribir funciones como x² + 2x + 1, escriba: x^2 + 2*x + 1',
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
                        hint: 'Ej: x^2 + 3*x',
                        controller: _functionController,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: 'Límite Inf. (a)',
                              hint: 'Ej: 0',
                              controller: _aController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: true,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: CustomTextField(
                              label: 'Límite Sup. (b)',
                              hint: 'Ej: 2',
                              controller: _bController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: true,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: 'Número de subintervalos (n)',
                        hint: 'Ej: 10',
                        controller: _nController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: 'Calcular',
                              isLoading:
                                  state.status == TrapezeStatus.calculating,
                              onPressed: () => _calculate(context),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: CustomButton(
                              text: 'Limpiar',
                              isMainButton: false,
                              isLoading:
                                  state.status == TrapezeStatus.calculating,
                              onPressed: () => _clear(context),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      if (state.status == TrapezeStatus.success &&
                          state.iterations.isNotEmpty) ...[
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
                                'Aproximación de la integral',
                                style: AppFonts.headline6.copyWith(
                                  color: AppColors.textDarkGray,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                state.integralResult.toStringAsFixed(6),
                                style: AppFonts.headline1.copyWith(
                                  color: AppColors.success,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Tabla de puntos evaluados',
                          style: AppFonts.headline5,
                        ),
                        const SizedBox(height: 10),
                        TrapezeResultsTable(iterations: state.iterations),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
