// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projeto_integrador/zDatabase/mongodb_clientes.dart';

import '../zDatabase/mongodb_extrato.dart';
import '../zModels/model_area_consumo.dart';
import '../zModels/model_bancos_usuario.dart';
import '../zModels/model_bancos.dart';
import '../zModels/model_clientes.dart';
import '../zModels/model_extrato.dart';
import '../zModels/model_tipo_transacao.dart';
import '../zModels/todos_arguments.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => MainState();
}

class MainState extends State<Main> {
  TodosArguments todosArguments = TodosArguments(
    dataAreaConsumo: MongoDbModelAreaConsumo(),
    dataBancosUsuario: MongoDbModelBancosUsuario(),
    dataBancos: MongoDbModelBancos(),
    dataClientes: MongoDbModelClientes(),
    dataExtrato: MongoDbModelExtrato(),
    dataTransacao: MongoDbModelTipoTransacao(),
  );
  List<Map<String, dynamic>> dataExtrato = [
    {'': ''}
  ];
  int count = 0;
  @override
  Widget build(BuildContext context) {
    count++;
    print("build telaPrincipal $count");
    try {
      todosArguments =
          ModalRoute.of(context)!.settings.arguments as TodosArguments;
    } catch (e) {
      // print(e.toString());
    }
    MongoDatabaseExtrato.getData().then(
      (value) {
        if (value.isNotEmpty) {
          dataExtrato = value;
        }
      },
    );
    print("banco atual ${todosArguments.dataBancos.toJson()}");
    print("cliente atual ${todosArguments.dataClientes.toJson()}");
    return Scaffold(
      endDrawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.browse_gallery),
                  Icon(Icons.search),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/PersonalizarNome',
                      arguments: todosArguments);
                },
                child: Row(
                  children: [
                    Icon(Icons.login),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Seu nome'),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/AlterarSenha',
                      arguments: todosArguments);
                },
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Alterar senha'),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Main',
                      arguments: todosArguments);
                },
                child: Row(
                  children: [
                    Icon(Icons.wc),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Conta bancária'),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Main',
                      arguments: todosArguments);
                },
                child: Row(
                  children: [
                    Icon(Icons.assignment),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Sair do app'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          "Meu Financeiro",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: Colors.green,
                width: double.infinity,
                height: 200.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 40,
                      ),
                      FutureBuilder(
                        future: MongoDatabaseClientes.getData(),
                        builder: (context, AsyncSnapshot snapshot) {
                          Widget widgetNome = Text(
                            "Olá, Sem Nome",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          );
                          if (snapshot.hasData) {
                            if (snapshot.data.length >= 1) {
                              // print("nome ${snapshot.data}");
                              for (var element in snapshot.data) {
                                if (element['cod_cliente'] ==
                                    todosArguments.dataClientes.codCliente) {
                                  widgetNome = Text(
                                    // "Olá, ${element['nome_cliente'].toString().split(' ')[0].toString()}",
                                    "Olá, ${element['nome_cliente']}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  );
                                }
                              }
                            }
                            return widgetNome;
                          } else {
                            return widgetNome;
                          }
                        },
                      ),
                      Row(
                        children: [
                          FutureBuilder(
                            future: MongoDatabaseExtrato.getData(),
                            builder: (context, AsyncSnapshot snapshot) {
                              double saldo = 0.0;
                              Widget widgetSaldo = Text(
                                '$saldo',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              );
                              if (snapshot.hasData) {
                                if (snapshot.data.length >= 1) {
                                  // print("saldo ${snapshot.data}");
                                  // int.parse("${element['data'].toString().split(' ')[0].toString().split('-')[0]}${element['data'].toString().split(' ')[0].toString().split('-')[1]}${element['data'].toString().split(' ')[0].toString().split('-')[2]}");
                                  for (var element in snapshot.data) {
                                    if (element['cod_cliente'] ==
                                            todosArguments
                                                .dataClientes.codCliente &&
                                        element['debito_credito'] == "debito" &&
                                        int.parse(
                                                "${element['data'].toString().split(' ')[0].toString().split('-')[0]}${element['data'].toString().split(' ')[0].toString().split('-')[1]}${element['data'].toString().split(' ')[0].toString().split('-')[2]}") <=
                                            int.parse(
                                                "${DateTime.now().toString().split(' ')[0].toString().split('-')[0]}${DateTime.now().toString().split(' ')[0].toString().split('-')[1]}${DateTime.now().toString().split(' ')[0].toString().split('-')[2]}")) {
                                      saldo -= element['valor'];
                                    } else if (element['cod_cliente'] ==
                                            todosArguments
                                                .dataClientes.codCliente &&
                                        element['debito_credito'] ==
                                            "credito" &&
                                        int.parse(
                                                "${element['data'].toString().split(' ')[0].toString().split('-')[0]}${element['data'].toString().split(' ')[0].toString().split('-')[1]}${element['data'].toString().split(' ')[0].toString().split('-')[2]}") <=
                                            int.parse(
                                                "${DateTime.now().toString().split(' ')[0].toString().split('-')[0]}${DateTime.now().toString().split(' ')[0].toString().split('-')[1]}${DateTime.now().toString().split(' ')[0].toString().split('-')[2]}")) {
                                      saldo += element['valor'];
                                    }
                                  }
                                }
                                widgetSaldo = Text(
                                  '$saldo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                );
                                return widgetSaldo;
                              } else {
                                return widgetSaldo;
                              }
                            },
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Icon(Icons.remove_red_eye_rounded))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pagamentos pendentes",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FutureBuilder(
                      future: MongoDatabaseExtrato.getData(),
                      builder: (context, AsyncSnapshot snapshot) {
                        double pagamentosPendentesValue = 0.0;
                        Widget widgetPagamentosPendentesValue = Text(
                          "R\$ ${pagamentosPendentesValue.toString()}",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        );
                        if (snapshot.hasData) {
                          if (snapshot.data.length >= 1) {
                            // print("pagamento ${snapshot.data}");
                            for (var element in snapshot.data) {
                              if (element['cod_cliente'] ==
                                      todosArguments.dataClientes.codCliente &&
                                  int.parse(
                                          "${element['data'].toString().split(' ')[0].toString().split('-')[0]}${element['data'].toString().split(' ')[0].toString().split('-')[1]}${element['data'].toString().split(' ')[0].toString().split('-')[2]}") >=
                                      int.parse(
                                          "${DateTime.now().toString().split(' ')[0].toString().split('-')[0]}${DateTime.now().toString().split(' ')[0].toString().split('-')[1]}${DateTime.now().toString().split(' ')[0].toString().split('-')[2]}") &&
                                  element['debito_credito'] == "debito") {
                                pagamentosPendentesValue -= element['valor'];
                              } else if (element['cod_cliente'] ==
                                      todosArguments.dataClientes.codCliente &&
                                  int.parse(
                                          "${element['data'].toString().split(' ')[0].toString().split('-')[0]}${element['data'].toString().split(' ')[0].toString().split('-')[1]}${element['data'].toString().split(' ')[0].toString().split('-')[2]}") >=
                                      int.parse(
                                          "${DateTime.now().toString().split(' ')[0].toString().split('-')[0]}${DateTime.now().toString().split(' ')[0].toString().split('-')[1]}${DateTime.now().toString().split(' ')[0].toString().split('-')[2]}") &&
                                  element['debito_credito'] == "credito") {
                                pagamentosPendentesValue += element['valor'];
                              }
                            }
                          }
                          widgetPagamentosPendentesValue = Text(
                            "R\$ ${pagamentosPendentesValue.toString()}",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          );
                          return widgetPagamentosPendentesValue;
                        } else {
                          return widgetPagamentosPendentesValue;
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                            context, '/AdicionarPagamentoPendente',
                            arguments: todosArguments);
                        if (!context.mounted) return;
                        print('ué');
                        try {
                          print("\n\n\n\n\n\n\nAAAAAAAAAAAAAAAAAAAAAA$result");
                          todosArguments = result as TodosArguments;
                        } catch (e) {
                          print("\n\n\n\n\n\n\nBBBBBBBBBBBBBBBBBBBBBB$result");
                          print(e);
                        }
                        print("ih deu pop ${result.toString()}");
                      },
                      child: SizedBox(
                        width: 125,
                        height: 125,
                        child: Card(
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: FutureBuilder(
                          future: MongoDatabaseExtrato.getData(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasData) {
                              return SizedBox(
                                height: 125,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    Widget displayCard(MongoDbModelExtrato data,
                                        int day, BuildContext context) {
                                      // print("aa ${data.data}");
                                      // print(DateTime.now());
                                      print("dia dia $day");
                                      print(
                                          "dia hoje ${DateTime.now().toString().split(' ')[0].toString().split('-')[0]}${DateTime.now().toString().split(' ')[0].toString().split('-')[1]}${DateTime.now().toString().split(' ')[0].toString().split('-')[2]}");
                                      print(data.toJson());
                                      if (data.debitoCredito == 'debito' &&
                                          day >=
                                              int.parse(
                                                  "${DateTime.now().toString().split(' ')[0].toString().split('-')[0]}${DateTime.now().toString().split(' ')[0].toString().split('-')[1]}${DateTime.now().toString().split(' ')[0].toString().split('-')[2]}")) {
                                        print("CADEdia dia $day");
                                        print(
                                            "CADEdia hoje ${int.parse("${DateTime.now().toString().split(' ')[0].toString().split('-')[0]}${DateTime.now().toString().split(' ')[0].toString().split('-')[1]}${DateTime.now().toString().split(' ')[0].toString().split('-')[2]}")}");
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 0, 0, 0),
                                            child: SizedBox(
                                              height: 125,
                                              width: 125,
                                              child: Card(
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                                'https://i.pinimg.com/280x280_RS/2e/22/90/2e229065b0e9a509755d371e6050b4fe.jpg'),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .arrow_downward_sharp,
                                                            color: Colors.red,
                                                          ),
                                                          Text(data.valor
                                                              .toString()),
                                                        ],
                                                      ),
                                                      Text(data.nomeDestinatario
                                                          .toString()),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else if (data.debitoCredito ==
                                              'credito' &&
                                          day >=
                                              int.parse(
                                                  "${DateTime.now().toString().split(' ')[0].toString().split('-')[0]}${DateTime.now().toString().split(' ')[0].toString().split('-')[1]}${DateTime.now().toString().split(' ')[0].toString().split('-')[2]}")) {
                                        return GestureDetector(
                                          onTap: () {
                                            // todosArguments.dataExtrato = data;
                                            // Navigator.pushNamed(context, '/PageTeste', arguments: todosArguments);
                                          },
                                          child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 0, 0),
                                            child: SizedBox(
                                              height: 125,
                                              width: 125,
                                              child: Card(
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                                'https://i.pinimg.com/280x280_RS/2e/22/90/2e229065b0e9a509755d371e6050b4fe.jpg'),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.arrow_upward,
                                                            color: Colors.green,
                                                          ),
                                                          Text(data.valor
                                                              .toString()),
                                                        ],
                                                      ),
                                                      Text(data.nomeDestinatario
                                                          .toString()),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }

                                    if (todosArguments
                                            .dataClientes.codCliente ==
                                        snapshot.data[index]['cod_cliente']) {
                                      // print(
                                      //     "${snapshot.data[index]['data'].toString().split(' ')}");
                                      // print(
                                      //     "${snapshot.data[index]['data'].toString().split(' ')[0]}");
                                      // print(
                                      //     "pqp se isso funcionar ${snapshot.data[index]['data'].toString().split(' ')[0].toString().split('-')[2].toString()}");
                                      return displayCard(
                                          MongoDbModelExtrato.fromJson(
                                              snapshot.data[index]),
                                          int.parse(
                                              "${snapshot.data[index]['data'].toString().split(' ')[0].toString().split('-')[0]}${snapshot.data[index]['data'].toString().split(' ')[0].toString().split('-')[1]}${snapshot.data[index]['data'].toString().split(' ')[0].toString().split('-')[2]}"),
                                          context);
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text("ih quebrou dando erro");
                            } else {
                              return Text("Ih quebrou no else");
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Extrato",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(onPressed: () {}, child: Icon(Icons.share)),
                    Text(
                      "Mostrar gráfico",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: SizedBox(
                  height: 250,
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
                            Widget displayListView(MongoDbModelExtrato data,
                                BuildContext context) {
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                            .arrow_upward_sharp,
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
                                snapshot.data[index]['cod_cliente']) {
                              return displayListView(
                                  MongoDbModelExtrato.fromJson(
                                      dataExtrato[index]),
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/AdicionarPagamentoPendente',
              arguments: todosArguments);
        },
        backgroundColor: Colors.green,
        shape: CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
