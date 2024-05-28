// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '/_backend/backend_tela_principal.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => MainState();
}

class MainState extends State<Main> {
  int indexDoBottom = 0;
  @override
  Widget build(BuildContext context) {
    inBuildTelaPrincipal(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          "Meu Financeiro",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: Colors.green,
                width: double.infinity,
                height: 200.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 40,
                      ),
                      Text(
                        "Olá, ${todosArguments.dataClientes.nomeCliente.toString()}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '$saldo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Icon(Icons.remove_red_eye_rounded))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pagamentos pendentes",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "- R\$ ${pagamentosPendentesValue.toString()}",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: pagamentosPendentes,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Extrato",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(onPressed: () {}, child: Icon(Icons.share)),
                    Text(
                      "Mostrar gráfico",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Row(children: [extrato]),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/GerarExtrato');
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: CircleBorder(),
      ),
    );
  }
}
