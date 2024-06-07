// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../zDatabase/mongodb_extrato.dart';
import '../zModels/model_area_consumo.dart';
import '../zModels/model_bancos_usuario.dart';
import '../zModels/model_bancos.dart';
import '../zModels/model_clientes.dart';
import '../zModels/model_extrato.dart';
import '../zModels/model_tipo_transacao.dart';
import '../zModels/todos_arguments.dart';

class AdicionarPagamentoPendente extends StatefulWidget {
  const AdicionarPagamentoPendente({super.key});

  @override
  State<AdicionarPagamentoPendente> createState() =>
      AdicionarPagamentoPendenteState();
}

const List<String> list2 = <String>[
  'Outros',
  'Lazer',
  'Alimentação',
  'Moradia',
  'Educação',
  'Transporte',
  'Saúde'
];
const List<String> list = <String>[
  'Compra no débito',
  'Compra no crédito',
  'Pix',
  'Depósito por boleto',
  'Transferência',
  'Saque',
  'Recarga',
  'Outros'
];

class AdicionarPagamentoPendenteState
    extends State<AdicionarPagamentoPendente> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController valorController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();

  TodosArguments todosArguments = TodosArguments(
    dataAreaConsumo: MongoDbModelAreaConsumo(),
    dataBancosUsuario: MongoDbModelBancosUsuario(),
    dataBancos: MongoDbModelBancos(),
    dataClientes: MongoDbModelClientes(),
    dataExtrato: MongoDbModelExtrato(),
    dataTransacao: MongoDbModelTipoTransacao(),
  );

  String data = '2024-1-1';
  String radioBtnGroup = "";
  int count = 0;
  @override
  Widget build(BuildContext context) {
    print("dataExtrato ${todosArguments.dataExtrato.toJson()}");

    count++;
    print("build adicionarPagamentoPendente $count");

    try {
      todosArguments =
          ModalRoute.of(context)!.settings.arguments as TodosArguments;
      if (todosArguments.dataExtrato.debitoCredito == 'debito') {
        radioBtnGroup = "Pago";
      } else if (todosArguments.dataExtrato.debitoCredito == 'credito') {
        radioBtnGroup = "Recebido";
      } else {
        radioBtnGroup = "Pago";
      }
      print(todosArguments.dataClientes.toJson());
      print(todosArguments.dataExtrato.toJson());
    } catch (e) {
      // print(e.toString());
    }
    MongoDatabaseExtrato.getData().then(
      (value) {
        if (value.isNotEmpty) {
          todosArguments.dataExtrato.registro =
              (value[value.length - 1]['registro'] + 1);
        } else {
          todosArguments.dataExtrato.registro = 1;
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/Main',
                arguments: todosArguments);
          },
          child: Icon(Icons.arrow_back),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 1.0,
          ),
        ),
        title: const Text(
          "Adicionar extrato",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nomeController,
                          validator: (value) {
                            value ??= '';
                            if (value == '') {
                              return 'Este campo não pode ser vazio.';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            todosArguments.dataExtrato.nomeDestinatario = value;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Nome da pessoa/instituição"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: valorController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == '') {
                              value = '0';
                            }
                            print(value);
                            if (value == '0') {
                              return 'Este campo não pode ser vazio.';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            // value ??= "0";
                            todosArguments.dataExtrato.valor =
                                double.tryParse(value);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Valor pago/recebido"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Radio(
                              value: "Pago",
                              groupValue: radioBtnGroup,
                              onChanged: (value) {
                                value ??= 'Pago';
                                if (value == 'Pago') {
                                  todosArguments.dataExtrato.debitoCredito =
                                      'debito';
                                } else if (value == "Recebido") {
                                  todosArguments.dataExtrato.debitoCredito =
                                      'credito';
                                }
                                setState(() {
                                  radioBtnGroup = value!;
                                });
                              },
                            ),
                            Text("Valor pago"),
                            SizedBox(
                              width: 10,
                            ),
                            Radio(
                              value: "Recebido",
                              groupValue: radioBtnGroup,
                              onChanged: (value) {
                                value ??= 'Pago';
                                if (value == 'Pago') {
                                  todosArguments.dataExtrato.debitoCredito =
                                      'debito';
                                } else if (value == "Recebido") {
                                  todosArguments.dataExtrato.debitoCredito =
                                      'credito';
                                }
                                setState(() {
                                  radioBtnGroup = value!;
                                });
                              },
                            ),
                            Text("Valor recebido"),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: dataController,
                          validator: (value) {
                            if ((value.toString()) == "null") {
                              // todosArguments.dataExtrato.data = DateTime.now();
                              return 'Este campo não pode ser vazio.';
                            } else if (value == '') {
                              return 'Este campo não pode ser vazio.';
                            } else {
                              return null;
                              // value ??= '2024-1-1';
                              // data = DateTime.tryParse(value)!.toIso8601String();

                              // todosArguments.dataExtrato.data = DateTime.now();
                              // // print(todosArguments.dataExtrato.data.runtimeType);
                              // // print(todosArguments.dataExtrato.data);
                            }
                            // value ??= DateTime.now().toString();
                            // dataController.text = value.toString();
                            // value ??= '';
                          },
                          onTap: () {
                            Future<void> selectDate() async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );

                              if (picked != null) {
                                setState(() {
                                  print(picked.toString());
                                  print("ué ta indo");
                                  dataController.text =
                                      picked.toString().split(" ")[0];
                                });
                              } else {
                                print("falhou ali óh");
                              }
                            }

                            selectDate();
                          },
                          decoration: InputDecoration(
                              filled: true,
                              prefixIcon: Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              labelText: "Data do pagamento"),
                          readOnly: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownMenuExample(list),
                        // SizedBox(
                        //     width: double.infinity, child: DropdownMenuExample(list2)),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 120,
                          child: TextFormField(
                            controller: descricaoController,
                            validator: (value) {
                              value ??= '';
                              if (value == '') {
                                descricaoController.text = '';
                                return null;
                                // return 'Este campo não pode ser vazio.';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {
                              todosArguments.dataExtrato.descricaoTransacao =
                                  value;
                            },
                            maxLines: null,
                            expands: true,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Descrição"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 250,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                
                                todosArguments.dataExtrato.codBanco =
                                    todosArguments.dataBancos.codBanco;
                                todosArguments.dataExtrato.codCliente =
                                    todosArguments.dataClientes.codCliente;
                                print(todosArguments.dataExtrato.toJson());
                                MongoDatabaseExtrato.insert(
                                        todosArguments.dataExtrato)
                                    .then((value) {
                                  MongoDatabaseExtrato.update(
                                          todosArguments.dataExtrato,
                                          dataController.text)
                                      .then((value) => Navigator.pushReplacementNamed(
                                          context, '/Main', arguments: todosArguments));
                                });
                              }
                              // Navigator.pop(context, '/Main');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF7ED957),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: Text(
                              "Adicionar",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample(List<String> list, {super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  TodosArguments todosArguments = TodosArguments(
    dataAreaConsumo: MongoDbModelAreaConsumo(),
    dataBancosUsuario: MongoDbModelBancosUsuario(),
    dataBancos: MongoDbModelBancos(),
    dataClientes: MongoDbModelClientes(),
    dataExtrato: MongoDbModelExtrato(),
    dataTransacao: MongoDbModelTipoTransacao(),
  );
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownMenu<String>(
        initialSelection: list.first,
        onSelected: (String? value) {
          if (value == 'Compra no débito') {
            todosArguments.dataExtrato.codTransacao = 5;
          } else if (value == 'Pix') {
            todosArguments.dataExtrato.codTransacao = 3;
          } else if (value == 'Depósito por boleto') {
            todosArguments.dataExtrato.codTransacao = 1;
          } else if (value == 'Transferência') {
            todosArguments.dataExtrato.codTransacao = 7;
          } else if (value == 'Saque') {
            todosArguments.dataExtrato.codTransacao = 4;
          } else if (value == 'Recarga') {
            todosArguments.dataExtrato.codTransacao = 8;
          } else {
            todosArguments.dataExtrato.codTransacao = 9;
          }
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries:
            list.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      ),
    );
  }
}
