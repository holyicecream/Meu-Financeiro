import 'package:estudo_prova01/listar.dart';
import 'package:estudo_prova01/pages/initial-page.dart';
import 'package:projeto_integrador/Pages/initial-page.dart';

import '/Agencia/display_agencia.dart';
import '/Banco/display_banco.dart';
import '/Cliente/display_client.dart';
import '/Conta_Cli/display_conta_cli.dart';
import '/Transacoes/display_transacoes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const InitialPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      // home: const Navegacao(),
    );
  }
}
