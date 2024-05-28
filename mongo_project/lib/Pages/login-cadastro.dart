// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '/_backend/backend_tela_principal.dart';

class LoginCadastro extends StatefulWidget {
  const LoginCadastro({super.key});

  @override
  State<LoginCadastro> createState() => LoginCadastroState();
}

class LoginCadastroState extends State<LoginCadastro> {
  int indexDoBottom = 0;
  @override
  Widget build(BuildContext context) {
    inBuildTelaPrincipal(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: Color(0xFF224912),
                width: double.infinity,
                height: 400,
                child: Image(image: AssetImage("assets/home-image.png")),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                        width: 250,
                        height: 60,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/Login');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF7ED957),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14))),
                            child: Text(
                              "Entrar",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[900],
                                  fontSize: 20),
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: 250,
                        height: 60,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/Cadastro');
                            },
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: Text(
                              "Cadastrar",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[900],
                                  fontSize: 20),
                            )))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
