import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../zModels/model_area_consumo.dart';
import '../zModels/model_bancos.dart';
import '../zModels/model_bancos_usuario.dart';
import '../zModels/model_clientes.dart';
import '../zModels/model_extrato.dart';
import '../zModels/model_tipo_transacao.dart';
import '../zModels/todos_arguments.dart';

class PrimeiroAcesso extends StatefulWidget {
  const PrimeiroAcesso({super.key});

  @override
  State<PrimeiroAcesso> createState() => PrimeiroAcessoState();
}

class PrimeiroAcessoState extends State<PrimeiroAcesso> {
  TodosArguments todosArguments = TodosArguments(
    dataAreaConsumo: MongoDbModelAreaConsumo(),
    dataBancosUsuario: MongoDbModelBancosUsuario(),
    dataBancos: MongoDbModelBancos(),
    dataClientes: MongoDbModelClientes(),
    dataExtrato: MongoDbModelExtrato(),
    dataTransacao: MongoDbModelTipoTransacao(),
  );
  int count = 0;

  @override
  Widget build(BuildContext context) {
    count++;
    // ignore: avoid_print
    print("build primeiroAcesso $count");
    try {
      todosArguments =
          ModalRoute.of(context)!.settings.arguments as TodosArguments;
    } catch (e) {
      // print(e.toString());
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(34, 72, 20, 1),
        leading: GestureDetector(
          onTap: () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: const Color(0xFF224912),
                width: double.infinity,
                height: 400,
                child: const Image(image: AssetImage("assets/home-image.png")),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 250,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/Login',
                              arguments: todosArguments);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7ED957),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14))),
                        child: Text(
                          "Entrar",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[900],
                              fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 250,
                      height: 60,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/Cadastro',
                              arguments: todosArguments);
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
                        ),
                      ),
                    ),
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
