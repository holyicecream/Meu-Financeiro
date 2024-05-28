import 'dart:math';

import 'package:flutter/material.dart';

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
void inBuildRecuperacaoDeSenha(context) {
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
    todosArguments.dataClientes.nomeCliente = 'é isso';
    num1 = Random().nextInt(9);
    num2 = Random().nextInt(9);
    num3 = Random().nextInt(9);
    num4 = Random().nextInt(9);
    num5 = Random().nextInt(9);
    print("${num1.toString()}, ${num2.toString()}, ${num3.toString()}, ${num4.toString()}, ${num5.toString()}");
  }
}

int num1 = 0;
int num2 = 0;
int num3 = 0;
int num4 = 0;
int num5 = 0;

String? primeiroValidator(String? value) {
  value ??= '';
  if (value == '') {
    return '*';
  } else if (num1.toString() == value) {
    return null;
  } else {
    return null;
  }
}

String? segundoValidator(String? value) {
  value ??= '';
  if (value == '') {
    return '*';
  } else if (num1.toString() == value) {
    return null;
  } else {
    return null;
  }
}

String? terceiroValidator(String? value) {
  value ??= '';
  if (value == '') {
    return '*';
  } else if (num1.toString() == value) {
    return null;
  } else {
    return null;
  }
}

String? quartoValidator(String? value) {
  value ??= '';
  if (value == '') {
    return '*';
  } else if (num1.toString() == value) {
    return null;
  } else {
    return null;
  }
}

String? quintoValidator(String? value) {
  value ??= '';
  if (value == '') {
    return '*';
  } else if (num1.toString() == value) {
    return null;
  } else {
    return null;
  }
}

void reenviarCodigo() {
  print('É não sei como fazer isso ainda');
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
void continuarOnTap(context) {
  if (formKey.currentState!.validate()) {
    // Você requisitou a mudança de senha. Para realizar a mudança é necessário a confirmação via email, enviamos um código de 5 no email ${todosArguments.dataClient.email}
    Navigator.pushReplacementNamed(context, '/RedefinicaoDeSenha');
  }
}
