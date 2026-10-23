// exemplo_02_barra_progresso_inicio.dart
// Ponto de partida: o caso de uso clássico. Uma barra de progresso é
// literalmente uma fração da largura do trilho — widthFactor = progresso.
//
// ! Mas repare no resultado: o preenchimento está crescendo A PARTIR DO MEIO,
// ! para os dois lados. Nenhuma barra de progresso do mundo funciona assim.
//
// O culpado é o alignment padrão (center), que não foi informado.
//
// * Sobre o `width: double.infinity` do trilho: dentro de uma Column os filhos
// * recebem a largura em constraints LOOSE (0 <= w <= largura disponível). Com
// * largura solta, o trilho encolheria até o tamanho do preenchimento e o cinza
// * desapareceria — não haveria trilho nenhum, nem espaço para o alignment agir.
// * O `double.infinity` é o mesmo truque do SizedBox.expand: obriga o trilho a
// * ocupar a largura toda, e é sobre ELA que a fração é calculada.
//
// Andaime: ListView, Column e Row são de seções posteriores (Scrollables e
// Layouts Flexíveis). Aqui eles só servem para empilhar as quatro barras na
// tela; o assunto da aula é o FractionallySizedBox de dentro do trilho.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoBarraProgresso()));

class _Curso {
  const _Curso(this.nome, this.progresso);

  final String nome;

  /// De 0.0 (não começou) a 1.0 (concluído).
  final double progresso;
}

const List<_Curso> _cursos = [
  _Curso('Flutter Start', 1),
  _Curso('Foundations', 0.65),
  _Curso('UI Development', 0.35),
  _Curso('Advanced', 0.1),
];

class DemoBarraProgresso extends StatelessWidget {
  const DemoBarraProgresso({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu progresso')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          for (final _Curso curso in _cursos) _LinhaDeProgresso(curso: curso),
        ],
      ),
    );
  }
}

class _LinhaDeProgresso extends StatelessWidget {
  const _LinhaDeProgresso({required this.curso});

  final _Curso curso;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(curso.nome),
          const SizedBox(height: 6),
          // O trilho: fundo cinza de 12 de altura e largura TOTAL. Ele é o "pai"
          // da fração — os 352 medidos numa janela de 400 (24 de padding em cada
          // lado).
          SizedBox(
            width: double.infinity,
            height: 12,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(6),
              ),
              // * O preenchimento: widthFactor = progresso.
              child: FractionallySizedBox(
                widthFactor: curso.progresso,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
