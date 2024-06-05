// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names
import 'package:flutter/material.dart';
import '../zDatabase/mongodb_clientes.dart';
import '../zModels/model_area_consumo.dart';
import '../zModels/model_bancos_usuario.dart';
import '../zModels/model_bancos.dart';
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
    print("build login $count");
    // inBuildLogin(context);
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
        title: Text('Entrar'),
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
                          controller: emailController,
                          validator: (value) {
                            value ??= '';
                            if (value == '') {
                              return 'Este campo não pode ser vazio.';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'E-mail',
                          ),
                        ),
                        SizedBox(
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
                          decoration: InputDecoration(
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
                          Navigator.pushReplacementNamed(context, '/RecuperacaoDeSenha',
                              arguments: todosArguments);
                        },
                      ),
                      Text(''),
                      Text(''),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
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
                  SizedBox(
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
                              print("login.dart linha ~123 ver dps");
                              Navigator.pushReplacementNamed(context, '/SelecaoDeBanco',
                                  arguments: todosArguments);
                              // Navigator.pushNamed(context, '/DadosDaContaBancaria', arguments: todosArguments);
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
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.green.shade900),
                        minimumSize:
                            MaterialStateProperty.resolveWith((states) {
                          return Size(250, 50);
                        }),
                      ),
                      child: Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Ainda não possui cadastro?  "),
                      GestureDetector(
                        child: Text("Cadastre-se."),
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
