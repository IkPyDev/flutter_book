import 'package:book_app/bloc/home/home_bloc.dart';
import 'package:book_app/presintions/auth/login/login.dart';
import 'package:book_app/presintions/auth/register/register.dart';
import 'package:book_app/presintions/auth/splash/splash_screens.dart';
import 'package:book_app/presintions/home/detail/detail.dart';
import 'package:book_app/presintions/home/home.dart';
import 'package:book_app/presintions/home/library/library.dart';
import 'package:book_app/presintions/main_screens.dart';
import 'package:book_app/presintions/music/music.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login/login_bloc.dart';
import 'bloc/main/main_bloc.dart';
import 'bloc/play/play_bloc.dart';
import 'domain/local/pref_helper.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: "UniNeue",
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xffe78b8b),
            primary: const Color(0xffF26B6C),
            onPrimary: Colors.white,
            primaryContainer: Color(0xffeac7c7),
            onPrimaryContainer: const Color(0xffe34446),
          ),
          textTheme: _textTheme),
      initialRoute: '/splash',
      routes: {
        '/main': (context) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => MainBloc()),
              ],
              child: const MainScreen(),
            ),
        '/splash': (context) => const SplashScreens(),
        '/register': (context) => const Register(),
        '/login': (context) => BlocProvider(
              create: (context) => LoginBloc(),
              child: const Login(),
            ),
        '/home': (context) => BlocProvider(
              create: (context) => HomeBloc()
          ,
              child: const Home(),
            ),
        // '/chapter': (context) => const Chapter(),
        '/play': (context) => BlocProvider(
              create: (context) => PlayBloc(),
              child: const Music(),
            ),
        '/profile': (context) => const Detail(),
        '/search': (context) => const Library(),
      },
      home: const SplashScreens(),
    );
  }
}

const _textTheme = TextTheme(
  displayLarge:
      TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: Colors.black),
  displayMedium:
      TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.black),
  displaySmall:
      TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
  headlineLarge:
      TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
  headlineMedium:
      TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
  headlineSmall:
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
  titleLarge:
      TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
  titleMedium:
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
  titleSmall:
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
  bodyLarge: TextStyle(
      fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
  bodyMedium: TextStyle(
      fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
  bodySmall: TextStyle(
      fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black),
  labelLarge:
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
  labelMedium:
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
  labelSmall:
      TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black),
);
