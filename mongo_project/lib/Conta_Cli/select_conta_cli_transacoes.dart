import 'package:estudo_prova01/Transacoes/insert_transacoes.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import '../zDatabase/mongodb_conta_cli.dart';
import '../zModels/mongodb_model_conta_cli.dart';

class SelectContaCliTransacoes extends StatefulWidget {
  const SelectContaCliTransacoes({super.key});

  @override
  SelectContaCliTransacoesState createState() => SelectContaCliTransacoesState();
}

class SelectContaCliTransacoesState extends State<SelectContaCliTransacoes> {
  @override
  Widget build(BuildContext context) {
    Int64 cpfRoute = ModalRoute.of(context)!.settings.arguments as Int64;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Selecione uma Conta Bancária",
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
              future: MongoDatabaseContaCli.getDataByCPF(cpfRoute),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    return Column(children: [
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return displayCard(MongoDbModelContaCli.fromJson(
                                snapshot.data[index]));
                          }),
                    ]);
                  } else {
                    return const Center(
                      child: Text("No data available"),
                    );
                  }
                }
              }),
        ),
      ),
    );
  }

  Widget displayCard(MongoDbModelContaCli data) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) {
                  return const InsertTransacoes();
                },
                settings: RouteSettings(arguments: data)));
      },
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Object Id: "),
                Text("Número da Conta: "),
                Text("Tipo da Conta: "),
                Text("Chave PIX: "),
                Text("Saldo: "),
                Text("Limite: "),
                Text("CPF vinculado a conta: "),
                Text("Agência vinculada a conta: ")
              ],
            ),
            const SizedBox(
              width: 50,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${data.id}"),
              Text("${data.numeroConta}"),
              Text(data.tipoConta),
              Text(data.chavePix),
              Text("${data.saldo}"),
              Text("${data.limite}"),
              Text("${data.cpf}"),
              Text("${data.numeroAgencia}"),
            ]),
          ],
        ),
      )),
    );
  }
}
