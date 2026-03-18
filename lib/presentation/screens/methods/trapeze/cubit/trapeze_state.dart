part of 'trapeze_cubit.dart';

enum TrapezeStatus { initial, calculating, success, failure }

class TrapezeState extends Equatable {
  final TrapezeStatus status;
  final double integralResult;
  final List<TrapezeIteration> iterations;
  final String errorMessage;

  const TrapezeState({
    this.status = TrapezeStatus.initial,
    this.integralResult = 0,
    this.iterations = const [],
    this.errorMessage = '',
  });

  TrapezeState copyWith({
    TrapezeStatus? status,
    double? integralResult,
    List<TrapezeIteration>? iterations,
    String? errorMessage,
  }) {
    return TrapezeState(
      status: status ?? this.status,
      integralResult: integralResult ?? this.integralResult,
      iterations: iterations ?? this.iterations,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, integralResult, iterations, errorMessage];
}

