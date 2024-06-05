// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/Pages/gerar_extrato.dart';
import 'package:projeto_integrador/Pages/cadastro.dart';
import 'package:projeto_integrador/Pages/dados_da_conta_bancaria.dart';
import 'package:projeto_integrador/Pages/primeiro_acesso.dart';
import 'package:projeto_integrador/Pages/login.dart';
import 'package:projeto_integrador/Pages/tela_principal.dart';
import 'Pages/page_teste.dart';
import 'Pages/recuperacao_de_senha.dart';
import 'Pages/redefinicao_de_senha.dart';
import 'Pages/selecao_de_banco.dart';
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
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      initialRoute: '/PrimeiroAcesso',
      routes: {
        '/PageTeste': (context) => PageTeste(),
        '/PrimeiroAcesso': (context) => PrimeiroAcesso(),
        // '/EntrarCom...': (context) => PrimeiroAcesso(),
        '/Login': (context) => Login(),
        '/RecuperacaoDeSenha': (context) => RecuperacaoDeSenha(),
        '/RedefinicaoDeSenha': (context) => RedefinicaoDeSenha(),
        '/Cadastro': (context) => Cadastro(),
        '/EntrarComContaJaExistente': (context) => PageTeste(),
        '/VinculoBancarioOuInserçãoManual': (context) => PageTeste(),
        '/SelecaoDeBanco': (context) => SelecaoDeBanco(),
        '/DadosDaContaBancaria': (context) => DadosDaContaBancaria(),
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
        '/GerarExtrato': (context) => GerarExtrato(),
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
