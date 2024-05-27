import 'package:estudo_prova01/zDatabase/mongodb_conta_cli.dart';
import 'package:estudo_prova01/classe_arguments.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodart_lib;
import '../zModels/mongodb_model_conta_cli.dart';
import '../Conta_Cli/select_conta_cli.dart';
import 'depois_transacoes.dart';
import '../zModels/mongodb_model_transacoes.dart';
import '../zDatabase/mongodb_transacoes.dart';

class InsertTransacoes extends StatefulWidget {
  const InsertTransacoes({super.key});

  @override
  InsertTransacoesState createState() => InsertTransacoesState();
}

class InsertTransacoesState extends State<InsertTransacoes> {
  dynamic objId = mongodart_lib.ObjectId();
  var dataTempo = TextEditingController(text: DateTime.now().toIso8601String());
  var numeroConta = TextEditingController();
  var numeroAgencia = TextEditingController();
  var saldo = TextEditingController();
  var limite = TextEditingController();
  var chavePix = TextEditingController();
  var numeroContaDestinatario = TextEditingController();
  var numeroAgenciaDestinatario = TextEditingController();
  var chavePixDestinatario = TextEditingController();
  var valor = TextEditingController();
  double saldoDestinatario = 0;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ClassArguments todosArguments = ClassArguments();
    ClassArguments todosArgumentsDestinatario = ClassArguments();

    todosArguments.dataContaCli =
        ModalRoute.of(context)!.settings.arguments as MongoDbModelContaCli;

    numeroConta.text = todosArguments.dataContaCli!.numeroConta.toString();
    numeroAgencia.text = todosArguments.dataContaCli!.numeroAgencia.toString();
    saldo.text = todosArguments.dataContaCli!.saldo.toString();
    limite.text = todosArguments.dataContaCli!.limite.toString();
    chavePix.text = todosArguments.dataContaCli!.chavePix.toString();

    //print(todosArguments.dataContaCli);
    //print(todosArgumentsDestinatario.dataContaCli);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Inserir nova transação",
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            final i = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SelectContaCli();
                                },
                              ),
                            );
                            //print("antes${i.runtimeType}");
                            if (i.runtimeType == MongoDbModelContaCli) {
                              //print("depois${i.runtimeType}");
                              setState(() {
                                saldoDestinatario = i.saldo;
                                todosArgumentsDestinatario.dataContaCli = i;
                                numeroContaDestinatario.text =
                                    i.numeroConta.toString();
                                numeroAgenciaDestinatario.text =
                                    i.numeroAgencia.toString();
                                chavePixDestinatario.text = i.chavePix;
                              });
                            }
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Puxar dados do destinatário"),
                              SizedBox(
                                width: 30,
                              ),
                              Icon(Icons.edit)
                            ],
                          )),
                      TextFormField(
                        enabled: false,
                        decoration: const InputDecoration(labelText: 'Data'),
                        controller: dataTempo,
                        validator: (value) {
                          if (value == '') {
                            return "Este campo não pode ser vazio.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        enabled: false,
                        decoration:
                            const InputDecoration(labelText: 'Sua conta'),
                        controller: numeroConta,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
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
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        enabled: false,
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
                        height: 5,
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: const InputDecoration(
                            labelText: 'Limite de Crédito'),
                        controller: limite,
                        validator: (value) {
                          if (value == '') {
                            return "Este campo não pode ser vazio.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        enabled: false,
                        decoration:
                            const InputDecoration(labelText: 'Chave PIX'),
                        controller: chavePix,
                        validator: (value) {
                          if (value == '') {
                            return "Este campo não pode ser vazio.";
                          } else if (value !=
                              todosArguments.dataContaCli!.chavePix
                                  .toString()) {
                            return "Chave PIX inválido";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: const InputDecoration(
                            labelText: 'Número da conta destinatario'),
                        controller: numeroContaDestinatario,
                        validator: (value) {
                          if (value == '') {
                            return "Este campo não pode ser vazio.";
                          } else if (value == numeroConta.text) {
                            return "Não é possivel fazer transações entre contas iguais";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: const InputDecoration(
                            labelText: 'Número da agência destinatario'),
                        controller: numeroAgenciaDestinatario,
                        validator: (value) {
                          if (value == '') {
                            return "Este campo não pode ser vazio.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: const InputDecoration(
                            labelText: 'Chave PIX destinatario'),
                        controller: chavePixDestinatario,
                        validator: (value) {
                          if (value == '') {
                            return "Este campo não pode ser vazio.";
                          }
                          // else if (value != todosArgumentsDestinatario.dataContaCli!.chavePix.toString()){
                          //   return "Chave PIX inválido";
                          // }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        enabled: true,
                        decoration: const InputDecoration(labelText: 'Valor'),
                        controller: valor,
                        validator: (value) {
                          if (value == '') {
                            return "Este campo não pode ser vazio.";
                          } else if (int.parse(value!) <= 0) {
                            return "O valor não pode ser menor que 1";
                          } else if (double.parse(value) >
                              (double.parse(saldo.text) +
                                  double.parse(limite.text))) {
                            return 'Saldo insuficiente';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                todosArguments.dataTransacoes =
                                    MongoDbModelTransacoes(
                                  id: objId,
                                  data: DateTime.now(),
                                  dia: DateTime.now().day,
                                  numeroConta: int.parse(numeroConta.text),
                                  numeroAgencia: int.parse(numeroAgencia.text),
                                  saldo: double.parse(saldo.text),
                                  limite: double.parse(limite.text),
                                  chavePix: chavePix.text,
                                  destinatarioConta:
                                      int.parse(numeroContaDestinatario.text),
                                  destinatarioAgencia:
                                      int.parse(numeroAgenciaDestinatario.text),
                                  chavePixDestinatario:
                                      chavePixDestinatario.text,
                                  valor: double.parse(valor.text),
                                );
                                insertData(
                                  objId,
                                  DateTime.now(),
                                  // DateTime.now().toIso8601String(),
                                  DateTime.now().day,
                                  int.parse(numeroConta.text),
                                  int.parse(numeroAgencia.text),
                                  double.parse(saldo.text),
                                  double.parse(limite.text),
                                  chavePix.text,
                                  int.parse(numeroContaDestinatario.text),
                                  int.parse(numeroAgenciaDestinatario.text),
                                  chavePixDestinatario.text,
                                  double.parse(valor.text),
                                  saldoDestinatario,
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const DisplayDepoisTransacoes();
                                    },
                                    settings: RouteSettings(
                                        arguments: todosArguments),
                                  ),
                                );
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
    );
  }

  Future<void> insertData(
    dynamic id,
    DateTime dataTempo,
    int dia,
    int numeroConta,
    int numeroAgencia,
    double saldo,
    double limite,
    String chavePix,
    int numeroContaDestinatario,
    int numeroAgenciaDestinatario,
    String chavePixDestinatario,
    double valor,
    double saldoDestinatario,
  ) async {
    // dynamic id = mongodart_lib.ObjectId();
    final data = MongoDbModelTransacoes(
        id: id,
        data: dataTempo,
        dia: dia,
        numeroConta: numeroConta,
        numeroAgencia: numeroAgencia,
        saldo: saldo,
        limite: limite,
        chavePix: chavePix,
        destinatarioConta: numeroContaDestinatario,
        destinatarioAgencia: numeroAgenciaDestinatario,
        chavePixDestinatario: chavePixDestinatario,
        valor: valor);
    await MongoDatabaseTransacoes.insert(data);
    await MongoDatabaseContaCli.updateSaldoByNumeroConta(
        numeroConta, numeroContaDestinatario, saldo, saldoDestinatario, valor);
  }
}
