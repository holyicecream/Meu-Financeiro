import 'package:flutter/material.dart';

import '../zDatabase/mongodb_clientes.dart';
import '../zModels/model_area_consumo.dart';
import '../zModels/model_bancos.dart';
import '../zModels/model_bancos_usuario.dart';
import '../zModels/model_clientes.dart';
import '../zModels/model_extrato.dart';
import '../zModels/model_tipo_transacao.dart';
import '../zModels/todos_arguments.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  TodosArguments todosArguments = TodosArguments(
    dataAreaConsumo: MongoDbModelAreaConsumo(),
    dataBancosUsuario: MongoDbModelBancosUsuario(),
    dataBancos: MongoDbModelBancos(),
    dataClientes: MongoDbModelClientes(),
    dataExtrato: MongoDbModelExtrato(),
    dataTransacao: MongoDbModelTipoTransacao(),
  );
  List<Map<String, dynamic>> dataClientes = [
    {'': ''}
  ];
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int count = 0;
  @override
  Widget build(BuildContext context) {
    count++;
    // ignore: avoid_print
    print("build login $count");
    try {
      todosArguments =
          ModalRoute.of(context)!.settings.arguments as TodosArguments;
    } catch (e) {
      // print(e.toString());
    }
    MongoDatabaseClientes.getData().then(
      (value) {
        if (value.isNotEmpty) {
          dataClientes = value;
        }
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Entrar'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            value ??= '';
                            if (value == '') {
                              return 'Este campo não pode ser vazio.';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'E-mail',
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: senhaController,
                          validator: (value) {
                            value ??= '';
                            if (value == '') {
                              return 'Este campo não pode ser vazio.';
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Senha',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: Text(
                          "Esqueceu a senha?",
                          style: TextStyle(color: Colors.green.shade900),
                        ),
                        onTap: () {
                          todosArguments.dataClientes.email =
                              emailController.text;
                          Navigator.pushReplacementNamed(
                              context, '/RecuperacaoDeSenha',
                              arguments: todosArguments);
                        },
                      ),
                      const Text(''),
                      const Text(''),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      Icon(Icons.square),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Continuar conectado?"),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          bool check = true;
                          for (var i = 0; i < dataClientes.length; i++) {
                            if (dataClientes[i]['email'] ==
                                    emailController.text &&
                                dataClientes[i]['senha'] ==
                                    senhaController.text) {
                              todosArguments.dataClientes.email =
                                  emailController.text;
                              todosArguments.dataClientes.senha =
                                  senhaController.text;
                              check = false;
                              todosArguments.dataClientes.codCliente =
                                  dataClientes[i]['cod_cliente'];
                              todosArguments.dataClientes.nomeCliente =
                                  dataClientes[i]['nome_cliente'];
                              Navigator.pushReplacementNamed(
                                  context, '/SelecaoDeBanco',
                                  arguments: todosArguments);
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
                                      child: const Text("Ok"),
                                    ))
                                  ],
                                  content: Container(
                                    alignment: Alignment.center,
                                    width: 50,
                                    height: 50,
                                    child:
                                        const Text("Email ou Senha inválidos."),
                                  ),
                                );
                              },
                            );
                          }
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.green.shade900),
                        minimumSize:
                            MaterialStateProperty.resolveWith((states) {
                          return const Size(250, 50);
                        }),
                      ),
                      child: const Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Ainda não possui cadastro?  "),
                      GestureDetector(
                        child: const Text("Cadastre-se."),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/Cadastro',
                              arguments: todosArguments);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
