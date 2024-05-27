import 'display_agencia.dart';
import '../Banco/select_banco.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodart_lib;
import '../zModels/mongodb_model_agencia.dart';
import '../zDatabase/mongodb_agencia.dart';
import 'package:fixnum/fixnum.dart';

class InsertAgencia extends StatefulWidget {
  const InsertAgencia({super.key});

  @override
  InsertAgenciaState createState() => InsertAgenciaState();
}

var nome = TextEditingController();
var numeroAgencia = TextEditingController();
var telefone = TextEditingController();
var endereco = TextEditingController();
var email = TextEditingController();
var cnpj = TextEditingController();

class InsertAgenciaState extends State<InsertAgencia> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Inserir nova agência",
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
                          decoration: const InputDecoration(
                              labelText: 'Numero_Agencia'),
                          controller: numeroAgencia,
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
                          decoration:
                              const InputDecoration(labelText: 'Telefone'),
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
                          decoration:
                              const InputDecoration(labelText: 'Endereco'),
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
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: TextFormField(
                                decoration:
                                    const InputDecoration(labelText: 'CNPJ'),
                                controller: cnpj,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo não pode ser vazio.";
                                  } else {
                                    return null;
                                  }
                                },
                                enabled: false,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  final i = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const SelectBanco();
                                      },
                                    ),
                                  );
                                  if (i.runtimeType == Int64) {
                                    // //print(i);
                                    setState(() {
                                      cnpj.text = i.toString();
                                    });
                                  }
                                },
                                child: const Icon(Icons.edit)),
                          ],
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
                                        int.parse(numeroAgencia.text),
                                        Int64.parseInt(telefone.text),
                                        endereco.text,
                                        email.text,
                                        Int64.parseInt(cnpj.text));
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return const DisplayAgencia();
                                      },
                                    ));
                                  }
                                },
                                child: const Text(
                                  'Confirmar',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ]),
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

  Future<void> insertData(String nome, int numeroAgencia, Int64 telefone,
      String endereco, String email, Int64 cnpj) async {
    dynamic id = mongodart_lib.ObjectId();
    final data = MongoDbModelAgencia(
        id: id,
        nome: nome,
        numeroAgencia: numeroAgencia,
        telefone: telefone,
        endereco: endereco,
        email: email,
        cnpj: cnpj);
    await MongoDatabaseAgencia.insert(data);
  }
}
