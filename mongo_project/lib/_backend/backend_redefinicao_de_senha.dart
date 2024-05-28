import 'package:flutter/material.dart';
import 'package:projeto_integrador/zDatabase/mongodb_clientes.dart';

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
void inBuildRedefinicaoDeSenha(context) {
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

String? senha1;
String? senha2;

void senha1OnChange(value) {
  senha1 = value;
}

void senha2OnChange(value) {
  senha2 = value;
}

String? senha1Validator(String? value) {
  value ??= '';
  if (value == '') {
    return 'Este campo não pode ser vazio.';
  } else if (value.length < 8) {
    return 'A senha deve conter no mínimo 8 caracteres.';
  } else if (senha1 != senha2) {
    return 'Senhas diferentes.';
  } else {
    return null;
  }
}

String? senha2Validator(String? value) {
  value ??= '';
  if (value == '') {
    return 'Este campo não pode ser vazio.';
  } else if (senha1 != senha2) {
    return 'Senhas diferentes.';
  } else {
    return null;
  }
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
void continuarOnTap(context) {
  if (formKey.currentState!.validate()) {
    if (senha1 == senha2) {
      todosArguments.dataClientes.senha = senha2;
      if (formKey.currentState!.validate()) {
        MongoDatabaseClientes.updateSenha(todosArguments.dataClientes);
        Navigator.pushReplacementNamed(context, '/Login');
      }
    } else {
      print('ih senha quebrou, formulario foi sem validar');
    }
  }
}