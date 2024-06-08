// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool escondesaldo = false;
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
    MongoDatabaseExtrato.getDataByCodCli(
            todosArguments.dataClientes.codCliente ?? 0)
        .then(
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
        width: (MediaQuery.of(context).size.width) / 1.5,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [],
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1.0, color: Color(0xFF7ED957)),
                )),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/PersonalizarNome',
                        arguments: todosArguments);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Seu nome',
                        style:
                            TextStyle(color: Color(0xFF292929), fontSize: 16),
                      ),
                      SizedBox(
                        width: 90,
                      ),
                      Icon(
                        Icons.login,
                        color: Color(0xFF224912),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1.0, color: Color(0xFF7ED957)),
                )),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/AlterarSenha',
                        arguments: todosArguments);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Alterar senha',
                        style:
                            TextStyle(color: Color(0xFF292929), fontSize: 16),
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Icon(Icons.person, color: Color(0xFF224912)),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1.0, color: Color(0xFF7ED957)),
                )),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, '/AlterarContaBancaria',
                        arguments: todosArguments);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Conta bancária',
                          style: TextStyle(
                              color: Color(0xFF292929), fontSize: 16)),
                      SizedBox(
                        width: 55,
                      ),
                      Icon(Icons.wc, color: Color(0xFF224912)),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                    // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Sair do app',
                          style: TextStyle(
                              color: Color(0xFF7ED957), fontSize: 16)),
                      SizedBox(
                        width: 85,
                      ),
                      Icon(Icons.logout, color: Color(0xFF7ED957)),
                    ],
                  ),
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
                              fontSize: 16,
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
                            future: MongoDatabaseExtrato.getDataByCodCli(
                                todosArguments.dataClientes.codCliente ?? 0),
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
                                if (escondesaldo == false) {
                                  widgetSaldo = Text(
                                    'R\$ $saldo',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  );
                                } else {
                                  widgetSaldo = Text(
                                    '******',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  );
                                }
                                return widgetSaldo;
                              } else {
                                return widgetSaldo;
                              }
                            },
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  escondesaldo = !escondesaldo;
                                });
                              },
                              child: Icon(
                                Icons.remove_red_eye_rounded,
                                color: Colors.white,
                              ))
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
                      future: MongoDatabaseExtrato.getDataByCodCli(
                          todosArguments.dataClientes.codCliente ?? 0),
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
                          if (escondesaldo == false) {
                            widgetPagamentosPendentesValue = Text(
                              "R\$ ${pagamentosPendentesValue.toString()}",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            );
                          } else {
                            widgetPagamentosPendentesValue = Text(
                              "******",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            );
                          }

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, '/AdicionarPagamentoPendente',
                            arguments: todosArguments);
                      },
                      child: SizedBox(
                        width: 125,
                        height: 125,
                        child: Card(
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Color(0xFF224912),
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
                          future: MongoDatabaseExtrato.getDataByCodCli(
                              todosArguments.dataClientes.codCliente ?? 0),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  // child: CircularProgressIndicator(),
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
                                      if (data.debitoCredito == 'debito' &&
                                          day >=
                                              int.parse(
                                                  "${DateTime.now().toString().split(' ')[0].toString().split('-')[0]}${DateTime.now().toString().split(' ')[0].toString().split('-')[1]}${DateTime.now().toString().split(' ')[0].toString().split('-')[2]}")) {
                                        return GestureDetector(
                                          onTap: () {
                                            todosArguments.dataExtrato = data;
                                            Navigator.pushReplacementNamed(
                                                context,
                                                '/EditarPagamentoPendente',
                                                arguments: todosArguments);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
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
                                                        backgroundColor: Colors
                                                            .grey.shade400,
                                                        // backgroundImage:
                                                        //     NetworkImage(
                                                        //         'https://i.pinimg.com/280x280_RS/2e/22/90/2e229065b0e9a509755d371e6050b4fe.jpg'),
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
                                            todosArguments.dataExtrato = data;
                                            Navigator.pushReplacementNamed(
                                                context,
                                                '/EditarPagamentoPendente',
                                                arguments: todosArguments);
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
                                                        backgroundColor: Colors
                                                            .grey.shade400,
                                                        // backgroundImage:
                                                        //     NetworkImage(
                                                        //         'https://i.pinimg.com/280x280_RS/2e/22/90/2e229065b0e9a509755d371e6050b4fe.jpg'),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/Extrato',
                            arguments: todosArguments);
                      },
                      child: SizedBox(
                        width: (MediaQuery.of(context).size.width) / 4,
                        child: Text(
                          "Extrato",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Icon(
                          Icons.share,
                          color: Color.fromRGBO(34, 72, 20, 1),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, "/GraficoDiario",
                            arguments: todosArguments);
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Text(
                          "Mostrar gráfico",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: SizedBox(
                  height: 250,
                  child: FutureBuilder(
                    future: MongoDatabaseExtrato.getDataByCodCli(
                        todosArguments.dataClientes.codCliente ?? 0),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            // child: CircularProgressIndicator(),
                            );
                      } else if (snapshot.hasData) {
                        snapshot.data.reversed.toList();
                        int itemCountOfc = 10;
                        if (snapshot.data.length < 10) {
                          itemCountOfc = snapshot.data.length;
                        }

                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: itemCountOfc,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            int reversedIndex = itemCountOfc - 1 - index;
                            Widget displayListView(MongoDbModelExtrato data,
                                BuildContext context) {
                              if (data.debitoCredito == 'debito') {
                                return GestureDetector(
                                  onTap: () {
                                    todosArguments.dataExtrato = data;
                                    Navigator.pushNamed(context, '/Extrato',
                                        arguments: todosArguments);
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
                                    todosArguments.dataExtrato = data;
                                    Navigator.pushNamed(context, '/Extrato',
                                        arguments: todosArguments);
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/AdicionarPagamentoPendente',
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
