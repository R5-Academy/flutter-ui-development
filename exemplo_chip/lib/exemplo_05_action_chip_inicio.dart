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

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: AcoesRapidas()));

class AcoesRapidas extends StatefulWidget {
  const AcoesRapidas({super.key});

  @override
  State<AcoesRapidas> createState() => _AcoesRapidasState();
}

class _AcoesRapidasState extends State<AcoesRapidas> {
  // ! Estado que existe só porque o FilterChip exige um `selected`.
  final _acionadas = <String>{};

  void _acionar(String rotulo) {
    debugPrint('executou: $rotulo');
    setState(() => _acionadas.add(rotulo));
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
                FilterChip(
                  avatar: const Icon(Icons.call, size: 18),
                  label: const Text('Ligar'),
                  // ! Um chip de ação não tem por que "estar selecionado".
                  selected: _acionadas.contains('Ligar'),
                  onSelected: (_) => _acionar('Ligar'),
                ),
                FilterChip(
                  avatar: const Icon(Icons.share, size: 18),
                  label: const Text('Compartilhar'),
                  selected: _acionadas.contains('Compartilhar'),
                  onSelected: (_) => _acionar('Compartilhar'),
                ),
                FilterChip(
                  avatar: const Icon(Icons.map, size: 18),
                  label: const Text('Ver no mapa'),
                  selected: _acionadas.contains('Ver no mapa'),
                  onSelected: (_) => _acionar('Ver no mapa'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
