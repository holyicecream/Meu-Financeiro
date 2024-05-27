import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';

import '../zDatabase/mongodb_banco.dart';
import '../zModels/mongodb_model_banco.dart';

class SelectBanco extends StatefulWidget {
  const SelectBanco({super.key});

  @override
  SelectBancoState createState() => SelectBancoState();
}

class SelectBancoState extends State<SelectBanco> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Selecione uma Empresa Bancária",
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
              future: MongoDatabaseBanco.getData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    // var lenData = snapshot.data.length;
                    // //print("Total data banco $lenData");
                    return Column(children: [
                      const Text("Selecione um Banco."),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return displayCard(
                                MongoDbModelBanco.fromJson(
                                    snapshot.data[index]),
                                MongoDbModelBanco.fromJson(snapshot.data[index])
                                    .cnpj);
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

  Widget displayCard(MongoDbModelBanco data, Int64 resultCnpj) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, resultCnpj);
      },
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Object Id: "),
              Text("Data: "),
              Text("Grupo: "),
              Text("CNPJ: "),
              Text("Telefone: "),
              Text("Endereço: ")
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
              Text(data.grupo),
              Text("${data.cnpj}"),
              Text("${data.telefone}"),
              Text(data.endereco),
            ],
          )
        ]),
      )),
    );
  }
}
