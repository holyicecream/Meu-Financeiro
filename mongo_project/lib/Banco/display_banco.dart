import 'package:flutter/material.dart';
import '../zModels/mongodb_model_banco.dart';
import '../zDatabase/mongodb_banco.dart';

class DisplayBanco extends StatefulWidget {
  const DisplayBanco({super.key});

  @override
  DisplayBancoState createState() => DisplayBancoState();
}

class DisplayBancoState extends State<DisplayBanco> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Lista de empresas bancárias",
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
                    // //print("Total data banco ${lenData}");
                    return Column(children: [
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return displayCard(MongoDbModelBanco.fromJson(
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

  Widget displayCard(MongoDbModelBanco data) {
    return Card(
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
    ));
  }
}
