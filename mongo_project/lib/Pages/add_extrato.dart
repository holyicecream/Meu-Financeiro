// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:projeto_integrador/_backend/backend_adicionar_pagamento_pendente.dart';
// import 'package:projeto_integrador/_backend/backend_dados_da_conta_bancaria.dart';

class AddExtrato extends StatefulWidget {
  const AddExtrato({super.key});

  @override
  State<AddExtrato> createState() => AddExtratoState();
}

const List<String> list2 = <String>[
  'Outros',
  'Lazer',
  'Alimentação',
  'Moradia',
  'Educação',
  'Transporte',
  'Saúde'
];

const List<String> list = <String>[
  'Compra no débito',
  'Compra no crédito',
  'Pix',
  'Depósito por boleto',
  'Transferência',
  'Saque',
  'Recarga',
  'Outros'
];

class AddExtratoState extends State<AddExtrato> {
final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String radioBtnGroup = "";
  int indexDoBottom = 0;
  @override
  Widget build(BuildContext context) {
    inBuildAdicionarPagamentoPendente(context);
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
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          nomeOnChange(value);
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Nome da pessoa/instituição"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) {
                          valorOnChange(value);
                        },
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
                              debitoCreditoOnChanged(value);
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
                        onChanged: (value) {},
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Data do pagamento"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: DropdownMenuExample(list))
                          ]),
                      // SizedBox(
                      //     width: double.infinity, child: DropdownMenuExample(list2)),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 120,
                        child: TextField(
                          onChanged: (value) {
                            descricaoOnChange(value);
                          },
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
                      SizedBox(
                        width: 250,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            salvarOnTap(context, formKey);
                            // Navigator.pop(context, '/Main');
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample(List<String> list, {super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownMenu<String>(
        initialSelection: list.first,
        onSelected: (String? value) {
          //         'Compra no débito',
          // 'Compra no crédito',
          // 'Pix',
          // 'Depósito por boleto',
          // 'Transferência',
          // 'Saque',
          // 'Recarga'
          if (value == 'Compra no débito') {
            todosArguments.dataExtrato.codTransacao = 5;
          } else if (value == 'Pix') {
            todosArguments.dataExtrato.codTransacao = 3;
          } else if (value == 'Depósito por boleto') {
            todosArguments.dataExtrato.codTransacao = 1;
          } else if (value == 'Transferência') {
            todosArguments.dataExtrato.codTransacao = 7;
          } else if (value == 'Saque') {
            todosArguments.dataExtrato.codTransacao = 4;
          } else if (value == 'Recarga') {
            todosArguments.dataExtrato.codTransacao = 8;
          } else {
            todosArguments.dataExtrato.codTransacao = 9;
          }
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries:
            list.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      ),
    );
  }
}
