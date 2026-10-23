// exemplo_04_parametros_inicio.dart
// A tela tem quatro pedaços que vamos ajustar:
//
//   1. um campo de texto — abra o teclado e arraste a tela;
//   2. uma faixa de cards que passa da largura;
//   3. três caixinhas roláveis, todas com o comportamento padrão.
//
// ! A faixa de cards estoura: "A RenderFlex overflowed by N pixels on the
// ! right". São 12 cards de 100px + 8 de margem = 1296 px de conteúdo, e a
// ! tela nunca tem tudo isso. O N depende da largura da janela (medido:
// ! 968 em 360, 928 em 400, 528 em 800, 48 em 1280) — estoura em qualquer uma.
//
// O resto roda sem erro. O que falta são os parâmetros do
// SingleChildScrollView que mudam como cada pedaço se comporta.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppParametros());

class AppParametros extends StatelessWidget {
  const AppParametros({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parâmetros',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const TelaParametros(),
    );
  }
}

class TelaParametros extends StatelessWidget {
  const TelaParametros({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parâmetros')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Titulo('Toque no campo e abra o teclado'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Arraste depois de abrir o teclado',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const _Titulo('Uma faixa de cards mais larga que a tela'),
            SizedBox(
              height: 120,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: List.generate(
                    12,
                    (i) => Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors
                            .primaries[i % Colors.primaries.length]
                            .shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Text('Card $i')),
                    ),
                  ),
                ),
              ),
            ),

            const _Titulo('Caixa cinza'),
            _Caixa(child: SingleChildScrollView(child: _Blocos(Colors.grey))),

            const _Titulo('Caixa azul'),
            _Caixa(child: SingleChildScrollView(child: _Blocos(Colors.blue))),

            const _Titulo('Caixa roxa'),
            _Caixa(child: SingleChildScrollView(child: _Blocos(Colors.purple))),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _Titulo extends StatelessWidget {
  const _Titulo(this.texto);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        texto,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
      ),
    );
  }
}

class _Caixa extends StatelessWidget {
  const _Caixa({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
      child: child,
    );
  }
}

class _Blocos extends StatelessWidget {
  const _Blocos(this.cor);

  final MaterialColor cor;

  @override
  Widget build(BuildContext context) => Column(
    children: List.generate(
      8,
      (i) => Container(
        height: 40,
        color: cor[((i % 5) + 1) * 100],
        alignment: Alignment.center,
        child: Text('linha $i'),
      ),
    ),
  );
}
