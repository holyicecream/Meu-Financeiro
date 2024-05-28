import 'package:estudo_prova01/listar.dart';
import 'package:flutter/material.dart';

class Inserir extends StatefulWidget {
  const Inserir({super.key});

  @override
  State<Inserir> createState() => _NavegacaoState();
}

class _NavegacaoState extends State<Inserir> {
  int indexDoBottom = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: const Text(
            "Banco Meu Financeiro - Inserir",
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
                          return const Inserir();
                        },
                      ));
                    },
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(300, 100)),
                        maximumSize:
                            MaterialStateProperty.all(const Size(300, 100))),
                    child: const Text(
                      "Inserir nova Agência Bancária.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const Inserir();
                          },
                        ));
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(300, 100)),
                          maximumSize:
                              MaterialStateProperty.all(const Size(300, 100))),
                      child: const Text(
                        "Inserir novo Cliente.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const Inserir();
                          },
                        ));
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(300, 100)),
                          maximumSize:
                              MaterialStateProperty.all(const Size(300, 100))),
                      child: const Text(
                        "Inserir nova Conta Bancária.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const Inserir();
                          },
                        ));
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(300, 100)),
                          maximumSize:
                              MaterialStateProperty.all(const Size(300, 100))),
                      child: const Text(
                        "Fazer PIX.",
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
          currentIndex: 1,
          onTap: (index) {
            setState(() {
              indexDoBottom = index;
              if (indexDoBottom == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Listar(),
                  ),
                );
              } else if (indexDoBottom == 1) {}
            });
          },
        ));
  }
}
