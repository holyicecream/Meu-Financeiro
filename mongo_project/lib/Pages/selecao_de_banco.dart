// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projeto_integrador/zDatabase/mongodb_bancos.dart';
import '../zModels/model_area_consumo.dart';
import '../zModels/model_bancos_usuario.dart';
import '../zModels/model_bancos.dart';
import '../zModels/model_clientes.dart';
import '../zModels/model_extrato.dart';
import '../zModels/model_tipo_transacao.dart';
import '../zModels/todos_arguments.dart';

class SelecaoDeBanco extends StatefulWidget {
  const SelecaoDeBanco({super.key});

  @override
  State<SelecaoDeBanco> createState() => SelecaoDeBancoState();
}

class SelecaoDeBancoState extends State<SelecaoDeBanco> {
  TodosArguments todosArguments = TodosArguments(
    dataAreaConsumo: MongoDbModelAreaConsumo(),
    dataBancosUsuario: MongoDbModelBancosUsuario(),
    dataBancos: MongoDbModelBancos(),
    dataClientes: MongoDbModelClientes(),
    dataExtrato: MongoDbModelExtrato(),
    dataTransacao: MongoDbModelTipoTransacao(),
  );
  List<Map<String, dynamic>> dataBancos = [];
  List<Map<String, dynamic>> dataBancosSearch = [];
  TextEditingController pesquisaController = TextEditingController();
  int count = 0;

  @override
  void initState() {
    super.initState();
    MongoDatabaseBancos.getData().then(
      (value) {
        print('primeiro build?');
        dataBancos = value;
      },
    );
  }

 @override
Widget build(BuildContext context) {
  count++;
  print("build selecaoDeBanco $count");
  try {
    todosArguments = ModalRoute.of(context)!.settings.arguments as TodosArguments;
  } catch (e) {
    // print(e.toString());
  }

  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Colors.green,
      title: const Text(
        "Seleção de Banco",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  controller: pesquisaController,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      dataBancosSearch = dataBancos;
                    } else {
                      dataBancosSearch = dataBancos.where((x) => x['banco']
                          .toLowerCase()
                          .contains(value.toLowerCase())).toList();
                    }
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Busque por instituição',
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
                FutureBuilder(
                  future: MongoDatabaseBancos.getData(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      dataBancos = snapshot.data;
                      if (pesquisaController.text.isEmpty) {
                        dataBancosSearch = dataBancos;
                      }
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: dataBancosSearch.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Widget leadingText;
                          Widget titleText;
                          try {
                            leadingText = Text(dataBancosSearch[index]['banco']
                                .toString()
                                .split('-')[0]);
                            titleText = Text(dataBancosSearch[index]['banco']
                                .toString()
                                .split('-')[1]);
                          } catch (e) {
                            print("ali olha $e");
                            leadingText = const Text('');
                            titleText = const Text('');
                          }
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Card(
                              child: ListTile(
                                iconColor: Colors.black,
                                onTap: () {
                                  todosArguments.dataBancos.codBanco =
                                      dataBancosSearch[index]['cod_banco'];
                                  todosArguments.dataBancos.banco =
                                      dataBancosSearch[index]['banco'];
                                  todosArguments.dataExtrato.codBanco =
                                      dataBancosSearch[index]['cod_banco'];
                                  todosArguments.dataBancosUsuario.codBanco =
                                      dataBancosSearch[index]['cod_banco'];
                                  Navigator.pushReplacementNamed(context, '/Main',
                                      arguments: todosArguments);
                                },
                                leading: leadingText,
                                title: titleText,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
}