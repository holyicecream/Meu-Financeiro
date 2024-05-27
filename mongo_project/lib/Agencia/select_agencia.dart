import 'package:flutter/material.dart';
import '../zModels/mongodb_model_agencia.dart';
import '../zDatabase/mongodb_agencia.dart';

class SelectAgencia extends StatefulWidget {
  const SelectAgencia({super.key});

  @override
  SelectAgenciaState createState() => SelectAgenciaState();
}

class SelectAgenciaState extends State<SelectAgencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Selecione uma Agência Bancária",
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
              future: MongoDatabaseAgencia.getData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    // var lenData = snapshot.data.length;
                    // //print("Total data agencia ${lenData}");
                    return Column(children: [
                      const Text(
                        "Escolha uma Agência Bancária do qual deseja criar uma Conta Bancária.",
                        style: TextStyle(fontSize: 32),
                      ),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return displayCard(MongoDbModelAgencia.fromJson(
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

  Widget displayCard(MongoDbModelAgencia data) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, data.numeroAgencia);
      },
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Object Id: "),
              Text("Nome: "),
              Text("Número da Agência: "),
              Text("Telefone: "),
              Text("Endereço: "),
              Text("Email: "),
              Text("CNPJ: "),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${data.id}"),
              Text(data.nome),
              Text("${data.numeroAgencia}"),
              Text("${data.telefone}"),
              Text(data.endereco),
              Text(data.email),
              Text("${data.cnpj}"),
            ],
          )
        ]),
      )),
    );
  }
}
