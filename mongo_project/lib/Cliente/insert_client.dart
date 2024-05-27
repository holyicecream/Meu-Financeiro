import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodart_lib;
import 'display_client.dart';
import '../zDatabase/mongodb_client.dart';
import '../zModels/mongodb_model_client.dart';

class InsertClient extends StatefulWidget {
  const InsertClient({super.key});

  @override
  InsertClientState createState() => InsertClientState();
}

var nome = TextEditingController();
var email = TextEditingController();
var cpf = TextEditingController();
var telefone = TextEditingController();
var endereco = TextEditingController();

class InsertClientState extends State<InsertClient> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Inserir novo cliente",
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Form(
              key: formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 400,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Nome'),
                          controller: nome,
                          validator: (value) {
                            if (value == '') {
                              return "Este campo não pode ser vazio.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'CPF'),
                          controller: cpf,
                          validator: (value) {
                            if (value == '') {
                              return "Este campo não pode ser vazio.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                          controller: email,
                          validator: (value) {
                            if (value == '') {
                              return "Este campo não pode ser vazio.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Telefone'),
                          controller: telefone,
                          validator: (value) {
                            if (value == '') {
                              return "Este campo não pode ser vazio.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Endereço'),
                          controller: endereco,
                          validator: (value) {
                            if (value == '') {
                              return "Este campo não pode ser vazio.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  insertData(
                                    nome.text,
                                    email.text,
                                    telefone.text,
                                    cpf.text,
                                    endereco.text,
                                  );
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return const DisplayClient();
                                    },
                                  ));
                                }
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> insertData(String nome, String email, dynamic telefone,
      dynamic cpf, String endereco) async {
    dynamic id = mongodart_lib.ObjectId();
    final data = MongoDbModelClient(
        id: id,
        nome: nome,
        cpf: Int64.parseInt(cpf),
        email: email,
        endereco: endereco,
        telefone: Int64.parseInt(telefone));
    await MongoDatabaseClient.insert(data);
  }
}
