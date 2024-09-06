import 'package:go_router/go_router.dart';
import 'package:intern_assignment/Screens/Home/home_screen.dart';
import 'package:intern_assignment/Screens/Login/login_screen.dart';
import 'package:intern_assignment/Screens/Splash/splash_screen.dart';

final appRoutes = {
  '/': (context) => const SplashScreen(),
  '/login': (context) => const LoginScreen(),
  '/home': (context) => const HomeScreen()
};

// final GoRouter goRouter = GoRouter(routes: [
//   GoRoute(
//     path: '/',
//     builder: (context, state) => const SplashScreen(),
//   ),
//   GoRoute(
//     path: '/login',
//     builder: (context, state) => const LoginScreen(),
//   ),
//   GoRoute(
//     path: '/home',
//     builder: (context, state) => const HomeScreen(),
//   )
// ]);
