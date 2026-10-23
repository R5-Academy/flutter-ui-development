// exemplo_02_elevation_inicio.dart
// Ponto de partida: quatro cartões empilhados numa tela.
//
// ! Os quatro têm exatamente o mesmo peso visual — a mesma sombra, a mesma
// ! altura aparente. Olhando de longe, nada diz qual deles importa mais.
//
// Numa tela real, "esse aqui está em destaque" e "esse é só um item da lista"
// precisam ser distinguíveis sem ler uma palavra. O Card tem um parâmetro para
// isso.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: Elevacoes()));

class Elevacoes extends StatelessWidget {
  const Elevacoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text('Elevation')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: const [_Cartao(), _Cartao(), _Cartao(), _Cartao()],
      ),
    );
  }
}

class _Cartao extends StatelessWidget {
  const _Cartao();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: SizedBox(
        height: 72,
        child: Center(
          child: Text(
            'cartão',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
