// exemplo_03_text_scaler_inicio.dart
// Ponto de partida: um badge de notificação num círculo de 28px.
//
// * `MediaQuery.textScalerOf(context)` é a estratégia de escala de fonte do
// * sistema — o substituto moderno do `textScaleFactor` (deprecated). Em vez de
// * um número, é uma ESTRATÉGIA, porque a escala em Android/iOS modernos é
// * NÃO-LINEAR: fontes pequenas crescem mais, grandes crescem menos.
// * `scaler.scale(16)` aplica essa curva — não é `16 * fator`.
//
// ! Aumente a escala de fonte nas Configurações do sistema (Acessibilidade >
// ! Tamanho da fonte) e volte ao app: o número do badge cresce e ESTOURA o
// ! círculo. Vá até a escala MÁXIMA — o '9' herda 14 px de fonte e só passa dos
// ! 28 px do círculo a partir de ~1,4x (em 1,6x ele pede 32 px de altura; em
// ! 2,0x, 40 px). Numa escala intermediária, nada visível acontece.
//
// O widget Text aplica o textScaler sozinho — e é justamente isso que atrapalha
// neste caso.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaEscalaDeFonte()));

class TelaEscalaDeFonte extends StatelessWidget {
  const TelaEscalaDeFonte({super.key});

  @override
  Widget build(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    final tamanho16Escalado = scaler.scale(16);

    return Scaffold(
      appBar: AppBar(title: const Text('Escala de fonte')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Este texto segue a escala do sistema automaticamente.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              title: const Text('16px base, após scale():'),
              trailing: Text('${tamanho16Escalado.toStringAsFixed(1)} px'),
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Text('Notificações:', style: TextStyle(fontSize: 16)),
              SizedBox(width: 12),
              _Badge(quantidade: 9),
            ],
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.quantidade});

  final int quantidade;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Text(
        '$quantidade',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
