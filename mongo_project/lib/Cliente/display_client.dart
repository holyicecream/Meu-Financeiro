import 'package:flutter/material.dart';

import '../zDatabase/mongodb_client.dart';
import '../zModels/mongodb_model_client.dart';
import 'update_client.dart';

class DisplayClient extends StatefulWidget {
  const DisplayClient({super.key});

  @override
  DisplayClientState createState() => DisplayClientState();
}

class DisplayClientState extends State<DisplayClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Lista de clientes",
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
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
                            return displayCard(MongoDbModelClient.fromJson(
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

  Widget displayCard(MongoDbModelClient data) {
    return Card(
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) {
                        return const UpdateClient();
                      },
                      settings: RouteSettings(arguments: data)));
            },
            child: const Icon(
              Icons.edit,
              size: 35,
            ),
          ),
        ],
      ),
    ));
  }
}
