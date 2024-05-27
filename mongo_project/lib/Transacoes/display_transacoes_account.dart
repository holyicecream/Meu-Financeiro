import 'package:flutter/material.dart';
import '../zModels/mongodb_model_transacoes.dart';
import '../zDatabase/mongodb_transacoes.dart';

class DisplayTransacoesByAccount extends StatefulWidget {
  const DisplayTransacoesByAccount({super.key});

  @override
  DisplayTransacoesByAccountState createState() =>
      DisplayTransacoesByAccountState();
}

class DisplayTransacoesByAccountState
    extends State<DisplayTransacoesByAccount> {
  @override
  Widget build(BuildContext context) {
    int numAccount = ModalRoute.of(context)!.settings.arguments as int;
    List<Widget> buildListaTransacoes() {
      List<Widget> listaTransacoes = [Container()];
      void primeiroPasso() {
        int qnt06Hours = 0;
        int qnt612Hours = 0;
        int qnt1218Hours = 0;
        int qnt1824Hours = 0;
        int qnt01 = 0;
        int qnt110 = 0;
        int qnt10100 = 0;
        int qnt100500 = 0;
        int qnt999 = 0;

        listaTransacoes.insert(
            1,
            FutureBuilder(
                future: MongoDatabaseTransacoes.getDataByAccount(numAccount),
                builder: (context, AsyncSnapshot snapshot) {
                  // //print(numAccount);
                  // //print(snapshot);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return Column(children: [
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            if ((double.parse(snapshot.data.length.toString()) -
                                    1) ==
                                index) {
                              //print('Chegou no ultimo index do primeiro');
                            }
                            return displayCard(
                                MongoDbModelTransacoes.fromJson(
                                    snapshot.data[index]),
                                qnt06Hours,
                                qnt612Hours,
                                qnt1218Hours,
                                qnt1824Hours,
                                qnt01,
                                qnt110,
                                qnt10100,
                                qnt100500,
                                qnt999,
                                false);
                          }),
                    ]);
                  } else {
                    return const Center(
                      child: Text("No data available"),
                    );
                  }
                }));
      }

      void segundoPasso() {
        int qnt06Hours = 0;
        int qnt612Hours = 0;
        int qnt1218Hours = 0;
        int qnt1824Hours = 0;
        int qnt01 = 0;
        int qnt110 = 0;
        int qnt10100 = 0;
        int qnt100500 = 0;
        int qnt999 = 0;
        Widget agoraVai = Container();
        agoraVai = (FutureBuilder(
            future: MongoDatabaseTransacoes.getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return Column(children: [
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        if (MongoDbModelTransacoes.fromJson(snapshot.data[index]).numeroConta == numAccount &&(MongoDbModelTransacoes.fromJson(snapshot.data[index]).dia >= (DateTime.now().day - 7) && MongoDbModelTransacoes.fromJson(snapshot.data[index]).data.hour >= 0) &&
                            (MongoDbModelTransacoes.fromJson(snapshot.data[index]).dia >= (DateTime.now().day - 7) &&
                                MongoDbModelTransacoes.fromJson(snapshot.data[index]).data.hour <
                                    6)) {
                          qnt06Hours++;
                        } else if (MongoDbModelTransacoes.fromJson(snapshot.data[index]).numeroConta == numAccount &&(MongoDbModelTransacoes.fromJson(snapshot.data[index]).dia >= (DateTime.now().day - 7) && MongoDbModelTransacoes.fromJson(snapshot.data[index]).data.hour >= 6) &&
                            (MongoDbModelTransacoes.fromJson(snapshot.data[index]).dia >= (DateTime.now().day - 7) &&
                                MongoDbModelTransacoes.fromJson(snapshot.data[index]).data.hour <
                                    12)) {
                          qnt612Hours++;
                        } else if (MongoDbModelTransacoes.fromJson(snapshot.data[index]).numeroConta == numAccount &&(MongoDbModelTransacoes.fromJson(snapshot.data[index]).dia >= (DateTime.now().day - 7) && MongoDbModelTransacoes.fromJson(snapshot.data[index]).data.hour >= 12) &&
                            (MongoDbModelTransacoes.fromJson(snapshot.data[index]).dia >=
                                    (DateTime.now().day - 7) &&
                                MongoDbModelTransacoes.fromJson(snapshot.data[index]).data.hour <
                                    18)) {
                          qnt1218Hours++;
                        } else if (MongoDbModelTransacoes.fromJson(snapshot.data[index]).numeroConta == numAccount &&(MongoDbModelTransacoes.fromJson(snapshot.data[index]).dia >=
                                    (DateTime.now().day - 7) &&
                                MongoDbModelTransacoes.fromJson(snapshot.data[index]).data.hour >=
                                    18) &&
                            (MongoDbModelTransacoes.fromJson(snapshot.data[index]).dia >=
                                    (DateTime.now().day - 7) &&
                                MongoDbModelTransacoes.fromJson(snapshot.data[index]).data.hour < 24)) {
                          qnt1824Hours++;
                        } else {}
                        if (MongoDbModelTransacoes.fromJson(snapshot.data[index]).numeroConta == numAccount &&MongoDbModelTransacoes.fromJson(snapshot.data[index]).valor > 0 &&
                            MongoDbModelTransacoes.fromJson(snapshot.data[index])
                                    .valor <=
                                1) {
                          qnt01++;
                        } else if (MongoDbModelTransacoes.fromJson(snapshot.data[index]).numeroConta == numAccount &&MongoDbModelTransacoes.fromJson(snapshot.data[index]).valor > 1 &&
                            MongoDbModelTransacoes.fromJson(snapshot.data[index])
                                    .valor <=
                                10) {
                          qnt110++;
                        } else if (MongoDbModelTransacoes.fromJson(snapshot.data[index]).numeroConta == numAccount &&MongoDbModelTransacoes.fromJson(snapshot.data[index])
                                    .valor >
                                10 &&
                            MongoDbModelTransacoes.fromJson(snapshot.data[index])
                                    .valor <=
                                100) {
                          qnt10100++;
                        } else if (MongoDbModelTransacoes.fromJson(snapshot.data[index]).numeroConta == numAccount &&MongoDbModelTransacoes.fromJson(snapshot.data[index])
                                    .valor >
                                100 &&
                            MongoDbModelTransacoes.fromJson(snapshot.data[index])
                                    .valor <=
                                500) {
                          qnt100500++;
                        } else if (MongoDbModelTransacoes.fromJson(snapshot.data[index]).numeroConta == numAccount &&MongoDbModelTransacoes.fromJson(snapshot.data[index])
                                .valor >
                            500) {
                          qnt999++;
                        } else {}
                        if ((double.parse(snapshot.data.length.toString()) -
                                1) ==
                            index) {
                          //print('Chegou no ultimo index do segundo');
                          return displayCard(
                              MongoDbModelTransacoes.fromJson(
                                  snapshot.data[index]),
                              qnt06Hours,
                              qnt612Hours,
                              qnt1218Hours,
                              qnt1824Hours,
                              qnt01,
                              qnt110,
                              qnt10100,
                              qnt100500,
                              qnt999,
                              true);
                        } else {
                          return Container();
                        }
                      }),
                ]);
              } else {
                return const Center(
                  child: Text("No data available"),
                );
              }
            }));
        listaTransacoes[0] = agoraVai;
      }

      primeiroPasso();
      segundoPasso();

      return listaTransacoes;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Lista de transações",
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: buildListaTransacoes(),
          ),
        ),
      ),
    );
  }

  Widget displayCard(
      MongoDbModelTransacoes data,
      int qnt06Hours,
      int qnt612Hours,
      int qnt1218Hours,
      int qnt1824Hours,
      int qnt01,
      int qnt110,
      int qnt10100,
      int qnt100500,
      int qnt999,
      bool ultimo) {
    String saldoAtualValueText = '';
    if (ultimo == true) {
      //print("$qnt06Hours, $qnt612Hours, $qnt1218Hours, $qnt1824Hours");
      return Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quantidade de transações da ultima semana no periodo de:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "00h até 06h: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "06h até 12h: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "12h até 18h: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "18h até 00h: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            qnt06Hours.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            qnt612Hours.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            qnt1218Hours.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            qnt1824Hours.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quantidade de transações da ultima semana nos valores de:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "0,01\$ até 1,00\$: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "1,01\$ até 10,00\$: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "10,01\$ até 100,00\$: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "100,01\$ até 500,00\$: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "+500,00\$: ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            qnt01.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            qnt110.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            qnt10100.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            qnt100500.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            qnt999.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    saldoAtualValueText = (data.saldo - data.valor).toString();

    return Card(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Object Id: "),
              Text("Data: "),
              Text("Número da Conta: "),
              Text("Número da Agência: "),
              Text("Saldo: "),
              Text("Limite: "),
              Text("Chave PIX: "),
              Text("Número da Conta Destinatário: "),
              Text("Número da Agência Destinatário: "),
              Text("Chave PIX Destinatário: "),
              Text("Valor: "),
              Text(
                "Saldo depois da transação: ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${data.id}"),
              Text("${data.data}"),
              Text("${data.numeroConta}"),
              Text("${data.numeroAgencia}"),
              Text("${data.saldo}"),
              Text("${data.limite}"),
              Text(data.chavePix),
              Text("${data.destinatarioConta}"),
              Text("${data.destinatarioAgencia}"),
              Text(data.chavePixDestinatario),
              Text("${data.valor}"),
              Text(
                saldoAtualValueText,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
