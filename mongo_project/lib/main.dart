// ignore_for_file: avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '/Pages/adicionar_pagamento_pendente.dart';
import '/Pages/alterar_senha.dart';
import '/Pages/cadastro.dart';
import '/Pages/editar_pagamento_pendente.dart';
import '/Pages/extrato.dart';
import '/Pages/grafico_diario.dart';
import '/Pages/grafico_mensal.dart';
import '/Pages/login.dart';
import '/Pages/personalizar_nome.dart';
import '/Pages/primeiro_acesso.dart';
import '/Pages/tela_principal.dart';
import 'Pages/recuperacao_de_senha.dart';
import 'Pages/redefinicao_de_senha.dart';
import 'Pages/selecao_de_banco.dart';
import 'zDatabase/mongodb_area_consumo.dart';
import 'zDatabase/mongodb_bancos.dart';
import 'zDatabase/mongodb_bancos_usuario.dart';
import 'zDatabase/mongodb_clientes.dart';
import 'zDatabase/mongodb_extrato.dart';
import 'zDatabase/mongodb_tipo_transacoes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MongoDatabaseAreaConsumo.connect().then((value) {
    print('1º foi');
    MongoDatabaseBancosUsuario.connect().then((value) {
      print('2º foi');
      MongoDatabaseBancos.connect().then((value) {
        print('3º foi');
        MongoDatabaseClientes.connect().then((value) {
          print('4º foi');
          MongoDatabaseExtrato.connect().then((value) {
            print('5º foi');
            MongoDatabaseTipoTransacoes.connect().then((value) {
              print('6º foi');
              print('Iniciando app');
              runApp(const MyApp());
            });
          });
        });
      });
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.touch,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.unknown
        },
      ),
      initialRoute: '/PrimeiroAcesso',
      routes: {
        '/PrimeiroAcesso': (context) => const PrimeiroAcesso(),
        '/Login': (context) => const Login(),
        '/RecuperacaoDeSenha': (context) => const RecuperacaoDeSenha(),
        '/RedefinicaoDeSenha': (context) => const RedefinicaoDeSenha(),
        '/Cadastro': (context) => const Cadastro(),
        '/SelecaoDeBanco': (context) => const SelecaoDeBanco(),
        '/PersonalizarNome': (context) => const PersonalizarNome(),
        '/AlterarSenha': (context) => const AlterarSenha(),
        '/AlterarContaBancaria': (context) => const SelecaoDeBanco(),
        '/Main': (context) => const Main(),
        '/GraficoDiario': (context) => const GraficoDiario(),
        '/GraficoMensal': (context) => const GraficoMensal(),
        '/EditarPagamentoPendente': (context) =>
            const EditarPagamentoPendente(),
        '/AdicionarPagamentoPendente': (context) =>
            const AdicionarPagamentoPendente(),
        '/Extrato': (context) => const Extrato(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ta foda'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
