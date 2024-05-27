import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';

import 'display_client.dart';
import '../zDatabase/mongodb_client.dart';
import '../zModels/mongodb_model_client.dart';

class UpdateClient extends StatefulWidget {
  const UpdateClient({super.key});

  @override
  UpdateClientState createState() => UpdateClientState();
}

var nome = TextEditingController();
var email = TextEditingController();
var cpf = TextEditingController();
var telefone = TextEditingController();
var endereco = TextEditingController();

class UpdateClientState extends State<UpdateClient> {
  @override
  Widget build(BuildContext context) {
    MongoDbModelClient data =
        ModalRoute.of(context)!.settings.arguments as MongoDbModelClient;

    nome.text = data.nome;
    email.text = data.email;
    cpf.text = data.cpf.toString();
    endereco.text = data.endereco;
    telefone.text = data.telefone.toString();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Atualizar dados do Cliente ${data.cpf}",
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Nome'),
                  controller: nome,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  enabled: false,
                  decoration: const InputDecoration(labelText: 'CPF'),
                  controller: cpf,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  controller: email,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Telefone'),
                  controller: telefone,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Endereço'),
                  controller: endereco,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // MongoDatabase.connect();
                        updateData(
                            data.id,
                            nome.text,
                            email.text,
                            Int64.parseInt(telefone.text),
                            endereco.text,
                            Int64.parseInt(cpf.text));
                        // insertData(nome.text, email.text, telefone.text, cpf.text);
                      },
                      child: const Text(
                        'Confirmar',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateData(dynamic id, String nome, String email, Int64 telefone,
      String endereco, Int64 cpf) async {
    final updateData = MongoDbModelClient(
        id: id,
        nome: nome,
        cpf: cpf,
        email: email,
        endereco: endereco,
        telefone: telefone);
    await MongoDatabaseClient.update(updateData).whenComplete(
        () => Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const DisplayClient();
              },
            )));
  }
}
