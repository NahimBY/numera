import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:numera/presentation/screens/screens.dart';

GoRouter createRouter(String initialLocation) => GoRouter(
  initialLocation: initialLocation,
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      name: BisectionMethodScreen.name,
      path: '/bisection',
      builder: (context, state) => const BisectionMethodScreen(),
    ),
    GoRoute(
      name: SecantMethodScreen.name,
      path: '/secant',
      builder: (context, state) => const SecantMethodScreen(),
    ),
    GoRoute(
      name: TrapezeRuleScreen.name,
      path: '/trapeze',
      builder: (context, state) => const TrapezeRuleScreen(),
    ),
    GoRoute(
      name: FalsePositionMethodScreen.name,
      path: '/false_position',
      builder: (context, state) => const FalsePositionMethodScreen(),
    ),
  ],
);

class RouterSimpleCubit extends Cubit<GoRouter> {
  RouterSimpleCubit({String? initialRoute})
    : super(createRouter(initialRoute ?? '/'));

  void goBack() {
    state.pop();
  }

  void pushRoute(String route) {
    state.push('/$route');
  }

  void goRoute(String route) {
    state.go('/$route');
  }
}
