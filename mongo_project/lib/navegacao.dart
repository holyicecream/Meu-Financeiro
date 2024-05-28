import '/inserir.dart';
import '/listar.dart';
import 'package:flutter/material.dart';

class Navegacao extends StatefulWidget {
  const Navegacao({super.key});

  @override
  State<Navegacao> createState() => _NavegacaoState();
}

class _NavegacaoState extends State<Navegacao> {
  int indexDoBottom = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Banco Meu Financeiro - Menu de navegação",
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
                          Image(
                              image:
                                  NetworkImage("https://imgur.com/a/5bBAthR"))
                        ])))),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Listar"),
            BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart), label: "Inserir")
          ],
          currentIndex: indexDoBottom,
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
