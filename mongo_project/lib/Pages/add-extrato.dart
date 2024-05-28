// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '/_backend/backend_tela_principal.dart';

class AddExtrato extends StatefulWidget {
  const AddExtrato({super.key});

  @override
  State<AddExtrato> createState() => AddExtratoState();
}

class AddExtratoState extends State<AddExtrato> {
  String radioBtnGroup = "";
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
          "Adicionar extrato",
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
                          border: OutlineInputBorder(),
                          labelText: "Nome da pessoa/instituição"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Valor pago/recebido"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Radio(
                          value: "Pago",
                          groupValue: radioBtnGroup,
                          onChanged: (value) {
                            setState(() {
                              radioBtnGroup = value!;
                            });
                          },
                        ),
                        Text("Valor pago"),
                        SizedBox(
                          width: 10,
                        ),
                        Radio(
                          value: "Recebido",
                          groupValue: radioBtnGroup,
                          onChanged: (value) {
                            setState(() {
                              radioBtnGroup = value!;
                            });
                          },
                        ),
                        Text("Valor recebido"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Data do pagamento"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Tipos de transação"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 120,
                      child: TextField(
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Descrição"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: 250,
                        height: 60,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, '/Main');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF7ED957),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: Text(
                              "Adicionar",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ))),
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
