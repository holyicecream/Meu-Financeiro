import 'package:flutter/material.dart';

import '../classe_arguments.dart';

class DisplayDepoisTransacoes extends StatefulWidget {
  const DisplayDepoisTransacoes({super.key});

  @override
  DisplayDepoisTransacoesState createState() => DisplayDepoisTransacoesState();
}

class DisplayDepoisTransacoesState extends State<DisplayDepoisTransacoes> {
  @override
  Widget build(BuildContext context) {
    ClassArguments todosArguments = ClassArguments();
    String saldoAtualText = '';

    try {
      todosArguments =
          ModalRoute.of(context)!.settings.arguments as ClassArguments;
      saldoAtualText = (todosArguments.dataTransacoes!.saldo -
              todosArguments.dataTransacoes!.valor)
          .toString();
    } catch (e) {
      // //print("antes erro arguments");
      // //print(e.toString());
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Dados da transação efetuada: ",
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Object Id: "),
                            Text("Data: "),
                            Text("Número da Conta: "),
                            Text("Número da Agência: "),
                            Text("Saldo: "),
                            Text("Limite: "),
                            Text("Chave PIX: "),
                            Text("Número da Conta Destinatário: "),
                            Text("Número da Agência Destinatário: "),
                            Text("Chave PIX Destinatário: "),
                            Text("Valor: ")
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${todosArguments.dataTransacoes!.id}"),
                              Text("${todosArguments.dataTransacoes!.data}"),
                              Text(
                                  "${todosArguments.dataTransacoes!.numeroConta}"),
                              Text(
                                  "${todosArguments.dataTransacoes!.numeroAgencia}"),
                              Text("${todosArguments.dataTransacoes!.saldo}"),
                              Text("${todosArguments.dataTransacoes!.limite}"),
                              Text(todosArguments.dataTransacoes!.chavePix),
                              Text(
                                  "${todosArguments.dataTransacoes!.destinatarioConta}"),
                              Text(
                                  "${todosArguments.dataTransacoes!.destinatarioAgencia}"),
                              Text(todosArguments
                                  .dataTransacoes!.chavePixDestinatario),
                              Text("${todosArguments.dataTransacoes!.valor}"),
                            ]),
                      ],
                    ),
                    const Row(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Saldo atual",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              saldoAtualText,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
