// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projeto_integrador/Pages/login.dart';
import 'package:projeto_integrador/Pages/jeantxt.dart';
import 'package:projeto_integrador/Pages/primeiro_acesso.dart';
import 'Pages/page_teste.dart';
import 'Pages/recuperacao_de_senha.dart';
import 'zDatabase/mongodb_area_consumo.dart';
import 'zDatabase/mongodb_bancos.dart';
import 'zDatabase/mongodb_bancos_usuario.dart';
import 'zDatabase/mongodb_extrato.dart';
import 'zDatabase/mongodb_tipo_transacoes.dart';
import 'zDatabase/mongodb_clientes.dart';

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
      initialRoute: '/Login',
      routes: {
        '/PageTeste': (context) => PageTeste(),
        '/PrimeiroAcesso': (context) => PrimeiroAcesso(),
        '/EntrarCom...': (context) => PageTeste(),
        '/Login': (context) => Login(),
        '/RecuperacaoDeSenha': (context) => RecuperacaoDeSenha(),
        '/RedefinicaoDeSenha': (context) => PageTeste(),
        '/Cadastro': (context) => PageTeste(),
        '/EntrarComContaJaExistente': (context) => PageTeste(),
        '/VinculoBancarioOuInserçãoManual': (context) => PageTeste(),
        '/SelecaoDeBanco': (context) => PageTeste(),
        '/DadosDaContaBancaria': (context) => PageTeste(),
        '/InsercaoManualDosDadosBancarios': (context) => PageTeste(),
        '/PersonalizarNome': (context) => PageTeste(),
        '/AlterarSenha': (context) => PageTeste(),
        '/AlterarContaBancaria': (context) => PageTeste(),
        '/InsercaoManualDeNovaContaBancaria': (context) => PageTeste(),
        '/Main': (context) => Main(),
        '/GraficoDiario': (context) => PageTeste(),
        '/GraficoMensal': (context) => PageTeste(),
        '/EditarPagamentoPendente': (context) => PageTeste(),
        '/AdicionarPagamentoPendente': (context) => PageTeste(),
        '/GerarExtrato': (context) => PageTeste(),
        '/Alarme': (context) => PageTeste(),
        '/Extrato': (context) => PageTeste(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const LoginPage(),
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
        title: Text('ta foda'),
      ),
      body: Center(
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
