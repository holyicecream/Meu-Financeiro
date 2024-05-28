import 'package:estudo_prova01/inserir.dart';
import 'package:flutter/material.dart';

class Listar extends StatefulWidget {
  const Listar({super.key});

  @override
  State<Listar> createState() => _NavegacaoState();
}

class _NavegacaoState extends State<Listar> {
  int indexDoBottom = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: const Text(
            "Banco Meu Financeiro - Listar",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              height: 600,
              width: 800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const Listar();
                            },
                          ));
                        },
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(300, 100)),
                            maximumSize: MaterialStateProperty.all(
                                const Size(300, 100))),
                        child: const Text(
                          "Listar Agências Bancárias.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const Listar();
                            },
                          ));
                        },
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(const Size(300, 100)),
                            maximumSize: MaterialStateProperty.all(
                                const Size(300, 100))),
                        child: const Text(
                          "Listar Bancos.",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const Listar();
                              },
                            ));
                          },
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(300, 100)),
                              maximumSize: MaterialStateProperty.all(
                                  const Size(300, 100))),
                          child: const Text(
                            "Listar Clientes.",
                            style: TextStyle(fontSize: 20),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const Listar();
                              },
                            ));
                          },
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(300, 100)),
                              maximumSize: MaterialStateProperty.all(
                                  const Size(300, 100))),
                          child: const Text(
                            "Listar Contas Bancárias dos clientes.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const Listar();
                              },
                            ));
                          },
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(300, 100)),
                              maximumSize: MaterialStateProperty.all(
                                  const Size(300, 100))),
                          child: const Text(
                            "Listar Transações.",
                            style: TextStyle(fontSize: 20),
                          )),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Listar"),
            BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart), label: "Inserir")
          ],
          currentIndex: 0,
          onTap: (index) {
            setState(() {
              indexDoBottom = index;
              if (indexDoBottom == 0) {
              } else if (indexDoBottom == 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Inserir(),
                  ),
                );
              }
            });
          },
        ));
  }
}