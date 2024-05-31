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

double saldo = 0;
double pagamentosPendentesValue = 0;
String nome = '';
// Widget pagamentosPendentesFull = SingleChildScrollView(
//   scrollDirection: Axis.horizontal,
//   child: Row(
//     children: pagamentosPendentes,
//   ),
// );
List<Widget> pagamentosPendentes = [
  GestureDetector(
    onTap: () {
      // Navigator.pushNamed(context, '/PageTeste', arguments: todosArguments);
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
];

Widget extrato = Container();

int count = 0;
// bool check = true;
void inBuildTelaPrincipal(context) {
  if(count > 2){
    count = 0;
  }
  count++;
  print("build $count");
  if (count < 3) {
    try {
      todosArguments =
          ModalRoute.of(context)!.settings.arguments as TodosArguments;
      print('cade');
      cardPagamentosPendentes(context);
      extrato = listViewExtrato(context);
    } catch (e) {
      // print(e.toString());
    }
    nome = todosArguments.dataClientes.nomeCliente.toString();
    saldo = todosArguments.salario;
    // print(nome);

    MongoDatabaseClientes.getData().then((value) {
      for (var i = 0; i < value.length; i++) {
        if (value[i]['cod_cliente'] == todosArguments.dataClientes.codCliente) {
          todosArguments.dataClientes.nomeCliente = value[i]['nome_cliente'];
          print(todosArguments.dataClientes.toJson());
        }
      }
    });

    MongoDatabaseExtrato.getData().then(
      (value) {
        dataExtrato = value;
        for (var i = 0; i < value.length; i++) {
          if (value[i]['cod_cliente'] ==
                  todosArguments.dataClientes.codCliente &&
              value[i]['debito_credito'] == "debito") {
            saldo -= value[i]['valor'];
          } else if (value[i]['cod_cliente'] ==
                  todosArguments.dataClientes.codCliente &&
              value[i]['debito_credito'] == "credito") {
            saldo += value[i]['valor'];
          }
        }
        for (var i = 0; i < value.length; i++) {
          if (value[i]['cod_cliente'] ==
                  todosArguments.dataClientes.codCliente &&
              value[i]['data'].day >= DateTime.now().day &&
              value[i]['debito_credito'] == "debito") {
            pagamentosPendentesValue -= value[i]['valor'];
          } else if (value[i]['cod_cliente'] ==
                  todosArguments.dataClientes.codCliente &&
              value[i]['data'].day >= DateTime.now().day &&
              value[i]['debito_credito'] == "credito") {
            pagamentosPendentesValue += value[i]['valor'];
          }
        }
        todosArguments.dataExtrato;
        print("saldo $saldo");
        print("value $pagamentosPendentesValue");
      },
    );
  }
}

String? nomeConfia() {
  return todosArguments.dataClientes.nomeCliente;
}

Widget displayCard(
    MongoDbModelExtrato data, String debitocredito, BuildContext context) {
  print("aqui${data.toJson()}");
  if (debitocredito == 'debito') {
    return GestureDetector(
      onTap: () {
        // todosArguments.dataExtrato = data;
        // Navigator.pushNamed(context, '/PageTeste', arguments: todosArguments);
      },
      child: SizedBox(
        height: 125,
        width: 125,
        child: Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/280x280_RS/2e/22/90/2e229065b0e9a509755d371e6050b4fe.jpg'),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_downward_sharp,
                      color: Colors.red,
                    ),
                    Text(data.valor.toString()),
                  ],
                ),
                Text(data.nomeDestinatario.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  } else {
    return GestureDetector(
      onTap: () {
        // todosArguments.dataExtrato = data;
        // Navigator.pushNamed(context, '/PageTeste', arguments: todosArguments);
      },
      child: SizedBox(
        height: 125,
        width: 125,
        child: Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/280x280_RS/2e/22/90/2e229065b0e9a509755d371e6050b4fe.jpg'),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: Colors.green,
                    ),
                    Text(data.valor.toString()),
                  ],
                ),
                Text(data.nomeDestinatario.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> cardPagamentosPendentes(context) {
  for (var i = 0; i < dataExtrato.length; i++) {
    if (dataExtrato[i]['cod_cliente'] ==
            todosArguments.dataClientes.codCliente &&
        dataExtrato[i]['data'].day >= DateTime.now().day) {
      if (dataExtrato[i]['debito_credito'] == 'debito') {
        pagamentosPendentes.add(displayCard(
            MongoDbModelExtrato.fromJson(dataExtrato[i]), 'debito', context));
      } else if (dataExtrato[i]['debito_credito'] == 'credito') {
        pagamentosPendentes.add(displayCard(
            MongoDbModelExtrato.fromJson(dataExtrato[i]), 'credito', context));
      }
    }
  }
  return pagamentosPendentes;
}

Widget displayListView(
    MongoDbModelExtrato data, String debitocredito, BuildContext context) {
  if (debitocredito == 'debito') {
    return GestureDetector(
      onTap: () {
        // todosArguments.dataExtrato = data;
        // Navigator.pushNamed(context, '/PageTeste', arguments: todosArguments);
      },
      child: Row(
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.nomeDestinatario.toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(data.descricaoTransacao.toString()),
                      ],
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.arrow_downward_sharp,
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
        // Navigator.pushNamed(context, '/PageTeste', arguments: todosArguments);
      },
      child: Row(
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.nomeDestinatario.toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(data.descricaoTransacao.toString()),
                      ],
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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

Widget listViewExtrato(context) {
  print(dataExtrato.length);
  return Expanded(
    child: ListView.builder(
      itemCount: dataExtrato.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (dataExtrato[index]['cod_cliente'] == 1) {
          if (dataExtrato[index]['debito_credito'] == 'debito') {
            return displayListView(
                MongoDbModelExtrato.fromJson(dataExtrato[index]),
                'debito',
                context);
          } else if (dataExtrato[index]['debito_credito'] == 'credito') {
            return displayListView(
                MongoDbModelExtrato.fromJson(dataExtrato[index]),
                'credito',
                context);
          }
        } else {
          return null;
        }

        return null;
      },
    ),
  );
}

void drawerNomeOnTap(context) {
  Navigator.pushReplacementNamed(context, '/PageTeste',
      arguments: todosArguments);
}

void drawerSenhaOnTap(context) {
  Navigator.pushReplacementNamed(context, '/PageTeste',
      arguments: todosArguments);
}

void drawerAjudaOnTap(context) {
  Navigator.pushReplacementNamed(context, '/PageTeste',
      arguments: todosArguments);
}

void drawerContaOnTap(context) {
  Navigator.pushReplacementNamed(context, '/PageTeste',
      arguments: todosArguments);
}

void floatBtnOnTap(context) {
  // Navigator.pushReplacementNamed(context, '/PageTeste',
  //     arguments: todosArguments);
}
