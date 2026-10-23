// exemplo_01_safearea_inicio.dart
// Ponto de partida: o problema que motiva a aula inteira.
//
// ! Repare: não há AppBar. Sem AppBar, o body ocupa a tela inteira, inclusive a
// ! faixa da status bar lá em cima. Nada protege o conteúdo.
//
// ! A barra roxa deveria ser o "topo" visível do app, mas parte dela fica
// ! ESCONDIDA atrás do relógio, da bateria e — em celulares com notch — atrás
// ! do recorte da câmera. Ela começa em y = 0 da tela física.
//
// Rode num emulador ou celular com status bar visível para ver o estrago.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppSafeArea());

class AppSafeArea extends StatelessWidget {
  const AppSafeArea({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaLoja(),
    );
  }
}

class TelaLoja extends StatelessWidget {
  const TelaLoja({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF2F2F7),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _BarraDeTitulo(),
          Expanded(child: Center(child: Text('Conteúdo da tela'))),
        ],
      ),
    );
  }
}

class _BarraDeTitulo extends StatelessWidget {
  const _BarraDeTitulo();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF6750A4),
      padding: const EdgeInsets.all(16),
      child: const Text(
        'Minha Loja',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
