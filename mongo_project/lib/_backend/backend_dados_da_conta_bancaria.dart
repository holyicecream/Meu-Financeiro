import 'package:flutter/material.dart';

import 'package:fixnum/fixnum.dart';
import '../zDatabase/mongodb_bancos_usuario.dart';
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

List<Map<String, dynamic>> dataBancosUsuario = [
  {'': ''}
];

int count = 0;
bool check = true;
void inBuildDadosDaContaBancaria(context) {
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

  MongoDatabaseBancosUsuario.getData().then(
    (value) {
      dataBancosUsuario = value;
      todosArguments.dataBancosUsuario.codBancoUsuario =
          (value[value.length - 1]['cod_bancoUsuario'] + 1);
    },
  );
  todosArguments.dataBancosUsuario.codCliente =
      todosArguments.dataClientes.codCliente;
  todosArguments.dataBancosUsuario.codBanco =
      todosArguments.dataBancos.codBanco;
  todosArguments.dataBancosUsuario.cpf = Int64.parseInt('0');
}

void contaCorrenteOnChange(value) {
  todosArguments.dataBancosUsuario.contaCorrente = value;
}

void agenciaOnChange(value) {
  todosArguments.dataBancosUsuario.agencia = value;
}

void cpfOnChange(value) {
  todosArguments.dataBancosUsuario.cpf = Int64.tryParseInt(value);
}

String? senhaAtual = '';
void senhaOnChange(value) {
  senhaAtual = value;
}

String? contaCorrenteValidator(String? value) {
  value ??= '';
  if (value == '') {
    return 'Este campo não pode ser vazio.';
  } else {
    return null;
  }
}

String? agenciaValidator(String? value) {
  value ??= '';
  if (value == '') {
    return 'Este campo não pode ser vazio.';
  } else {
    return null;
  }
}

String? cpfValidator(String? value) {
  value ??= '';
  if (value == '') {
    return 'Este campo não pode ser vazio.';
  } else if (value.length < 11) {
    return 'CPF inválido.';
  } else {
    return null;
  }
}

String? senhaValidator(String? value) {
  value ??= '';
  if (value == '') {
    return 'Este campo não pode ser vazio.';
  } else if (todosArguments.dataClientes.senha == '') {
    return 'ih a senha quebrou';
  } else if (todosArguments.dataClientes.senha != value) {
    return 'Senha incorreta.';
  } else {
    return null;
  }
}

//final GlobalKey<FormState> formKey = GlobalKey<FormState>();
void adicionarOnTap(context, formKey) {
  if (formKey.currentState!.validate()) {
    if (todosArguments.dataBancosUsuario.codBancoUsuario != null &&
        todosArguments.dataBancosUsuario.codCliente != 0 &&
        todosArguments.dataBancosUsuario.codBanco != 0 &&
        todosArguments.dataBancosUsuario.agencia != '' &&
        todosArguments.dataBancosUsuario.contaCorrente != '' &&
        todosArguments.dataBancosUsuario.cpf != 0) {
      MongoDatabaseBancosUsuario.insert(todosArguments.dataBancosUsuario);
      Navigator.pushReplacementNamed(context, '/Main',
          arguments: todosArguments);
    } else {}
  }
}
