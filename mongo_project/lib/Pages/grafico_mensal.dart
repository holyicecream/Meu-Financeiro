import 'package:flutter/material.dart';
import 'package:projeto_integrador/zDatabase/mongodb_extrato.dart';
import '../zModels/model_area_consumo.dart';
import '../zModels/model_bancos_usuario.dart';
import '../zModels/model_bancos.dart';
import '../zModels/model_clientes.dart';
import '../zModels/model_extrato.dart';
import '../zModels/model_tipo_transacao.dart';
import '../zModels/todos_arguments.dart';

class GraficoMensal extends StatefulWidget {
  const GraficoMensal({super.key});

  @override
  State<GraficoMensal> createState() => GraficoMensalState();
}

class GraficoMensalState extends State<GraficoMensal> {
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
    print("build graficoMensal $count");
    try {
      todosArguments =
          ModalRoute.of(context)!.settings.arguments as TodosArguments;
    } catch (e) {
      // print(e.toString());
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/Main',
                arguments: todosArguments);
          },
          child: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          "Gráficos",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: MongoDatabaseExtrato.getDataByCodCli(
                  // todosArguments.dataClientes.codCliente ??= 4,
                  todosArguments.dataClientes.codCliente ??= 0),
              builder: (context, AsyncSnapshot snapshot) {
                double media = 0;
                double totalDebito = 0;
                double totalCredito = 0;
                double totalDebitoPagamentoPendente = 0;
                double totalCreditoPagamentoPendente = 0;
                double maximo = 0;
                double minimo = 0;
                double saldo = 0;
                double saldoPagamentoPendente = 0;
                List<int> fullDaysDebito = [];
                List<int> finalDaysDebito = [];
                List<double> fullValuesDebito = [];
                List<double> finalValuesDebito = [];
                List<Map<String, dynamic>> dataDebito = [];
                List<Map<String, dynamic>> dataDebitoPagamentosPendentes = [];
                List<int> fullDaysCredito = [];
                List<int> finalDaysCredito = [];
                List<double> fullValuesCredito = [];
                List<double> finalValuesCredito = [];
                List<Map<String, dynamic>> dataCredito = [];
                List<Map<String, dynamic>> dataCreditoPagamentosPendentes = [];

                // List<Map<String, dynamic>> sortedFlSpot = [];
                if (snapshot.hasData) {
                  int xDataDebito = 0;
                  dynamic yDataDebito;
                  int xDataCredito = 0;
                  dynamic yDataCredito;

                  for (var dado in snapshot.data) {
                    if (dado['debito_credito'] == 'debito' &&
                        int.parse(
                                "${dado['data'].toString().split(' ')[0].toString().split('-')[0].toString()}${dado['data'].toString().split(' ')[0].toString().split('-')[1].toString()}${dado['data'].toString().split(' ')[0].toString().split('-')[2].toString()}") <=
                            int.parse(
                                "${DateTime.now().toString().split(' ')[0].toString().split('-')[0]}${DateTime.now().toString().split(' ')[0].toString().split('-')[1]}${DateTime.now().toString().split(' ')[0].toString().split('-')[2]}")) {
                      dataDebito.add(dado);
                    } else if (dado['debito_credito'] == 'credito' &&
                        int.parse(
                                "${dado['data'].toString().split(' ')[0].toString().split('-')[0].toString()}${dado['data'].toString().split(' ')[0].toString().split('-')[1].toString()}${dado['data'].toString().split(' ')[0].toString().split('-')[2].toString()}") <=
                            int.parse(
                                "${DateTime.now().toString().split(' ')[0].toString().split('-')[0]}${DateTime.now().toString().split(' ')[0].toString().split('-')[1]}${DateTime.now().toString().split(' ')[0].toString().split('-')[2]}")) {
                      dataCredito.add(dado);
                    }
                    if (dado['debito_credito'] == 'debito' &&
                        int.parse(
                                "${dado['data'].toString().split(' ')[0].toString().split('-')[0].toString()}${dado['data'].toString().split(' ')[0].toString().split('-')[1].toString()}${dado['data'].toString().split(' ')[0].toString().split('-')[2].toString()}") >
                            int.parse(
                                "${DateTime.now().toString().split(' ')[0].toString().split('-')[0]}${DateTime.now().toString().split(' ')[0].toString().split('-')[1]}${DateTime.now().toString().split(' ')[0].toString().split('-')[2]}")) {
                      dataDebitoPagamentosPendentes.add(dado);
                    } else if (dado['debito_credito'] == 'credito' &&
                        int.parse(
                                "${dado['data'].toString().split(' ')[0].toString().split('-')[0].toString()}${dado['data'].toString().split(' ')[0].toString().split('-')[1].toString()}${dado['data'].toString().split(' ')[0].toString().split('-')[2].toString()}") >
                            int.parse(
                                "${DateTime.now().toString().split(' ')[0].toString().split('-')[0]}${DateTime.now().toString().split(' ')[0].toString().split('-')[1]}${DateTime.now().toString().split(' ')[0].toString().split('-')[2]}")) {
                      dataCreditoPagamentosPendentes.add(dado);
                    }
                  }
                  for (var n in dataDebito) {
                    xDataDebito = int.parse(n['data']
                        .toString()
                        .split(' ')[0]
                        .toString()
                        .split('-')[2]
                        .toString());
                    yDataDebito = n['valor'];
                    fullDaysDebito.add((xDataDebito));
                    fullValuesDebito.add(double.parse(yDataDebito.toString()));
                  }
                  List<int> depoisSortDebito = fullDaysDebito;
                  depoisSortDebito.sort();
                  for (var i = 0; i < fullDaysDebito.length; i++) {
                    if (finalDaysDebito.contains(fullDaysDebito[i])) {
                      finalValuesDebito[finalValuesDebito.length - 1] +=
                          fullValuesDebito[i];
                    } else {
                      finalDaysDebito.add(fullDaysDebito[i]);
                      finalValuesDebito.add(fullValuesDebito[i]);
                    }
                  }

                  for (var n in dataCredito) {
                    xDataCredito = int.parse(n['data']
                        .toString()
                        .split(' ')[0]
                        .toString()
                        .split('-')[2]
                        .toString());
                    yDataCredito = n['valor'];
                    fullDaysCredito.add((xDataCredito));
                    fullValuesCredito
                        .add(double.parse(yDataCredito.toString()));
                  }
                  for (var n in dataCreditoPagamentosPendentes) {
                    totalCreditoPagamentoPendente += n['valor'];
                  }
                  for (var n in dataDebitoPagamentosPendentes) {
                    totalDebitoPagamentoPendente += n['valor'];
                  }
                  saldoPagamentoPendente = totalCreditoPagamentoPendente -
                      totalDebitoPagamentoPendente;
                  List<int> depoisSortCredito = fullDaysCredito;
                  depoisSortCredito.sort();
                  for (var i = 0; i < fullDaysCredito.length; i++) {
                    if (finalDaysCredito.contains(fullDaysCredito[i])) {
                      finalValuesCredito[finalValuesCredito.length - 1] +=
                          fullValuesCredito[i];
                    } else {
                      finalDaysCredito.add(fullDaysCredito[i]);
                      finalValuesCredito.add(fullValuesCredito[i]);
                    }
                  }
                  for (var value in finalValuesDebito) {
                    if (value > maximo) {
                      maximo = value;
                    }
                    if (minimo == 0) {
                      minimo = value;
                    } else if (value < maximo) {
                      minimo = value;
                    }
                    media += value;
                  }
                  for (var value in finalValuesCredito) {
                    totalCredito += value;
                  }
                  totalDebito = media;
                  saldo = totalCredito - totalDebito;
                  media = media / finalValuesDebito.length;
                  media = double.parse(media.toStringAsFixed(2));

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Dados atuais",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text("(não inclui pagamentos pendentes)"),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.green),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, "/GraficoDiario",
                                    arguments: todosArguments);
                              },
                              child: Text(
                                "Mostrar gráfico",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 8,
                            ),
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.green, width: 2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Mostrar tabela",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                border: TableBorder.all(width: 2),
                                children: [
                                  TableRow(
                                    decoration:
                                        BoxDecoration(color: Colors.green),
                                    children: [
                                      TableCell(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                              "Resumo dos ganhos e gastos atuais.",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                border: TableBorder.all(width: 2),
                                children: [
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            "Entradas.",
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green),
                                            "R\$$totalCredito.",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            "Saidas.",
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                            "R\$$totalDebito.",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            "Saldo.",
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            "R\$$saldo.",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            "Pendentes.",
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            "R\$$saldoPagamentoPendente.",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 80,
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Gastos gerais: R\$$totalDebito",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        "Valor máximo: R\$$maximo",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        "Valor mínimo: R\$$minimo",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        "Média de gastos por dia: R\$$media",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        "Saldo atual: R\$$saldo",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
