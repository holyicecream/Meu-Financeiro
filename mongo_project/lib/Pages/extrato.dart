// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projeto_integrador/zDatabase/mongodb_extrato.dart';
import '../zModels/model_area_consumo.dart';
import '../zModels/model_bancos_usuario.dart';
import '../zModels/model_bancos.dart';
import '../zModels/model_clientes.dart';
import '../zModels/model_extrato.dart';
import '../zModels/model_tipo_transacao.dart';
import '../zModels/todos_arguments.dart';

class Extrato extends StatefulWidget {
  const Extrato({super.key});

  @override
  State<Extrato> createState() => ExtratoState();
}

class ExtratoState extends State<Extrato> {
  TodosArguments todosArguments = TodosArguments(
    dataAreaConsumo: MongoDbModelAreaConsumo(),
    dataBancosUsuario: MongoDbModelBancosUsuario(),
    dataBancos: MongoDbModelBancos(),
    dataClientes: MongoDbModelClientes(),
    dataExtrato: MongoDbModelExtrato(),
    dataTransacao: MongoDbModelTipoTransacao(),
  );
  List<Map<String, dynamic>> dataExtrato = [];
  List<Map<String, dynamic>> dataExtratoSearch = [];
  TextEditingController pesquisaController = TextEditingController();
  int count = 0;

  @override
  void initState() {
    MongoDatabaseExtrato.getData().then(
      (value) {
        print('primeiro build?');
        dataExtrato = value;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    count++;
    print("build extrato $count");
    try {
      todosArguments =
          ModalRoute.of(context)!.settings.arguments as TodosArguments;
    } catch (e) {
      // print(e.toString());
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          "Lista com todos extratos",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: SizedBox(
                // height: 250,
                child: FutureBuilder(
                  future: MongoDatabaseExtrato.getData(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          int reversedIndex = snapshot.data.length - 1 - index;
                          Widget displayListView(
                              MongoDbModelExtrato data, BuildContext context) {
                            if (data.debitoCredito == 'debito') {
                              return GestureDetector(
                                onTap: () {
                                  // todosArguments.dataExtrato = data;
                                  // Navigator.pushNamed(context, '/AdicionarPagamentoPendente', arguments: todosArguments);
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.nomeDestinatario
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(data.descricaoTransacao
                                                      .toString()),
                                                ],
                                              ),
                                              Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .arrow_downward_sharp,
                                                      color: Colors.red,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("RS\$${data.valor}"),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_downward_rounded,
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  // todosArguments.dataExtrato = data;
                                  // Navigator.pushNamed(context, '/AdicionarPagamentoPendente', arguments: todosArguments);
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.nomeDestinatario
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(data.descricaoTransacao
                                                      .toString()),
                                                ],
                                              ),
                                              Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      Icons.arrow_upward_sharp,
                                                      color: Colors.green,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("RS\$${data.valor}"),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_downward_outlined,
                                    ),
                                  ],
                                ),
                              );
                            }
                          }

                          // print("extrato codCli ${snapshot.data[index]['cod_cliente']}");
                          // print("atual codCli ${todosArguments.dataClientes.codCliente}");
                          if (todosArguments.dataClientes.codCliente ==
                              snapshot.data[reversedIndex]['cod_cliente']) {
                            return displayListView(
                                MongoDbModelExtrato.fromJson(
                                    dataExtrato[reversedIndex]),
                                context);
                          } else {
                            return Container();
                          }
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("ih quebrou dando erro"),
                      );
                    } else {
                      return Center(child: Text("Ih quebrou no else"));
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
