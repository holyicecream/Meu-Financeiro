// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//selected color
//unselected color
//icons: login, person, wc, assignment, delete, login_outlined, foward
import 'package:flutter/material.dart';
import 'package:projeto_integrador/_backend/backend_dados_da_conta_bancaria.dart';
import 'package:fixnum/fixnum.dart';
import '../zDatabase/mongodb_bancos_usuario.dart';
import '../zModels/model_area_consumo.dart';
import '../zModels/model_bancos_usuario.dart';
import '../zModels/model_bancos.dart';
import '../zModels/model_clientes.dart';
import '../zModels/model_extrato.dart';
import '../zModels/model_tipo_transacao.dart';
import '../zModels/todos_arguments.dart';

class DadosDaContaBancaria extends StatefulWidget {
  const DadosDaContaBancaria({super.key});

  @override
  State<DadosDaContaBancaria> createState() => DadosDaContaBancariaState();
}

class DadosDaContaBancariaState extends State<DadosDaContaBancaria> {
  TodosArguments todosArguments = TodosArguments(
    dataAreaConsumo: MongoDbModelAreaConsumo(),
    dataBancosUsuario: MongoDbModelBancosUsuario(),
    dataBancos: MongoDbModelBancos(),
    dataClientes: MongoDbModelClientes(),
    dataExtrato: MongoDbModelExtrato(),
    dataTransacao: MongoDbModelTipoTransacao(),
  );
  TextEditingController contaCorrenteController = TextEditingController();
  TextEditingController agenciaController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  List<Map<String, dynamic>> dataBancosUsuario = [
    {'': ''}
  ];
  int count = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    inBuildDadosDaContaBancaria(context);
    count++;
    print("build dadosDaContaBancaria $count");

    try {
      todosArguments =
          ModalRoute.of(context)!.settings.arguments as TodosArguments;
    } catch (e) {
      // print(e.toString());
    }

    MongoDatabaseBancosUsuario.getData().then(
      (value) {
        if (value.isNotEmpty) {
          dataBancosUsuario = value;
          todosArguments.dataBancosUsuario.codBancoUsuario =
              (value[value.length - 1]['cod_bancoUsuario'] + 1);
        }
      },
    );
    todosArguments.dataBancosUsuario.codCliente =
        todosArguments.dataClientes.codCliente;
    todosArguments.dataBancosUsuario.codBanco =
        todosArguments.dataBancos.codBanco;
    todosArguments.dataBancosUsuario.cpf = Int64.parseInt('0');
    print("dados bancoUsuario ${todosArguments.dataBancosUsuario.toJson()}");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Adicionar conta bancária'),
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
                          controller: contaCorrenteController,
                          validator: (value) {
                            value ??= '';
                            if (value == '') {
                              return 'Este campo não pode ser vazio.';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Conta Corrente',
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: agenciaController,
                          validator: (value) {
                            value ??= '';
                            if (value == '') {
                              return 'Este campo não pode ser vazio.';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Agência',
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: cpfController,
                          validator: (value) {
                            value ??= '';
                            if (value == '') {
                              return 'Este campo não pode ser vazio.';
                            } else if (value.length < 11) {
                              return 'CPF inválido.';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'CPF',
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: senhaController,
                          validator: (value) {
                            value ??= '';
                            if (value == '') {
                              return 'Este campo não pode ser vazio.';
                            } else if (todosArguments.dataClientes.senha ==
                                '') {
                              return 'ih a senha quebrou';
                            } else if (todosArguments.dataClientes.senha !=
                                value) {
                              return 'Senha incorreta.';
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Senha do aplicativo',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          todosArguments.dataBancosUsuario.agencia =
                              agenciaController.text;
                          todosArguments.dataBancosUsuario.contaCorrente =
                              contaCorrenteController.text;
                          todosArguments.dataBancosUsuario.cpf =
                              Int64.tryParseInt(cpfController.text);

                          todosArguments.dataBancosUsuario.codBanco = 1;
                          print('aq chega');
                          print(todosArguments.dataBancosUsuario.toJson());
                          if (todosArguments.dataBancosUsuario.codBancoUsuario !=
                                  null &&
                              todosArguments.dataBancosUsuario.codCliente !=
                                  0 &&
                              todosArguments.dataBancosUsuario.codBanco != 0 &&
                              todosArguments.dataBancosUsuario.agencia != '' &&
                              todosArguments.dataBancosUsuario.contaCorrente !=
                                  '' &&
                              todosArguments.dataBancosUsuario.cpf != 0) {
                            print('aq chega tb');
                            MongoDatabaseBancosUsuario.insert(
                                todosArguments.dataBancosUsuario);
                            Navigator.pushReplacementNamed(context, '/Main',
                                arguments: todosArguments);
                          } else {}
                        }
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
                        "Adicionar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text("Já tem uma conta?  "),
                  //     GestureDetector(
                  //       child: Text("Entrar."),
                  //       onTap: () {
                  //         entrarOnTap(context);
                  //       },
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
