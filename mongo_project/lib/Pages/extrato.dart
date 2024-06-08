import 'package:flutter/material.dart';

import '../zModels/model_area_consumo.dart';
import '../zModels/model_bancos.dart';
import '../zModels/model_bancos_usuario.dart';
import '../zModels/model_clientes.dart';
import '../zModels/model_extrato.dart';
import '../zModels/model_tipo_transacao.dart';
import '../zModels/todos_arguments.dart';
import '/zDatabase/mongodb_extrato.dart';

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
    super.initState();
    MongoDatabaseExtrato.getData().then(
      (value) {
        dataExtrato = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    count++;
    // ignore: avoid_print
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
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: SizedBox(
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
                                onTap: () {},
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
                                                    style: const TextStyle(
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
                                                    const Icon(
                                                      Icons
                                                          .arrow_downward_sharp,
                                                      color: Colors.red,
                                                    ),
                                                    const SizedBox(
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
                                    const Icon(
                                      Icons.arrow_downward_rounded,
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {},
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
                                                    style: const TextStyle(
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
                                                    const Icon(
                                                      Icons.arrow_upward_sharp,
                                                      color: Colors.green,
                                                    ),
                                                    const SizedBox(
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
                                    const Icon(
                                      Icons.arrow_downward_outlined,
                                    ),
                                  ],
                                ),
                              );
                            }
                          }

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
                      return const Center(
                        child: Text("ih quebrou dando erro"),
                      );
                    } else {
                      return const Center(child: Text("Ih quebrou no else"));
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
