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
    todosArguments.dataClientes.email = '';
    todosArguments.dataClientes.senha = '';
  }

  MongoDatabaseClientes.getData().then(
    (value) {
      dataClientes = value;
    },
  );
}

String? emailValidator(String? value) {
  value ??= '';
  if (value == '') {
    return 'Este campo não pode ser vazio.';
  } else {
    return null;
  }
}

String? senhaValidator(String? value) {
  value ??= '';
  if (value == '') {
    return 'Este campo não pode ser vazio.';
  } else {
    return null;
  }
}

void emailOnChange(value) {
  todosArguments.dataClientes.email = value;
}

void senhaOnChange(value) {
  todosArguments.dataClientes.senha = value;
}

void cadastreseOnTap(context) {
  Navigator.pushReplacementNamed(context, '/Cadastro',
      arguments: todosArguments);
}

void esqueceuASenhaOnTap(context) {
  Navigator.pushNamed(context, '/RecuperacaoDeSenha',
      arguments: todosArguments);
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
void entrarOnTap(context) {
  if (formKey.currentState!.validate()) {
    bool check = true;

    for (var i = 0; i < dataClientes.length; i++) {
      if (dataClientes[i]['email'] == todosArguments.dataClientes.email &&
          dataClientes[i]['senha'] == todosArguments.dataClientes.senha) {
        check = false;
        todosArguments.dataClientes.codCliente = dataClientes[i]['cod_cliente'];
        todosArguments.dataClientes.nomeCliente = dataClientes[i]['nome'];
        Navigator.pushNamed(context, '/Main', arguments: todosArguments);
        // Navigator.pushNamed(context, '/VinculoBancarioOuInserçãoManual', arguments: todosArguments);
      }
    }
    if (check) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              Center(
                  child: MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Ok"),
              ))
            ],
            // title: Center(child: Text('Error')),
            content: Container(
              alignment: Alignment.center,
              width: 50,
              height: 50,
              child: Text("Email ou Senha inválidos."),
            ),
          );
        },
      );
    }
  }
}
