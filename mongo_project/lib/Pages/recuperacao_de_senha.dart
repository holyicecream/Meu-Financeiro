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
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                            validator: (value) => primeiroValidator(value),
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
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                            validator: (value) => segundoValidator(value),
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
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                            validator: (value) => terceiroValidator(value),
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
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                            validator: (value) => quartoValidator(value),
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
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                            validator: (value) => quintoValidator(value),
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
                      )),
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
                              // Você requisitou a mudança de senha. Para realizar a mudança é necessário a confirmação via email, enviamos um código de 5 no email ${todosArguments.dataClient.email}
                              Navigator.pushReplacementNamed(
                                  context, '/RedefinicaoDeSenha');
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
