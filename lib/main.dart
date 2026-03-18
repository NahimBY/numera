import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numera/config/theme/app_theme.dart';
import 'package:numera/presentation/screens/methods/bisection/cubit/bisection_cubit.dart';
import 'package:numera/presentation/screens/methods/secant/cubit/secant_cubit.dart';
import 'package:numera/presentation/screens/methods/secant/secant_logic.dart';
import 'config/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(BlocProviders());
}

class BlocProviders extends StatelessWidget {
  const BlocProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RouterSimpleCubit>(
          create: (context) => RouterSimpleCubit(initialRoute: '/'),
        ),
        BlocProvider<BisectionCubit>(
          create: (context) => BisectionCubit(),
        ),
        BlocProvider<SecantCubit>(
          create: (context) => SecantCubit(SecantLogic()),
        ),
      ],
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = context.watch<RouterSimpleCubit>().state;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Numera',
      routerConfig: appRouter,
      theme: AppTheme(selectedColor: 0).theme(),
    );
  }
}
