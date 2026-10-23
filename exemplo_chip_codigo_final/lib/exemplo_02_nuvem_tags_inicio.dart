// exemplo_02_nuvem_tags_inicio.dart
// Ponto de partida: sete tags num `Wrap`, cada uma com o seu "x" funcionando —
// o `onDeleted` está lá e é chamado.
//
// ! Clique num "x" e olhe o console: a mensagem sai. Olhe a tela: a tag
// ! continua exatamente onde estava.
//
// ! Não é bug do Flutter. É o que o bloco anterior avisou: o `onDeleted` avisa,
// ! não remove. E aqui está o motivo — a tela é um reflexo da lista `_tags`, e
// ! ninguém mexeu na lista.
//
// O `Wrap` aqui é só o andaime — ele já foi ensinado em Layouts Flexíveis. A
// largura de 320 é fixa de propósito: assim a nuvem quebra nas mesmas linhas em
// qualquer tela, do celular ao Chrome maximizado. Numa janela larga, as sete
// tags caberiam todas numa linha só.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: NuvemTags()));

class NuvemTags extends StatefulWidget {
  const NuvemTags({super.key});

  // A fonte da verdade: a lista de tags. A tela é um reflexo dela.

  @override
  State<NuvemTags> createState() => _NuvemTagsState();
}

class _NuvemTagsState extends State<NuvemTags> {
  final _tags = [
    'Flutter',
    'Dart',
    'Mobile',
    'UI',
    'Widgets',
    'Layout',
    'State',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuvem de tags')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Palco de largura fixa: a nuvem quebra igual em qualquer tela.
        child: SizedBox(
          width: 320,
          child: Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (final tag in _tags)
                Chip(
                  key: ValueKey(tag),
                  label: Text(tag),
                  // ! Avisa e só. A lista continua com as sete tags.
                  onDeleted: () {
                    setState(() {
                      _tags.remove(tag);
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
