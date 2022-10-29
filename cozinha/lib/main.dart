import 'package:flutter/material.dart';
import 'package:cozinha/login/login.dart';
import 'package:cozinha/pedidos/pedidos.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BigBurguer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color(0XFFF56828),
          surface: const Color(0XFFF56828),
          secondary: const Color(0XFF11181B),
        ),
      ),
      initialRoute: '/pedidos',
      routes: {
        '/login': (context) => const Login(),
        '/pedidos': (context) => const TablePedidos(),
      },
    ));
