part of 'bisection_cubit.dart';

enum BisectionStatus { initial, calculating, success, failure }

class BisectionState extends Equatable {
  final BisectionStatus status;
  final List<BisectionIteration> results;
  final String errorMessage;

  const BisectionState({
    this.status = BisectionStatus.initial,
    this.results = const [],
    this.errorMessage = '',
  });

  BisectionState copyWith({
    BisectionStatus? status,
    List<BisectionIteration>? results,
    String? errorMessage,
  }) {
    return BisectionState(
      status: status ?? this.status,
      results: results ?? this.results,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, results, errorMessage];
}
