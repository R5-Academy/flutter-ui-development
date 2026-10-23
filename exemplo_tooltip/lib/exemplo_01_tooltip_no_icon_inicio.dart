// exemplo_01_tooltip_no_icon_inicio.dart
// Ponto de partida: a barra de ações de um artigo. Três ícones, nenhuma
// palavra.
//
// ! O coração é "favoritar" ou "curtir"? O marcador é "salvar para depois" ou
// ! "adicionar a uma lista"? Os três ícones são bons, e mesmo assim a pessoa
// ! precisa tocar para descobrir — ou desistir.
//
// ! E quem usa leitor de tela não tem nem essa chance. Um `Icon` sem
// ! `semanticLabel` não gera NÓ NENHUM na árvore de semântica: o leitor de tela
// ! simplesmente pula os três. Não é "três ícones sem nome" — é três ícones que
// ! não existem.
//
// O texto não cabe embaixo do ícone (a barra ficaria enorme). Precisa aparecer
// só quando a pessoa demonstrar interesse.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TooltipNoIcon()));

class TooltipNoIcon extends StatelessWidget {
  const TooltipNoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artigo')),
      body: const Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 32,
          children: [
            Icon(Icons.favorite, size: 40, color: Colors.red),
            Icon(Icons.bookmark_border, size: 40),
            Icon(Icons.share, size: 40),
          ],
        ),
      ),
    );
  }
}
