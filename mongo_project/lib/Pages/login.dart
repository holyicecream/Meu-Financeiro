// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '/_backend/backend_tela_principal.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  int indexDoBottom = 0;
  @override
  Widget build(BuildContext context) {
    inBuildTelaPrincipal(context);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 1.0,
          ),
        ),
        title: const Text(
          "Entrar",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "Email"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "Senha"),
                    ),
                    SizedBox(
                      height: 250,
                    ),
                    Container(
                        width: 250,
                        height: 60,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/Main');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF224912),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: Text(
                              "Entrar",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: Text(
                        "Ainda não possui uma conta? Cadastre-se",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF224912)),
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/Cadastro');
                      },
                    )
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
