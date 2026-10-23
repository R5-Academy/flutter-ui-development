// exemplo_01_escada_dos_acessores_inicio.dart
// Ponto de partida: dois cartões leem a MESMA largura da tela, um com
// `MediaQuery.of(context).size` e outro com `MediaQuery.sizeOf(context)`. Cada um
// conta quantas vezes reconstruiu.
//
// * Você já viu esses dois na aula de MediaQuery da fase Foundations: o `.of`
// * depende do MediaQueryData INTEIRO, então reconstrói a cada teclado, brilho ou
// * escala de fonte; o `sizeOf` assina só o aspecto "size".
//
// Rode no desktop ou no navegador e arraste APENAS a borda de BAIXO da janela
// (a largura não muda, só a altura).
//
// ! Os dois contadores sobem — inclusive o do `sizeOf`. Ele assina o `size`
// ! inteiro, e a altura faz parte do `size`. Se o meu cartão só usa a LARGURA,
// ! por que ele reconstruiu?
//
// O `sizeOf` não é o degrau mais baixo da escada.

import 'package:material_ui/material_ui.dart';

// Contadores de rebuild. Globais só para conseguirmos VISUALIZAR quantas vezes
// cada cartão reconstruiu — efeito colateral no build não é coisa que se faça em
// app de verdade; aqui é didático.
int _buildsComOf = 0;
int _buildsComSizeOf = 0;

void main() => runApp(const MaterialApp(home: EscadaDosAcessores()));

class EscadaDosAcessores extends StatelessWidget {
  const EscadaDosAcessores({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('A escada dos acessores')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _CartaoComOf(),
          SizedBox(height: 12),
          _CartaoComSizeOf(),
          SizedBox(height: 24),
          Text(
            'Arraste só a borda de BAIXO da janela: a largura fica igual, e os '
            'dois contadores sobem.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _CartaoComOf extends StatelessWidget {
  const _CartaoComOf();

  @override
  Widget build(BuildContext context) {
    _buildsComOf++;
    // Depende do objeto INTEIRO: qualquer campo que mude reconstrói este cartão.
    final largura = MediaQuery.of(context).size.width;

    return _Cartao(
      titulo: 'MediaQuery.of(context).size.width',
      largura: largura,
      builds: _buildsComOf,
      cor: Colors.red,
    );
  }
}

class _CartaoComSizeOf extends StatelessWidget {
  const _CartaoComSizeOf();

  @override
  Widget build(BuildContext context) {
    _buildsComSizeOf++;
    // Assina só o aspecto "size" — mas o size tem DOIS lados.
    final largura = MediaQuery.sizeOf(context).width;

    return _Cartao(
      titulo: 'MediaQuery.sizeOf(context).width',
      largura: largura,
      builds: _buildsComSizeOf,
      cor: Colors.orange,
    );
  }
}

class _Cartao extends StatelessWidget {
  const _Cartao({
    required this.titulo,
    required this.largura,
    required this.builds,
    required this.cor,
  });

  final String titulo;
  final double largura;
  final int builds;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cor.withValues(alpha: 0.1),
      child: ListTile(
        title: Text(titulo, style: const TextStyle(fontSize: 14)),
        subtitle: Text('largura: ${largura.toStringAsFixed(0)} px'),
        trailing: Text(
          'builds: $builds',
          style: TextStyle(fontWeight: FontWeight.bold, color: cor),
        ),
      ),
    );
  }
}
