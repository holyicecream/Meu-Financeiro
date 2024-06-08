//selected color
//unselected color
//icons: login, person, wc, assignment, delete, login_outlined, foward
import 'package:flutter/material.dart';
// import 'package:projeto_integrador/_backend/backend_redefinicao_de_senha.dart';
import '../zDatabase/mongodb_clientes.dart';
import '../zModels/model_area_consumo.dart';
import '../zModels/model_bancos_usuario.dart';
import '../zModels/model_bancos.dart';
import '../zModels/model_clientes.dart';
import '../zModels/model_extrato.dart';
import '../zModels/model_tipo_transacao.dart';
import '../zModels/todos_arguments.dart';

class RedefinicaoDeSenha extends StatefulWidget {
  const RedefinicaoDeSenha({super.key});

  @override
  State<RedefinicaoDeSenha> createState() => RedefinicaoDeSenhaState();
}

class RedefinicaoDeSenhaState extends State<RedefinicaoDeSenha> {
  TodosArguments todosArguments = TodosArguments(
    dataAreaConsumo: MongoDbModelAreaConsumo(),
    dataBancosUsuario: MongoDbModelBancosUsuario(),
    dataBancos: MongoDbModelBancos(),
    dataClientes: MongoDbModelClientes(),
    dataExtrato: MongoDbModelExtrato(),
    dataTransacao: MongoDbModelTipoTransacao(),
  );
  TextEditingController senha1Controller = TextEditingController();
  TextEditingController senha2Controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int count = 0;
  @override
  Widget build(BuildContext context) {
    count++;
    print("build redefinicaoDeSenha $count");
    try {
      todosArguments =
          ModalRoute.of(context)!.settings.arguments as TodosArguments;
    } catch (e) {
      // print(e.toString());
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Alterar senha'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          obscureText: true,
                          controller: senha1Controller,
                          validator: (value) {
                            value ??= '';
                            if (value == '') {
                              return 'Este campo não pode ser vazio.';
                            } else if (value.length < 8) {
                              return 'A senha deve conter no mínimo 8 caracteres.';
                            } else if (senha1Controller.text !=
                                senha2Controller.text) {
                              return 'Senhas diferentes.';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Senha nova',
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: senha2Controller,
                          validator: (value) {
                            value ??= '';
                            if (value == '') {
                              return 'Este campo não pode ser vazio.';
                            } else if (senha1Controller.text !=
                                senha2Controller.text) {
                              return 'Senhas diferentes.';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Confirmar senha nova',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          todosArguments.dataClientes.senha =
                              senha2Controller.text;
                          print(todosArguments.dataClientes.email);
                          print(todosArguments.dataClientes.senha);
                          MongoDatabaseClientes.updateSenhaByEmail(
                              todosArguments.dataClientes);
                          Navigator.pushReplacementNamed(context, '/Login',
                              arguments: todosArguments);
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.green),
                        minimumSize:
                            MaterialStateProperty.resolveWith((states) {
                          return Size(200, 50);
                        }),
                      ),
                      child: Text(
                        "Salvar Alterações",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
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
