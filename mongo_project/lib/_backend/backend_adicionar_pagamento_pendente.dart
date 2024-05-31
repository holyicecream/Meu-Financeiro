import 'package:flutter/material.dart';
import 'package:projeto_integrador/zDatabase/mongodb_extrato.dart';

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
void inBuildAdicionarPagamentoPendente(context) {
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

void nomeOnChange(value) {
  todosArguments.dataExtrato.nomeDestinatario = value;
}

void valorOnChange(value) {
  value??=0;
  todosArguments.dataExtrato.valor = double.tryParse(value);
}

void dataOnChange(value) {
  value??=DateTime.now().toIso8601String();
  print(value);
  DateTime.tryParse(value);
  print(value);

  // todosArguments.dataExtrato.data = DateTime.tryParse(value);
}

void tipoTransacaoOnChange(value) {
  todosArguments.dataExtrato.codTransacao = int.tryParse(value);
}

void descricaoOnChange(value) {
  todosArguments.dataExtrato.descricaoTransacao = value;
}

String? groupValue;
void debitoCreditoOnChanged(value) {
  value??='debito';
  if(value == 'Pago'){
  todosArguments.dataExtrato.debitoCredito = 'debito';
  }
  else if(value == "Recebido"){
    todosArguments.dataExtrato.debitoCredito = 'credito';
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

String? valorValidator(String? value) {
  value??= '0';
  print(value);
  if (value == '0') {
    return 'Este campo não pode ser vazio.';
  } else {
    return null;
  }
}

String? dataValidator(String? value) {
  value ??= '';
  if (value == '') {
    return 'Este campo não pode ser vazio.';
  } else {
    return null;
  }
}

String? descricaoValidator(String? value) {
  value ??= '';
  if (value == '') {
    return 'Este campo não pode ser vazio.';
  } else {
    return null;
  }
}

String? debitoCreditoValidator(String? value) {
  value ??= '';
  if (value == '') {
    return 'Este campo não pode ser vazio.';
  } else {
    return null;
  }
}

void salvarOnTap(context, formKey) {
  if (formKey.currentState!.validate()) {
    print("foi");
    todosArguments.dataExtrato.codBanco = todosArguments.dataBancos.codBanco;
    todosArguments.dataExtrato.codCliente =
        todosArguments.dataClientes.codCliente;
    MongoDatabaseExtrato.insert(todosArguments.dataExtrato)
        .then((value) => Navigator.pushReplacementNamed(context, '/Main'));
  }
}
