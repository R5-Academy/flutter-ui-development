// exemplo_01_empurra_pra_ponta_inicio.dart
// Ponto de partida: o cabeçalho de um card — título e ícone de ação.
//
// ! Os dois ficaram grudados na esquerda, porque `start` é o padrão do
// ! mainAxisAlignment. Num cabeçalho de verdade, a ação fica na ponta direita.
//
// Já sabemos fazer isso com spaceBetween. Agora vamos ver a outra ferramenta —
// a que dá controle de ONDE o vão entra.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: EmpurraPraPonta()));

class EmpurraPraPonta extends StatelessWidget {
  const EmpurraPraPonta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spacer: empurra pra ponta')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.indigo.withValues(alpha: 0.1),
              child: const Row(
                children: [
                  Text('Configurações', style: TextStyle(fontSize: 18)),
                  Icon(Icons.settings),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
