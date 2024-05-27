import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import '../Conta_Cli/select_conta_cli_cpf.dart';
import '../Transacoes/display_transacoes_account.dart';
import '../zDatabase/mongodb_client.dart';
import '../zModels/mongodb_model_client.dart';

class SelectClientAndAccount extends StatefulWidget {
  const SelectClientAndAccount({super.key});

  @override
  SelectClientAndAccountState createState() => SelectClientAndAccountState();
}

class SelectClientAndAccountState extends State<SelectClientAndAccount> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController cpf = TextEditingController();
  List<Widget> teste = [Container(), Container(), Container()];
  @override
  Widget build(BuildContext context) {
    teste[0] = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 400,
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'CPF'),
            controller: cpf,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  teste[1] = FutureBuilder(
                    future: MongoDatabaseClient.getDataByCpf(
                        Int64.parseInt(cpf.text)),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        return Column(children: [
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  color: Colors.red,
                                  child: displayCard(
                                    MongoDbModelClient.fromJson(
                                        snapshot.data[index]),
                                  ),
                                );
                              }),
                        ]);
                      } else {
                        return const Center(
                          child: Text("No data available"),
                        );
                      }
                    },
                  );
                });
              }
            },
            child: const Text("Confirmar"))
      ],
    );

    teste[2] = (FutureBuilder(
        future: MongoDatabaseClient.getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              // var lenData = snapshot.data.length;
              // //print("Total data cliente $lenData");
              return Column(children: [
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return displayCard(
                          MongoDbModelClient.fromJson(snapshot.data[index]));
                    }),
              ]);
            } else {
              return const Center(
                child: Text("No data available"),
              );
            }
          }
        }));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Selecione um Cliente",
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: teste,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayCard(MongoDbModelClient data) {
    return GestureDetector(
      onTap: () async {
        final i = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) {
                  return const SelectContaCliByCPF();
                },
                settings: RouteSettings(arguments: data.cpf)));
        if (i.runtimeType == int) {
          Navigator.pushReplacement(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(
                  builder: (context) {
                    return const DisplayTransacoesByAccount();
                  },
                  settings: RouteSettings(arguments: i)));
        }
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
                Text("Nome: "),
                Text("Email: "),
                Text("CPF: "),
                Text("Telefone: "),
                Text("Endereço")
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${data.id}"),
              Text(data.nome),
              Text(data.email),
              Text("${data.cpf}"),
              Text("${data.telefone}"),
              Text(data.endereco),
            ]),
            const SizedBox(
              width: 50,
            ),
          ],
        ),
      )),
    );
  }
}
