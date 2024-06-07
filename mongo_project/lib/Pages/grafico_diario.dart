// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
  List<Map<String, dynamic>> dataExtrato = [];

  int count = 0;

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Gastos no mês atual",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                          side: BorderSide(color: Colors.green, width: 2),
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
                    onPressed: () {},
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
                  Container(width: 8, height: 5, color: Colors.green),
                  Text(" Gastos"),
                  SizedBox(
                    width: 15,
                  ),
                  Container(width: 8, height: 5, color: Colors.blue),
                  Text(" Média por dia"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              FutureBuilder(
                future: MongoDatabaseExtrato.getDataByCodCli(
                  // todosArguments.dataClientes.codCliente ??= 4,
                  todosArguments.dataClientes.codCliente??=0
                ),
                builder: (context, AsyncSnapshot snapshot) {
                  double media = 0;
                  double mediaGrid = 0;
                  double total = 0;
                  double maximo = 0;
                  double minimo = 0;
                  List<FlSpot> dataSpot = [];
                  List<int> fullDays = [];
                  List<int> finalDays = [];
                  List<double> fullValues = [];
                  List<double> finalValues = [];
                  // List<Map<String, dynamic>> sortedFlSpot = [];
                  if (snapshot.hasData) {
                    int xData = 0;
                    dynamic yData;

                    dataExtrato = snapshot.data;
                    for (var n in snapshot.data) {
                      xData = int.parse(n['data']
                          .toString()
                          .split(' ')[0]
                          .toString()
                          .split('-')[2]
                          .toString());
                      yData = n['valor'];
                      fullDays.add((xData));
                      fullValues.add(double.parse(yData.toString()));
                      // sortedFlSpot.add({xData.toString(): yData});
                    }
                    List<int> depoisSort = fullDays;
                    print("antes sort $depoisSort");
                    depoisSort.sort();
                    print("depois sort $depoisSort");

                    print("fullDays $fullDays");
                    print("fullValues $fullValues");

                    // print(sortedFlSpot);

                    for (var i = 0; i < fullDays.length; i++) {
                      if (finalDays.contains(fullDays[i])) {
                        finalValues[finalValues.length - 1] += fullValues[i];
                      } else {
                        finalDays.add(fullDays[i]);
                        finalValues.add(fullValues[i]);
                      }
                    }
                    print("finalDays $finalDays");
                    print("finalValues $finalValues");

                    for (var value in finalValues) {
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
                    total = media;
                    media = media / finalValues.length;
                    media = double.parse(media.toStringAsFixed(2));
                    print("média dos valores: $media");
                    for (var i = 0; i < finalDays.length; i++) {
                      dataSpot.add(FlSpot(
                        double.parse((finalDays[i]).toString()),
                        fullValues[i],
                      ));
                    }
                    mediaGrid = media/2;
                    if (mediaGrid == 0) {
                      mediaGrid = 1;
                    }
                    return Column(
                      children: [
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
                              lineBarsData: [
                                LineChartBarData(
                                    dotData: FlDotData(show: false),
                                    spots: dataSpot,
                                    color: Colors.green),
                                LineChartBarData(
                                  spots: [
                                    FlSpot(1, media),
                                    FlSpot(30, media),
                                  ],
                                  color: Colors.blue,
                                ),
                              ],
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
                                      interval: 100,
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
                                "Gastos gerais: $total",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Valor máximo: $maximo",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Valor mínimo: $minimo",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Média de gastos por dia: $media",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Saldo: \$",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text("Sem dados");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
