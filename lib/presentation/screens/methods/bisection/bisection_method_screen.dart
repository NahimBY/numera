import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numera/config/theme/app_theme.dart';
import 'package:numera/widgets/custom_text_field.dart';

import 'cubit/bisection_cubit.dart';
import 'widgets/results_table.dart';

class BisectionMethodScreen extends StatelessWidget {
  static const name = 'bisection_method_screen';
  const BisectionMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BisectionCubit(),
      child: const _BisectionMethodView(),
    );
  }
}

class _BisectionMethodView extends StatefulWidget {
  const _BisectionMethodView();

  @override
  State<_BisectionMethodView> createState() => _BisectionMethodViewState();
}

class _BisectionMethodViewState extends State<_BisectionMethodView> {
  final _formKey = GlobalKey<FormState>();
  
  final _functionController = TextEditingController();
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  final _toleranceController = TextEditingController();

  void _calculate(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    
    // Esconder el teclado al calcular
    FocusScope.of(context).unfocus();

    context.read<BisectionCubit>().calculate(
      functionString: _functionController.text,
      lowerLimit: double.parse(_aController.text.replaceAll(',', '.')),
      upperLimit: double.parse(_bController.text.replaceAll(',', '.')),
      tolerance: double.parse(_toleranceController.text.replaceAll(',', '.')),
    );
  }

  void _clear(BuildContext context) {
    _functionController.clear();
    _aController.clear();
    _bController.clear();
    _toleranceController.clear();
    context.read<BisectionCubit>().clear();
  }

  // Validadores
  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Este campo es requerido';
    return null;
  }

  String? _numberValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Es requerido';
    if (double.tryParse(value.replaceAll(',', '.')) == null) {
      return 'Debe ser un número válido';
    }
    return null;
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
                  style: AppFonts.bodyText5.copyWith(color: AppColors.textWhite),
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextField(
                    label: 'Función f(x)',
                    hint: 'Ej: x^3 - 4*x - 9',
                    controller: _functionController,
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: 'Límite Inf. (a)',
                          hint: 'Ej: 2',
                          controller: _aController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                          validator: _numberValidator,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: CustomTextField(
                          label: 'Límite Sup. (b)',
                          hint: 'Ej: 3',
                          controller: _bController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                          validator: _numberValidator,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    label: 'Tolerancia / Error esp.',
                    hint: 'Ej: 0.001',
                    controller: _toleranceController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: _numberValidator,
                  ),
                  const SizedBox(height: 25),
                  
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _calculate(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          child: Text('Calcular', style: AppFonts.buttonText),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _clear(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            side: const BorderSide(color: AppColors.primary, width: 2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          child: Text('Limpiar', style: AppFonts.buttonText.copyWith(color: AppColors.primary)),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                  
                  if (state.status == BisectionStatus.success && state.results.isNotEmpty) ...[
                    // Resumen destacado
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.primaryDark.withOpacity(0.2)),
                      ),
                      child: Column(
                        children: [
                          Text('Raíz Aproximada (xr)', style: AppFonts.headline6.copyWith(color: AppColors.textDarkGray)),
                          const SizedBox(height: 8),
                          Text(
                            state.results.last.xr.toStringAsFixed(6),
                            style: AppFonts.headline1.copyWith(color: AppColors.success),
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text('Iteraciones', style: AppFonts.bodyText5.copyWith(color: AppColors.textGray)),
                                  Text(state.results.last.iteration.toString(), style: AppFonts.headline4),
                                ],
                              ),
                              Container(width: 1, height: 40, color: AppColors.fillPaleGray),
                              Column(
                                children: [
                                  Text('Error Final', style: AppFonts.bodyText5.copyWith(color: AppColors.textGray)),
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
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _functionController.dispose();
    _aController.dispose();
    _bController.dispose();
    _toleranceController.dispose();
    super.dispose();
  }
}