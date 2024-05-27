import 'dart:math';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodart_lib;
import '../Agencia/select_agencia.dart';
import '../Cliente/select_client.dart';
import 'display_conta_cli.dart';
import '../zDatabase/mongodb_conta_cli.dart';
import '../zModels/mongodb_model_conta_cli.dart';

class InsertContaCli extends StatefulWidget {
  const InsertContaCli({super.key});

  @override
  InsertContaCliState createState() => InsertContaCliState();
}

class InsertContaCliState extends State<InsertContaCli> {
  var tipoConta = TextEditingController(
      text: const DropdownMenuItem(value: "Normal", child: Text("Normal"))
          .value
          .toString());
  var numeroConta =
      TextEditingController(text: (Random().nextInt(8999) + 1000).toString());
  var chavePix = TextEditingController();
  var saldo = TextEditingController();
  var limite = TextEditingController();
  var cpf = TextEditingController();
  var numeroAgencia = TextEditingController();
  var checkContaEspecial = false;

  List<DropdownMenuItem<String>>? eUmSelectConfia = [
    const DropdownMenuItem(value: "Normal", child: Text("Normal")),
    const DropdownMenuItem(value: "Especial", child: Text("Especial")),
  ];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController contaNormal() {
      if (tipoConta.text == 'Normal') {
        TextEditingController normal = TextEditingController();
        normal.text = '0';
        return normal;
      } else {
        return limite;
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Inserir nova conta bancária",
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
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
                        enabled: false,
                        decoration:
                            const InputDecoration(labelText: 'Numero da Conta'),
                        controller: numeroConta,
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
                      DropdownButtonFormField<String>(
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 16),
                        value: tipoConta.text,
                        isExpanded: true,
                        items: eUmSelectConfia,
                        onChanged: (value) {
                          if (value == "Especial") {
                            checkContaEspecial = true;
                            limite.text = '';
                          } else {
                            if (value == "Normal") {
                              checkContaEspecial = false;
                              limite.text = '0';
                            }
                          }
                          setState(() {
                            tipoConta.text = value!;
                          });
                        },
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
                            const InputDecoration(labelText: 'Chave PIX'),
                        controller: chavePix,
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
                        decoration: const InputDecoration(labelText: 'Saldo'),
                        controller: saldo,
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
                        decoration: const InputDecoration(labelText: 'Limite'),
                        controller: contaNormal(),
                        enabled: checkContaEspecial,
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
                        children: [
                          Flexible(
                            child: TextFormField(
                              enabled: false,
                              decoration:
                                  const InputDecoration(labelText: 'CPF'),
                              controller: cpf,
                              validator: (value) {
                                if (value == '') {
                                  return "Este campo não pode ser vazio.";
                                }
                                return null;
                              },
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
                                      return const SelectClient();
                                    },
                                  ),
                                );
                                if (i.runtimeType == Int64) {
                                  // //print(i);
                                  setState(() {
                                    cpf.text = i.toString();
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
                        children: [
                          Flexible(
                            child: TextFormField(
                              enabled: false,
                              decoration: const InputDecoration(
                                  labelText: 'Número da Agência'),
                              controller: numeroAgencia,
                              validator: (value) {
                                if (value == '') {
                                  return "Este campo não pode ser vazio.";
                                }
                                return null;
                              },
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
                                      return const SelectAgencia();
                                    },
                                  ),
                                );
                                if (i.runtimeType == int) {
                                  // //print(i);
                                  setState(() {
                                    numeroAgencia.text = i.toString();
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
                                      int.parse(numeroConta.text),
                                      tipoConta.text,
                                      chavePix.text,
                                      double.parse(saldo.text),
                                      double.parse(limite.text),
                                      Int64.parseInt(cpf.text),
                                      int.parse(numeroAgencia.text));
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return const DisplayContaCli();
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
    );
  }

  Future<void> insertData(int numeroConta, String tipoConta, String chavePix,
      double saldo, double limite, Int64 dataClient, int dataAgencia) async {
    dynamic id = mongodart_lib.ObjectId();
    final data = MongoDbModelContaCli(
        id: id,
        numeroConta: numeroConta,
        tipoConta: tipoConta,
        chavePix: chavePix,
        saldo: saldo,
        limite: limite,
        cpf: dataClient,
        numeroAgencia: dataAgencia);
    await MongoDatabaseContaCli.insert(data);
  }
}
