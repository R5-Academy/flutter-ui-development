// exemplo_03_grid_x_wrap_inicio.dart
// Doze tags de assunto, numa grade de três colunas.
//
// As tags têm tamanhos bem diferentes: "UI" tem duas letras, "Gerenciamento de
// estado" tem vinte e quatro.
//
// ! Repare no resultado: os textos longos são cortados com reticências, e os
// ! curtos ficam com espaço sobrando dos dois lados.
//
// A grade dá a MESMA largura para todo mundo. Para tags, isso é o que a gente
// quer?
//
// A tela já está dividida em dois painéis, com o cartão de cada um escrito. O
// de cima está vazio: é onde entra o concorrente da grade, com os MESMOS dados.

import 'package:flutter/material.dart';

void main() => runApp(const AppGridXWrap());

class AppGridXWrap extends StatelessWidget {
  const AppGridXWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GridView x Wrap',
      theme: ThemeData(colorSchemeSeed: Colors.pink),
      home: const TelaGridXWrap(),
    );
  }
}

class TelaGridXWrap extends StatelessWidget {
  const TelaGridXWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quando Grid, quando Wrap')),
      body: Column(
        children: <Widget>[
          const _Nota(
            titulo: 'Wrap: cada filho tem o tamanho que ele pediu',
            texto:
                'A linha quebra quando acaba o espaço. Nenhum filho é '
                'esticado. Não é lazy: os 12 chips foram medidos. Com 5 mil, '
                'seriam 5 mil.',
          ),
          // O painel de cima, ainda vazio.
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [for (final tag in tags) Chip(label: Text(tag))],
          ),
          const Divider(height: 1),
          const _Nota(
            titulo: 'GridView: a célula manda no tamanho',
            texto:
                'Toda célula tem a MESMA largura. O texto longo é truncado, o '
                'curto sobra espaço. Em compensação, é lazy e rola sozinho.',
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 48,
              ),
              itemCount: tags.length,
              itemBuilder: (context, indice) =>
                  _TagNaGrade(texto: tags[indice]),
            ),
          ),
        ],
      ),
    );
  }
}

const List<String> tags = <String>[
  'Dart',
  'Flutter',
  'Gerenciamento de estado',
  'UI',
  'Widgets',
  'Testes automatizados',
  'CI',
  'Arquitetura limpa',
  'Animações',
  'Slivers',
  'Performance',
  'Acessibilidade',
];

class _TagNaGrade extends StatelessWidget {
  const _TagNaGrade({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.pink.shade200),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        texto,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}

// O cartão que rotula cada painel.
class _Nota extends StatelessWidget {
  const _Nota({required this.titulo, required this.texto});

  final String titulo;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: Colors.pink.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(texto, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
