// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//selected color
//unselected color
//icons: login, person, wc, assignment, delete, login_outlined, foward
import 'package:flutter/material.dart';
import 'package:projeto_integrador/_backend/backend_redefinicao_de_senha.dart';

import '../zDatabase/mongodb_clientes.dart';

class RedefinicaoDeSenha extends StatefulWidget {
  const RedefinicaoDeSenha({super.key});

  @override
  State<RedefinicaoDeSenha> createState() => RedefinicaoDeSenhaState();
}

class RedefinicaoDeSenhaState extends State<RedefinicaoDeSenha> {
  TextEditingController senha1Controller = TextEditingController();
  TextEditingController senha2Controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    inBuildRedefinicaoDeSenha(context);
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
                          controller: senha1Controller,
                          validator: (value) {
                            return senha1Validator(value);
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
                          controller: senha2Controller,
                          validator: (value) {
                            return senha2Validator(value);
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
                            todosArguments.dataClientes.senha = senha2Controller.text;

                            MongoDatabaseClientes.updateSenha(
                                todosArguments.dataClientes);
                            Navigator.pushReplacementNamed(context, '/Login', arguments: todosArguments);
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
                      child: Text("Continuar"),
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
