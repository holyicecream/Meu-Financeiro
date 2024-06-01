import 'package:flutter/material.dart';
import '/zDatabase/mongodb_clientes.dart';

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
String novoNome = '';
int count = 0;
bool check = true;
void inBuildSeuNome(context) {
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

String? nomeValidator(String? value) {
  value ??= '';
  if (value == '') {
    return 'Este campo não pode ser vazio.';
  } else {
    return null;
  }
}

void nomeOnChange(value) {
  value ??= '';
  novoNome = value.toString();
}

//final GlobalKey<FormState> formKey = GlobalKey<FormState>();
void salvarAlteracoesOnTap(context, formKey) {
  if (formKey.currentState!.validate()) {
    if (novoNome != '') {
      todosArguments.dataClientes.nomeCliente = novoNome;
    }
    MongoDatabaseClientes.updateNome(todosArguments.dataClientes);
    Navigator.pop(context);
  }
}
