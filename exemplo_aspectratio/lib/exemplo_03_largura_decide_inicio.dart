// exemplo_03_largura_decide_inicio.dart
// Ponto de partida: uma thumbnail 16/9 dentro de um SizedBox de 120 de largura.
//
// A altura saiu 67.5. Ninguém escreveu 67.5 em lugar nenhum — ela veio de
// 120 / (16/9).
//
// Guarde esse número. Agora vamos oferecer larguras diferentes à MESMA
// AspectRatio.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaComparativo()));

class TelaComparativo extends StatelessWidget {
  const TelaComparativo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('A largura decide a altura')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _Rotulo('Largura fixa de 120 -> altura 67.5'),
          // ! O Align aqui não é enfeite. A ListView entrega aos filhos a
          // ! largura toda em constraints TIGHT, e contra tight um SizedBox de
          // ! 120 seria ignorado (a caixa sairia com a largura da tela). O
          // ! Align afrouxa a largura antes de repassá-la: só então o 120 vale.
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(width: 120, child: _Thumb()),
          ),
        ],
      ),
    );
  }
}

// Widget reutilizado nos casos: é EXATAMENTE a mesma AspectRatio.
class _Thumb extends StatelessWidget {
  const _Thumb();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.teal,
        alignment: Alignment.center,
        child: const Icon(Icons.movie, color: Colors.white),
      ),
    );
  }
}

class _Rotulo extends StatelessWidget {
  const _Rotulo(this.texto);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
