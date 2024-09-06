import 'package:go_router/go_router.dart';
import 'package:intern_assignment/Dynamic_Screens/app_link_image_posts.dart';
import 'package:intern_assignment/Dynamic_Screens/app_link_text_posts.dart';
import 'package:intern_assignment/Dynamic_Screens/app_link_video_posts.dart';
import 'package:intern_assignment/Screens/Home/home_screen.dart';
import 'package:intern_assignment/Screens/Login/login_screen.dart';
import 'package:intern_assignment/Screens/Splash/splash_screen.dart';

// final appRoutes = {
//   '/': (context) => const SplashScreen(),
//   '/login': (context) => const LoginScreen(),
//   '/home': (context) => const HomeScreen()
// };
final GoRouter goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/text',
      builder: (context, state) {
        Uri uri = state.uri;
        final name = uri.queryParameters['name']; // Extract query parameter
        return AppLinkTextPosts(name: name); // Pass parameter to the widget
      },
    ),
    GoRoute(
      path: '/image',
      builder: (context, state) {
        Uri uri = state.uri;
        final name = uri.queryParameters['name'];
        return AppLinkImagePosts(name: name);
      },
    ),
    GoRoute(
      path: '/video',
      builder: (context, state) {
        Uri uri = state.uri;
        final name = uri.queryParameters['name'];
        return AppLinkVideoPosts(name: name ?? '');
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
