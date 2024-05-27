import 'package:estudo_prova01/Agencia/display_agencia.dart';
import 'package:estudo_prova01/Agencia/insert_agencia.dart';
import 'package:estudo_prova01/Banco/display_banco.dart';
import 'package:estudo_prova01/Cliente/display_client.dart';
import 'package:estudo_prova01/Cliente/insert_client.dart';
import 'package:estudo_prova01/Cliente/select_client_transacoes.dart';
import 'package:estudo_prova01/Conta_Cli/display_conta_cli.dart';
import 'package:estudo_prova01/Conta_Cli/insert_conta_cli.dart';
import 'package:estudo_prova01/Transacoes/display_transacoes.dart';
import 'package:estudo_prova01/inserir.dart';
import 'package:estudo_prova01/listar.dart';
import 'package:flutter/material.dart';

class Navegacao extends StatefulWidget {
  const Navegacao({super.key});

  @override
  State<Navegacao> createState() => _NavegacaoState();
}

class _NavegacaoState extends State<Navegacao> {
  int indexDoBottom = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Banco Meu Financeiro - Menu de navegação",
            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              height: 600,
              width: 800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image(image: NetworkImage("https://imgur.com/a/5bBAthR"))
                ]
              )
            )
          )
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Listar"),
            BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart), label: "Inserir")
          ],
          currentIndex: indexDoBottom,
          onTap: (index) {
            setState(() {
              indexDoBottom = index;
              if (indexDoBottom == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Listar(),
                  ),
                );
              } else if (indexDoBottom == 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Inserir(),
                  ),
                );
              }
            });
          },
        ));
  }
}
