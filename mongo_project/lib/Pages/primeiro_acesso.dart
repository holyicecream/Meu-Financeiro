// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//selected color
//unselected color
//icons: login, person, wc, assignment, delete, login_outlined, foward
import 'package:flutter/material.dart';
import 'package:projeto_integrador/_backend/backend_primeiro_acesso.dart';

class PrimeiroAcesso extends StatefulWidget {
  const PrimeiroAcesso({super.key});

  @override
  State<PrimeiroAcesso> createState() => PrimeiroAcessoState();
}

class PrimeiroAcessoState extends State<PrimeiroAcesso> {
  @override
  Widget build(BuildContext context) {
    inBuildPrimeiroAcesso(context);
    return Scaffold(
      backgroundColor: Colors.green.shade800,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 10,
                height: 350,
              ),
              Container(
                width: double.infinity,
                height: 225,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.green),
                          minimumSize:
                              MaterialStateProperty.resolveWith((states) {
                            return Size(200, 50);
                          }),
                        ),
                        onPressed: () {
                          entrarOnTap(context);
                        },
                        child: Text(
                          "Entrar",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          surfaceTintColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          minimumSize:
                              MaterialStateProperty.resolveWith((states) {
                            return Size(200, 50);
                          }),
                        ),
                        onPressed: () {
                          cadastrarOnTap(context);
                        },
                        child: Text(
                          "Cadastrar",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
