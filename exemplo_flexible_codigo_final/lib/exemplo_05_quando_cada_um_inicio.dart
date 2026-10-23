// exemplo_05_quando_cada_um_inicio.dart
// Ponto de partida: duas linhas de um card de verdade, ambas com Expanded.
//
// * A primeira linha está certa: duas abas que DEVEM ocupar metade da largura
// * cada. O conteúdo não importa — eu QUERO que cada uma preencha sua metade.
// * Isso é trabalho de tight.
//
// ! A segunda linha ficou estranha: o fundo da etiqueta de nome esticou até
// ! encostar no preço, com um monte de vazio depois do texto. Uma etiqueta
// ! deveria ter o tamanho do conteúdo.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaQuandoCadaUm()));

class TelaQuandoCadaUm extends StatelessWidget {
  const TelaQuandoCadaUm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quando cada um')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // * CASO 1 — Expanded para DIVIDIR. Correto.
            const Row(
              children: [
                Expanded(child: _Aba('Entrar', Colors.indigo)),
                SizedBox(width: 8),
                Expanded(child: _Aba('Cadastrar', Colors.indigo)),
              ],
            ),

            const SizedBox(height: 24),

            // ! CASO 2 — Expanded numa etiqueta. Estranho.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.teal.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Fone Bluetooth',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const Text(
                  r'R$ 199,90',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Aba extends StatelessWidget {
  const _Aba(this.texto, this.cor);

  final String texto;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        texto,
        style: TextStyle(color: cor, fontWeight: FontWeight.w600),
      ),
    );
  }
}
