// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import '../zDatabase/mongodb_clientes.dart';
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
List<Map<String, dynamic>> dataClientes = [
  {'': ''}
];
void inBuildLogin(context) {
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

  MongoDatabaseClientes.getData().then(
    (value) {
      dataClientes = value;
      todosArguments.dataClientes.codCliente = (value[value.length - 1]['cod_cliente'] + 1);
    },
  );

}

void nomeOnChange(value) {
  todosArguments.dataClientes.nomeCliente = value;
}

void emailOnChange(value) {
  todosArguments.dataClientes.email = value;
}

void senhaOnChange(value) {
  todosArguments.dataClientes.senha = value;
}

String? nomeValidator(String? value) {
  value ??= '';
  if (value == '') {
    return 'Este campo não pode ser vazio.';
  } else {
    return null;
  }
}

String? emailValidator(String? value) {
  value ??= '';
  if (value == '') {
    return 'Este campo não pode ser vazio.';
  } else if (!value.contains('@')) {
    return 'Email inválido';
  } else {
    return null;
  }
}

String? senhaValidator(String? value) {
  value ??= '';
  if (value == '') {
    return 'Este campo não pode ser vazio.';
  } else if (value.length < 8) {
    return 'A senha deve conter no mínimo 8 caracteres.';
  } else {
    return null;
  }
}

void cadastroOnTap(context) {
  MongoDbModelClientes data = todosArguments.dataClientes;
  if (todosArguments.dataClientes.email != '' &&
      todosArguments.dataClientes.senha != '' &&
      todosArguments.dataClientes.nomeCliente != '') {
    MongoDatabaseClientes.insert(data);
    Navigator.pushReplacementNamed(context, '/Login',
        arguments: todosArguments);
  } else {}
}

void entrarOnTap(context){
  Navigator.pushReplacementNamed(context, '/Login', arguments: todosArguments);
}