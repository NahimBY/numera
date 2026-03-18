part of 'false_position_cubit.dart';

enum FalsePositionStatus { initial, calculating, success, failure }

class FalsePositionState extends Equatable {
  final FalsePositionStatus status;
  final List<FalsePositionIteration> results;
  final String errorMessage;

  const FalsePositionState({
    this.status = FalsePositionStatus.initial,
    this.results = const [],
    this.errorMessage = '',
  });

  FalsePositionState copyWith({
    FalsePositionStatus? status,
    List<FalsePositionIteration>? results,
    String? errorMessage,
  }) {
    return FalsePositionState(
      status: status ?? this.status,
      results: results ?? this.results,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, results, errorMessage];
}

