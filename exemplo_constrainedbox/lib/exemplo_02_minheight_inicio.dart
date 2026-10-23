// exemplo_02_minheight_inicio.dart
// Ponto de partida: um botão desenhado à mão, sem piso de altura.
//
// ! Com um texto curto como "Entrar", a caixa encolhe até quase a altura da
// ! fonte (uma linha de texto: 23 de altura na medição). Vira um alvo de toque
// ! baixo demais — o mínimo recomendado é 48 (o kMinInteractiveDimension do
// ! Material). Problema de acessibilidade, e de gente errando o clique.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaBotao()));

class TelaBotao extends StatelessWidget {
  const TelaBotao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('minHeight para área clicável')),
      body: const Center(child: _CaraDeBotao()),
    );
  }
}

// Este Container só pinta a "cara" de botão.
class _CaraDeBotao extends StatelessWidget {
  const _CaraDeBotao();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(12),
      ),
      // Align com os dois fatores em 1 abraça o filho (aula de Align): a caixa
      // fica do tamanho do texto e só cresce se algum mínimo empurrar. É assim
      // que o próprio ElevatedButton centraliza o rótulo sem esticar.
      // ! Não troque por `alignment: Alignment.center` no Container: um Align
      // ! sem fator preenche todo o espaço do pai, o botão viraria a tela
      // ! inteira e não sobraria nada para o minHeight fazer.
      child: const Align(
        widthFactor: 1,
        heightFactor: 1,
        child: Text(
          'Entrar',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
