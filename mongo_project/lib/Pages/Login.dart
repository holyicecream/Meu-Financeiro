// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names
//selected color
//unselected color
//icons: login, person, wc, assignment, delete, login_outlined, foward
import 'package:flutter/material.dart';
import 'package:projeto_integrador/_backend/backend_login.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    inBuildLogin(context);
    print(todosArguments.dataClientes.toJson());
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
                          validator: (value) {
                            return emailValidator(value);
                          },
                          onChanged: (value) {
                            emailOnChange(value);
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
                          validator: (value) {
                            return senhaValidator(value);
                          },
                          obscureText: true,
                          onChanged: (value) {
                            senhaOnChange(value);
                          },
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
                          esqueceuASenhaOnTap(context);
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
                                    todosArguments.dataClientes.email &&
                                dataClientes[i]['senha'] ==
                                    todosArguments.dataClientes.senha) {
                              check = false;
                              todosArguments.dataClientes.codCliente =
                                  dataClientes[i]['cod_cliente'];
                              todosArguments.dataClientes.nomeCliente =
                                  dataClientes[i]['nome'];
                              Navigator.pushNamed(context, '/Main',
                                  arguments: todosArguments);
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
                          cadastreseOnTap(context);
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
