import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
int count = 0;
bool check = true;
void inBuildSelecaoDeBanco(context) {
  count++;
  print("build $count");
  if (check) {
    check = false;
    try {
      todosArguments =
          ModalRoute.of(context)!.settings.arguments as TodosArguments;
    } catch (e) {
      // print(e.toString());
    }
  }
}

String? search;
void contaCorrenteOnChange(value) {
  search = value.toString();
}

List<Widget> primeiraLista = [];
List<Widget> segundaLista = [];

void bancoOnTap(value, context) {
  todosArguments.dataBancos.codBanco = value;
  Navigator.pushNamed(context, '/DadosDaContaBancaria', arguments: todosArguments);
}

// void naoEncontreiMeuBancoOnTap(value, context) {
//   todosArguments.dataBancos.codBanco = 0;
// }
