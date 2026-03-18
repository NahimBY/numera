import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numera/config/theme/app_theme.dart';
import 'package:numera/widgets/custom_button.dart';
import 'package:numera/widgets/custom_text_field.dart';
import 'cubit/secant_cubit.dart';
import 'cubit/secant_state.dart';
import 'secant_logic.dart';

class SecantMethodScreen extends StatelessWidget {
  static const name = 'secant_method_screen';

  const SecantMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SecantCubit(SecantLogic()),
      child: _SecantMethodView(),
    );
  }
}

class _SecantMethodView extends StatelessWidget {
  final functionCtrl = TextEditingController();
  final x0Ctrl = TextEditingController();
  final x1Ctrl = TextEditingController();
  final tolCtrl = TextEditingController();
  final iterCtrl = TextEditingController();

  _SecantMethodView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Método de la Secante'),
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<SecantCubit, SecantState>(
        listener: (context, state) {
          if (state is SecantError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  label: 'Función f(x)',
                  hint: 'Ejemplo: x^2 - 4',
                  controller: functionCtrl,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: 'Punto Inicial x0',
                        hint: 'Ej. 1',
                        controller: x0Ctrl,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextField(
                        label: 'Punto Inicial x1',
                        hint: 'Ej. 2',
                        controller: x1Ctrl,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: 'Tolerancia',
                        hint: 'Ej. 0.001',
                        controller: tolCtrl,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextField(
                        label: 'Iteraciones',
                        hint: 'Ej. 50',
                        controller: iterCtrl,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Calcular',
                        isLoading: state is SecantCalculating,
                        onPressed: () {
                          FocusScope.of(context).unfocus();

                          context.read<SecantCubit>().calculate(
                            function: functionCtrl.text,
                            x0Str: x0Ctrl.text,
                            x1Str: x1Ctrl.text,
                            toleranceStr: tolCtrl.text,
                            maxIterationsStr: iterCtrl.text,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        text: 'Limpiar',
                        isMainButton: false,
                        isLoading: state is SecantCalculating,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          functionCtrl.clear();
                          x0Ctrl.clear();
                          x1Ctrl.clear();
                          tolCtrl.clear();
                          iterCtrl.clear();
                          context.read<SecantCubit>().clear();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                if (state is SecantSuccess) ...[
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
                          'Raíz aproximada (xr)',
                          style: AppFonts.headline6.copyWith(
                            color: AppColors.textDarkGray,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.root.toStringAsFixed(6),
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
                                  state.totalIterations.toString(),
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
                                  'Error final',
                                  style: AppFonts.bodyText5.copyWith(
                                    color: AppColors.textGray,
                                  ),
                                ),
                                Text(
                                  '${(state.finalError * 100).toStringAsFixed(4)}%',
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
                  Text('Tabla de Resultados:', style: AppFonts.headline5),
                  const SizedBox(height: 10),
                  _SecantResultsTable(iterations: state.iterations),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SecantResultsTable extends StatelessWidget {
  final List<SecantIteration> iterations;

  const _SecantResultsTable({required this.iterations});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.resolveWith(
          (states) => AppColors.primaryDark.withOpacity(0.1),
        ),
        dataRowMaxHeight: double.infinity,
        headingTextStyle: AppFonts.headline8.copyWith(color: AppColors.primaryDark),
        dataTextStyle: AppFonts.bodyText2,
        columns: const [
          DataColumn(label: Text('Iter')),
          DataColumn(label: Text('x(i-1)')),
          DataColumn(label: Text('x(i)')),
          DataColumn(label: Text('f(x(i-1))')),
          DataColumn(label: Text('f(x(i))')),
          DataColumn(label: Text('x(i+1)')),
          DataColumn(label: Text('Error')),
        ],
        rows:
            iterations.map((it) {
              return DataRow(
                cells: [
                  DataCell(Text(it.iteration.toString())),
                  DataCell(Text(it.xiMinus1.toStringAsFixed(6))),
                  DataCell(Text(it.xi.toStringAsFixed(6))),
                  DataCell(Text(it.fXiMinus1.toStringAsFixed(6))),
                  DataCell(Text(it.fXi.toStringAsFixed(6))),
                  DataCell(Text(it.xiPlus1.toStringAsFixed(6))),
                  DataCell(Text(it.error.toStringAsFixed(6))),
                ],
              );
            }).toList(),
      ),
    );
  }
}
