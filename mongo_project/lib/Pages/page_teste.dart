//selected color
//unselected color
//icons: login, person, wc, assignment, delete, login_outlined, foward
import 'package:flutter/material.dart';
// import '../_backend/backend_tela_principal.dart';

class PageTeste extends StatefulWidget {
  const PageTeste({super.key});

  @override
  State<PageTeste> createState() => PageTesteState();
}

class PageTesteState extends State<PageTeste> {
  @override
  Widget build(BuildContext context) {
    // inBuildTelaPrincipal(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('PAGINA DE APRESENTAÇÃO - RESUMO'),
        backgroundColor: Colors.blueGrey.shade200,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SizedBox(
            height: 600,
            child: Column(
              children: [
                Text("Saldo {saldo.toString()}"),
                Text(
                    "Pagamentos pendentes: {pagamentosPendentesValue.toString()}"),
                SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [],
                  ),
                ),
                // extrato
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}
