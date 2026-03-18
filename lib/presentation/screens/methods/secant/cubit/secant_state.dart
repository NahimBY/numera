import 'package:equatable/equatable.dart';
import '../secant_logic.dart';

abstract class SecantState extends Equatable {
  const SecantState();

  @override
  List<Object?> get props => [];
}

class SecantInitial extends SecantState {}

class SecantCalculating extends SecantState {}

class SecantSuccess extends SecantState {
  final List<SecantIteration> iterations;
  final double root;
  final double finalError;
  final int totalIterations;

  const SecantSuccess({
    required this.iterations,
    required this.root,
    required this.finalError,
    required this.totalIterations,
  });

  @override
  List<Object?> get props => [iterations, root, finalError, totalIterations];
}

class SecantError extends SecantState {
  final String message;

  const SecantError(this.message);

  @override
  List<Object?> get props => [message];
}
