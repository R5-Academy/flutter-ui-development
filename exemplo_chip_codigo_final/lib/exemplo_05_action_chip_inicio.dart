// exemplo_05_action_chip_inicio.dart
// Ponto de partida: as ações sugeridas na tela de um contato — Ligar,
// Compartilhar, Ver no mapa. Feitas com `FilterChip`, que é o que a gente
// aprendeu a usar quando um chip precisa responder ao toque.
//
// ! Toque em "Ligar". A ligação acontece (veja o console) — e o chip fica
// ! MARCADO para sempre: o fundo vira a cor de selecionado e um check é
// ! desenhado por cima do ícone do telefone (quando o chip tem `avatar`, o
// ! check cobre o avatar em vez de abrir espaço ao lado).
//
// ? O que significaria "Ligar está selecionado"? Nada. Ligar é uma coisa que
// ? você FAZ, não um estado em que você fica.
//
// Marcar exige guardar; agir, não. Existe uma terceira variante de chip para
// quando não há nada a guardar.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: AcoesRapidas()));

class AcoesRapidas extends StatelessWidget {
  const AcoesRapidas({super.key});

  void _acionar(String rotulo) {
    debugPrint('executou: $rotulo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ações rápidas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ações sugeridas:'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                ActionChip.elevated(
                  avatar: const Icon(Icons.call, size: 18),
                  label: const Text('Ligar'),
                  onPressed: () => _acionar('Ligar'),
                ),
                ActionChip(
                  avatar: const Icon(Icons.share, size: 18),
                  label: const Text('Compartilhar'),
                  onPressed: () => _acionar('Compartilhar'),
                ),
                ActionChip(
                  avatar: const Icon(Icons.map, size: 18),
                  label: const Text('Ver no mapa'),
                  onPressed: () => _acionar('Ver no mapa'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
