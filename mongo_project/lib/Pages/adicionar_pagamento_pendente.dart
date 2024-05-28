// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//selected color
//unselected color
//icons: login, person, wc, assignment, delete, login_outlined, foward
import 'package:flutter/material.dart';
import 'package:projeto_integrador/_backend/backend_adicionar_pagamento_pendente.dart';

class AdicionarPagamentoPendente extends StatefulWidget {
  const AdicionarPagamentoPendente({super.key});

  @override
  State<AdicionarPagamentoPendente> createState() =>
      AdicionarPagamentoPendenteState();
}

class AdicionarPagamentoPendenteState
    extends State<AdicionarPagamentoPendente> {
  @override
  Widget build(BuildContext context) {
    inBuildAdicionarPagamentoPendente(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cadastro'),
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
                        Center(
                          child: Text(
                            "INCOMPLETO",
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            return nomeValidator(value);
                          },
                          onChanged: (value) {
                            nomeOnChange(value);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nome',
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  return valorValidator(value);
                                },
                                onChanged: (value) {
                                  valorOnChange(value);
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Valor',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  return dataValidator(value);
                                },
                                onChanged: (value) {
                                  // dataOnChange(value);
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Data',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) {
                            return descricaoValidator(value);
                          },
                          obscureText: true,
                          onChanged: (value) {
                            descricaoOnChange(value);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Descrição',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Radio(
                                  activeColor: Colors.green.shade900,
                                  value: 'debito',
                                  groupValue: groupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Radio(
                                  activeColor: Colors.green.shade900,
                                  value: 'credito',
                                  groupValue: groupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 35,
                  // ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        salvarOnTap(context);
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
                        "Salvar",
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
                      GestureDetector(
                        child: Text(
                          "Definir alarme (opcional)",
                        ),
                        onTap: () {},
                      ),
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
