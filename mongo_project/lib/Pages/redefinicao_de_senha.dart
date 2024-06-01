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
                          onChanged: (value) {
                            senha1OnChange(value);
                          },
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
                          onChanged: (value) {
                            senha2OnChange(value);
                          },
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
                          if (senha1 == senha2) {
                            todosArguments.dataClientes.senha = senha2;

                            MongoDatabaseClientes.updateSenha(
                                todosArguments.dataClientes);
                            Navigator.pushReplacementNamed(context, '/Login');
                          } else {
                            print(
                                'ih senha quebrou, formulario foi sem validar');
                          }
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
