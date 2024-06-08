//selected color
//unselected color
//icons: login, person, wc, assignment, delete, login_outlined, foward
import 'package:flutter/material.dart';
// import 'package:projeto_integrador/_backend/backend_redefinicao_de_senha.dart';
import '../zDatabase/mongodb_clientes.dart';
import '../zModels/model_area_consumo.dart';
import '../zModels/model_bancos_usuario.dart';
import '../zModels/model_bancos.dart';
import '../zModels/model_clientes.dart';
import '../zModels/model_extrato.dart';
import '../zModels/model_tipo_transacao.dart';
import '../zModels/todos_arguments.dart';

class PersonalizarNome extends StatefulWidget {
  const PersonalizarNome({super.key});

  @override
  State<PersonalizarNome> createState() => PersonalizarNomeState();
}

class PersonalizarNomeState extends State<PersonalizarNome> {
  TodosArguments todosArguments = TodosArguments(
    dataAreaConsumo: MongoDbModelAreaConsumo(),
    dataBancosUsuario: MongoDbModelBancosUsuario(),
    dataBancos: MongoDbModelBancos(),
    dataClientes: MongoDbModelClientes(),
    dataExtrato: MongoDbModelExtrato(),
    dataTransacao: MongoDbModelTipoTransacao(),
  );
  TextEditingController nomeController = TextEditingController();
  TextEditingController senhaAtualController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int count = 0;
  @override
  Widget build(BuildContext context) {
    count++;
    print("build personalizarNome $count");
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
            Navigator.pushReplacementNamed(context, '/Main',
                arguments: todosArguments);
          },
          child: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text('Seu nome'),
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
                        Text(
                          "Como você quer ser chamado?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: senhaAtualController,
                          validator: (value) {
                            value ??= '';
                            if (value == '') {
                              return 'Este campo não pode ser vazio.';
                            } else if (senhaAtualController.text !=
                                todosArguments.dataClientes.senha) {
                              return 'Senhas incorreta.';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Senha atual',
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: nomeController,
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
                            labelText: 'Nome de preferência',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          todosArguments.dataClientes.nomeCliente =
                              nomeController.text;

                          MongoDatabaseClientes.updateNome(
                              todosArguments.dataClientes);
                          Navigator.pushReplacementNamed(context, '/Main',
                              arguments: todosArguments);
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.green),
                        minimumSize:
                            MaterialStateProperty.resolveWith((states) {
                          return Size(250, 50);
                        }),
                      ),
                      child: Text(
                        "Salvar Alterações",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
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
