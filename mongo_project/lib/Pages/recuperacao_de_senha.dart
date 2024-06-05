// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//selected color
//unselected color
//icons: login, person, wc, assignment, delete, login_outlined, foward
import 'package:flutter/material.dart';
import 'package:projeto_integrador/_backend/backend_recuperacao_de_senha.dart';

class RecuperacaoDeSenha extends StatefulWidget {
  const RecuperacaoDeSenha({super.key});

  @override
  State<RecuperacaoDeSenha> createState() => RecuperacaoDeSenhaState();
}

class RecuperacaoDeSenhaState extends State<RecuperacaoDeSenha> {
  TextEditingController primeiroController = TextEditingController();
  TextEditingController segundoController = TextEditingController();
  TextEditingController terceiroController = TextEditingController();
  TextEditingController quartoController = TextEditingController();
  TextEditingController quintoController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    inBuildRecuperacaoDeSenha(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Esqueci a senha'),
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
                  Text(
                    "Código",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: TextFormField(
                            controller: primeiroController,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: TextFormField(
                            controller: segundoController,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: TextFormField(
                            controller: terceiroController,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: TextFormField(
                            controller: quartoController,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: TextFormField(
                            controller: quintoController,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Um código será enviado no seu e-mail cadastrado para a redefinição de senha. Caso o código não apareça, clique aqui: ',
                          style: TextStyle(
                              color: Colors.green.shade900, fontSize: 16),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Reenviar código.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green.shade900,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "A VALIDAÇÃO NÃO ESTÁ FUNCIONANDO.\nAPENAS PREENCHA OS CAMPOS COM QUALQUER VALOR.",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.green.shade900),
                            minimumSize:
                                MaterialStateProperty.resolveWith((states) {
                              return Size(300, 50);
                            }),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              //tirei o validador, é melhor um manual aq dentro
                              if (primeiroController.text != '' &&
                                  segundoController.text != '' &&
                                  terceiroController.text != '' &&
                                  quartoController.text != '' &&
                                  quintoController.text != '') {
                                // Você requisitou a mudança de senha. Para realizar a mudança é necessário a confirmação via email, enviamos um código de 5 no email ${todosArguments.dataClient.email}
                                Navigator.pushReplacementNamed(
                                    context, '/RedefinicaoDeSenha');
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actions: [
                                        Center(
                                            child: MaterialButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("Ok"),
                                        ))
                                      ],
                                      // title: Center(child: Text('Error')),
                                      content: Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        height: 50,
                                        child: Text("Código incorreto."),
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          },
                          child: Text(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            'Continuar',
                          )),
                    ],
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
