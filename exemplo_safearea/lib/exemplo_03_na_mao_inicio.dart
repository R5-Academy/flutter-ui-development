// exemplo_03_na_mao_inicio.dart
// Ponto de partida: o resultado do bloco 1, com o SafeArea pronto.
//
// Funciona, é curto e é o que você vai usar no dia a dia.
//
// Mas o que ele faz por baixo? A pergunta deste bloco é: dá para reproduzir
// isso sem o SafeArea?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppNaMao());

class AppNaMao extends StatelessWidget {
  const AppNaMao({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaNaMao(),
    );
  }
}

class TelaNaMao extends StatelessWidget {
  const TelaNaMao({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF2F2F7),
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _BarraDeTitulo(texto: 'Topo seguro'),
            Expanded(child: Center(child: Text('Conteúdo da tela'))),
          ],
        ),
      ),
    );
  }
}

class _BarraDeTitulo extends StatelessWidget {
  const _BarraDeTitulo({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF6750A4),
      padding: const EdgeInsets.all(16),
      child: Text(
        texto,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
