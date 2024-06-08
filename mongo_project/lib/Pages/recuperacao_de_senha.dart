import 'dart:math';

import 'package:flutter/material.dart';

import '../zModels/model_area_consumo.dart';
import '../zModels/model_bancos.dart';
import '../zModels/model_bancos_usuario.dart';
import '../zModels/model_clientes.dart';
import '../zModels/model_extrato.dart';
import '../zModels/model_tipo_transacao.dart';
import '../zModels/todos_arguments.dart';

class RecuperacaoDeSenha extends StatefulWidget {
  const RecuperacaoDeSenha({super.key});

  @override
  State<RecuperacaoDeSenha> createState() => RecuperacaoDeSenhaState();
}

class RecuperacaoDeSenhaState extends State<RecuperacaoDeSenha> {
  TodosArguments todosArguments = TodosArguments(
    dataAreaConsumo: MongoDbModelAreaConsumo(),
    dataBancosUsuario: MongoDbModelBancosUsuario(),
    dataBancos: MongoDbModelBancos(),
    dataClientes: MongoDbModelClientes(),
    dataExtrato: MongoDbModelExtrato(),
    dataTransacao: MongoDbModelTipoTransacao(),
  );

  TextEditingController primeiroController = TextEditingController();
  TextEditingController segundoController = TextEditingController();
  TextEditingController terceiroController = TextEditingController();
  TextEditingController quartoController = TextEditingController();
  TextEditingController quintoController = TextEditingController();
  int num1 = 0;
  int num2 = 0;
  int num3 = 0;
  int num4 = 0;
  int num5 = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int count = 0;

  @override
  void initState() {
    super.initState();
    num1 = Random().nextInt(9);
    num2 = Random().nextInt(9);
    num3 = Random().nextInt(9);
    num4 = Random().nextInt(9);
    num5 = Random().nextInt(9);
    // ignore: avoid_print
    print(
        "código: ${num1.toString()}, ${num2.toString()}, ${num3.toString()}, ${num4.toString()}, ${num5.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    count++;
    // ignore: avoid_print
    print("build recuperacaoDeSenha $count");
    try {
      todosArguments =
          ModalRoute.of(context)!.settings.arguments as TodosArguments;
    } catch (e) {
      // print(e.toString());
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/Login',
                arguments: todosArguments);
          },
          child: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: const Text('Esqueci a senha'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Código",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
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
                            controller: primeiroController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: TextFormField(
                            controller: segundoController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: TextFormField(
                            controller: terceiroController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: TextFormField(
                            controller: quartoController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: TextFormField(
                            controller: quintoController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'Um código será enviado no seu e-mail cadastrado para a redefinição de senha. Caso o código não apareça, clique aqui: ',
                            style: TextStyle(
                                color: Colors.green.shade900, fontSize: 16),
                            softWrap: true,
                          ),
                        ),
                      ),
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
                  const Center(
                    child: Text(
                      "O ENVIO POR EMAIL NÃO ESTÁ FUNCIONANDO.\nAPENAS PREENCHA OS CAMPOS COM QUALQUER VALOR.",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(
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
                            return const Size(300, 50);
                          }),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (primeiroController.text != '' &&
                                segundoController.text != '' &&
                                terceiroController.text != '' &&
                                quartoController.text != '' &&
                                quintoController.text != '') {
                              Navigator.pushReplacementNamed(
                                  context, '/RedefinicaoDeSenha',
                                  arguments: todosArguments);
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    actions: [
                                      Center(
                                        child: MaterialButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Ok"),
                                        ),
                                      )
                                    ],
                                    content: Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      height: 50,
                                      child: const Text("Código incorreto."),
                                    ),
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: const Text(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          'Continuar',
                        ),
                      ),
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
