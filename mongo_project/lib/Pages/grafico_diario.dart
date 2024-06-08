import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/zDatabase/mongodb_extrato.dart';
import '../zModels/model_area_consumo.dart';
import '../zModels/model_bancos_usuario.dart';
import '../zModels/model_bancos.dart';
import '../zModels/model_clientes.dart';
import '../zModels/model_extrato.dart';
import '../zModels/model_tipo_transacao.dart';
import '../zModels/todos_arguments.dart';

class GraficoDiario extends StatefulWidget {
  const GraficoDiario({super.key});

  @override
  State<GraficoDiario> createState() => GraficoDiarioState();
}

class GraficoDiarioState extends State<GraficoDiario> {
  TodosArguments todosArguments = TodosArguments(
    dataAreaConsumo: MongoDbModelAreaConsumo(),
    dataBancosUsuario: MongoDbModelBancosUsuario(),
    dataBancos: MongoDbModelBancos(),
    dataClientes: MongoDbModelClientes(),
    dataExtrato: MongoDbModelExtrato(),
    dataTransacao: MongoDbModelTipoTransacao(),
  );
  int count = 0;
  bool lineData01 = true;
  bool lineData02 = false;
  bool lineData03 = true;
  List<LineChartBarData> lineDataArray = [
    LineChartBarData(),
    LineChartBarData(),
    LineChartBarData()
  ];

  @override
  Widget build(BuildContext context) {
    count++;
    print("build graficoDiario $count");
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
                double intervalValue = 0;
                double media = 0;
                double mediaGrid = 0;
                double totalDebito = 0;
                double totalCredito = 0;
                double maximo = 0;
                double minimo = 0;
                double saldo = 0;
                List<FlSpot> dataSpotDebito = [];
                List<int> fullDaysDebito = [];
                List<int> finalDaysDebito = [];
                List<double> fullValuesDebito = [];
                List<double> finalValuesDebito = [];
                List<Map<String, dynamic>> dataDebito = [];
                List<FlSpot> dataSpotCredito = [];
                List<int> fullDaysCredito = [];
                List<int> finalDaysCredito = [];
                List<double> fullValuesCredito = [];
                List<double> finalValuesCredito = [];
                List<Map<String, dynamic>> dataCredito = [];

                // List<Map<String, dynamic>> sortedFlSpot = [];
                if (snapshot.hasData) {
                  int xDataDebito = 0;
                  dynamic yDataDebito;
                  int xDataCredito = 0;
                  dynamic yDataCredito;

                  for (var dado in snapshot.data) {
                    if (dado['debito_credito'] == 'debito') {
                      dataDebito.add(dado);
                    } else {
                      dataCredito.add(dado);
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
                  for (var i = 0; i < finalDaysDebito.length; i++) {
                    dataSpotDebito.add(FlSpot(
                      double.parse((finalDaysDebito[i]).toString()),
                      finalValuesDebito[i],
                    ));
                  }
                  for (var i = 0; i < finalDaysCredito.length; i++) {
                    dataSpotCredito.add(FlSpot(
                      double.parse((finalDaysCredito[i]).toString()),
                      finalValuesCredito[i],
                    ));
                  }
                  mediaGrid = media / 2;
                  if (mediaGrid == 0) {
                    mediaGrid = 1;
                  }
                  if (maximo <= 1000) {
                    intervalValue = 100;
                  } else if (maximo <= 2000) {
                    intervalValue = 200;
                  } else if (maximo <= 3000) {
                    intervalValue = 300;
                  } else if (maximo <= 5000) {
                    intervalValue = 500;
                  } else if (maximo <= 10000) {
                    intervalValue = 1000;
                  } else if (maximo > 10000) {
                    intervalValue = 2000;
                  }
                  lineDataArray[0] = LineChartBarData(
                    show: lineData01,
                    dotData: FlDotData(show: false),
                    spots: dataSpotDebito,
                    color: Colors.red,
                  );
                  lineDataArray[1] = LineChartBarData(
                    show: lineData02,
                    dotData: FlDotData(show: false),
                    spots: dataSpotCredito,
                    color: Colors.green,
                  );
                  lineDataArray[2] = LineChartBarData(
                    show: lineData03,
                    dotData: FlDotData(show: false),
                    spots: [
                      FlSpot(1, media),
                      FlSpot(30, media),
                    ],
                    color: Colors.blue,
                  );
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Planejamento do mês",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text("(inclui pagamentos pendentes)"),
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
                                "Mostrar gráfico",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 8,
                            ),
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
                                    context, "/GraficoMensal",
                                    arguments: todosArguments);
                              },
                              child: Text(
                                "Mostrar tabela",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  lineData01 = lineData01 ? false : true;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                      width: 8, height: 5, color: Colors.red),
                                  Text(" Gastos"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  lineData02 = lineData02 ? false : true;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                      width: 8, height: 5, color: Colors.green),
                                  Text(" Ganhos"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  lineData03 = lineData03 ? false : true;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                      width: 8, height: 5, color: Colors.blue),
                                  Text(" Média de gasto por dia"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: (MediaQuery.of(context).size.height / 3),
                          width: (MediaQuery.of(context).size.width / 1.2),
                          child: LineChart(
                            LineChartData(
                              borderData: FlBorderData(show: false),
                              gridData: FlGridData(
                                drawVerticalLine: false,
                                horizontalInterval: mediaGrid,
                              ),
                              minX: 1,
                              maxX: 30,
                              minY: 0,
                              // maxY: 400,
                              lineBarsData: lineDataArray,
                              // [
                              //   LineChartBarData(
                              //       dotData: FlDotData(show: false),
                              //       spots: dataSpotDebito,
                              //       color: Colors.red),
                              //   LineChartBarData(
                              //     spots: [
                              //       FlSpot(1, media),
                              //       FlSpot(30, media),
                              //     ],
                              //     color: Colors.blue,
                              //   ),
                              // ],
                              titlesData: FlTitlesData(
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: intervalValue,
                                      reservedSize: 40),
                                ),
                                bottomTitles: AxisTitles(
                                  axisNameWidget: Text("Dias do Mês"),
                                  sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 3,
                                      reservedSize: 40),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                "Saldo final: R\$$saldo",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
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
