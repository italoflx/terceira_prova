// tela_sobre.dart
import 'package:flutter/material.dart';

class TelaSobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Desenvolvedores:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8), // Adicione um espaço entre os itens
            Text(
              'Rômulo Felipe',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Analista e Desenvolvedor de Sistemas',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16), // Adicione um espaço maior entre os desenvolvedores
            Text(
              'Emanuel Ítalo',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Nutricionista',
              style: TextStyle(fontSize: 14),
            ),
            // Adicione mais informações conforme necessário
          ],
        ),
      ),
    );
  }
}
