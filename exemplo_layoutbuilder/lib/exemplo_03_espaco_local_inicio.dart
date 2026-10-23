// exemplo_03_espaco_local_inicio.dart
// Ponto de partida: um cartão que mede o próprio espaço, dentro de uma caixa de
// 180px.
//
// Ele mostra dois números: o que o LayoutBuilder viu e o que o MediaQuery diz
// ser a largura da tela. Aqui eles são bem diferentes.
//
// A pergunta do bloco: qual dos dois muda se eu puser este MESMO cartão em
// outro lugar?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaEspacoLocal()));

class TelaEspacoLocal extends StatelessWidget {
  const TelaEspacoLocal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('O espaço é local, não a tela')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Um cartão dentro de uma caixa estreita:'),
            SizedBox(height: 16),
            SizedBox(width: 180, child: CartaoQueMede(nome: 'Caixa de 180px')),
          ],
        ),
      ),
    );
  }
}

// O cartão mede o próprio espaço (LayoutBuilder) e também pergunta o tamanho da
// tela (MediaQuery), só para comparar.
class CartaoQueMede extends StatelessWidget {
  const CartaoQueMede({super.key, required this.nome});

  final String nome;

  @override
  Widget build(BuildContext context) {
    // MediaQuery.sizeOf lê o tamanho da TELA. Aqui usamos só para o contraste —
    // MediaQuery é assunto da próxima aula; por ora, guarde: é a tela toda.
    final larguraDaTela = MediaQuery.sizeOf(context).width;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // constraints.maxWidth = o espaço que o PAI IMEDIATO deu a este cartão.
        final larguraLocal = constraints.maxWidth;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(nome, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('LayoutBuilder (local): ${larguraLocal.toStringAsFixed(1)}'),
              Text('MediaQuery (tela): ${larguraDaTela.toStringAsFixed(1)}'),
            ],
          ),
        );
      },
    );
  }
}
