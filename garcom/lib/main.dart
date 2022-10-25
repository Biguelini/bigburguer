import 'package:flutter/material.dart';
import 'package:garcom/login/login.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BigBurguer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0XFFf77f00),
          brightness: Brightness.dark,
          surface: const Color(0XFFf77f00),
          primary: const Color(0XFFf77f00),
          secondary: const Color(0XFF941b0c),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
      },
    ));
