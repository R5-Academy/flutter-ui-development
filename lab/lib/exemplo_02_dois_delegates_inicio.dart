// exemplo_02_dois_delegates_inicio.dart
// A bancada dos dois delegates, com o lado direito ainda vazio.
//
// O que já está pronto: o palco (a largura que as grades recebem), o slider que
// muda essa largura, o cabeçalho que imprime a conta do MaxCrossAxisExtent e o
// painel da esquerda, com o delegate que você já viu —
// SliverGridDelegateWithFixedCrossAxisCount. Ele recebe o número de colunas e
// mantém esse número sempre: três colunas num palco estreito, três num largo.
//
// O painel da direita está reservado e vazio. É ele que vai receber o segundo
// delegate, o que trabalha por TAMANHO em vez de por contagem.
//
// Arraste o slider e repare em duas coisas: o painel da esquerda nunca muda de
// número de colunas (elas só ficam mais magras ou mais gordas), e a conta no
// cabeçalho muda o tempo todo — mas ainda não há nenhuma grade na tela que a
// obedeça.

import 'package:material_ui/material_ui.dart';

// O teto que o segundo delegate vai receber: célula de ATÉ 150 px de largura.
const double kMaximo = 150.0;
// O piso do slider: sem ele dá para arrastar até zero e não sobra grade.
const double kLarguraMinima = 200.0;

void main() => runApp(const AppDosDelegates());

class AppDosDelegates extends StatelessWidget {
  const AppDosDelegates({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contagem fixa x Largura máxima',
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: const TelaDosDelegates(),
    );
  }
}

class TelaDosDelegates extends StatefulWidget {
  const TelaDosDelegates({super.key});

  @override
  State<TelaDosDelegates> createState() => _TelaDosDelegatesState();
}

class _TelaDosDelegatesState extends State<TelaDosDelegates> {
  // A largura do palco. É ela que o slider muda — não a janela.
  double? _palco;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contagem fixa x Largura máxima')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Tudo o que a janela oferece. É o teto do slider.
          final maxima = constraints.maxWidth;
          // Enquanto ninguém arrastou, _palco é null e o palco ocupa tudo. O
          // clamp segura o valor dentro da janela quando ela encolhe.
          final palco = (_palco ?? maxima).clamp(kLarguraMinima, maxima);
          // Metade do palco para cada painel: a Row divide igual entre os dois
          // Expanded, e não há nada entre eles. Como a grade não tem padding,
          // esta é exatamente a largura que o delegate recebe.
          final largura = palco / 2;
          // A conta do MaxCrossAxisExtent, em dois passos.
          // Passo 1: quantas células de kMaximo cabem — arredondando para CIMA.
          final colunas = (largura / kMaximo).ceil();
          // Passo 2: o espaço dividido igualmente entre elas.
          final larguraDaCelula = largura / colunas;

          return Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.teal.shade50,
                child: Text(
                  'painel ${largura.toStringAsFixed(0)} px'
                  '  ->  ceil(${largura.toStringAsFixed(0)}'
                  ' / ${kMaximo.toStringAsFixed(0)}) = $colunas colunas\n'
                  'cada célula: ${largura.toStringAsFixed(0)} / $colunas'
                  ' = ${larguraDaCelula.toStringAsFixed(1)} px'
                  '   (o teto era ${kMaximo.toStringAsFixed(0)})',
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ),
              Slider(
                min: kLarguraMinima,
                max: maxima,
                value: palco,
                label: '${palco.toStringAsFixed(0)} px',
                divisions: 40,
                onChanged: (valor) => setState(() => _palco = valor),
              ),
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: palco,
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: _Painel(
                            titulo: 'FixedCrossAxisCount(3)',
                            subtitulo:
                                'sempre 3 colunas, não importa a largura',
                            cor: Colors.orange,
                            // CONTAGEM FIXA: eu mando no número de colunas.
                            delegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                          ),
                        ),
                        // O espaço do segundo painel, ainda vazio.
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Painel extends StatelessWidget {
  const _Painel({
    required this.titulo,
    required this.subtitulo,
    required this.cor,
    required this.delegate,
  });

  final String titulo;
  final String subtitulo;
  final MaterialColor cor;
  final SliverGridDelegate delegate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          color: cor.shade50,
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                titulo,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(subtitulo, style: const TextStyle(fontSize: 11)),
            ],
          ),
        ),
        Expanded(
          // A grade não tem padding: assim a largura do painel é exatamente a
          // largura que o delegate recebe, e a conta do cabeçalho bate.
          child: GridView.builder(
            gridDelegate: delegate,
            itemCount: 60,
            // O item ocupa a célula inteira. A separação é a borda branca.
            itemBuilder: (context, indice) => Container(
              decoration: BoxDecoration(
                color: cor.shade200,
                border: Border.all(color: Colors.white),
              ),
              alignment: Alignment.center,
              child: Text('$indice'),
            ),
          ),
        ),
      ],
    );
  }
}
