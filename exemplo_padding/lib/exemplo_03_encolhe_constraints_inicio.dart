// exemplo_03_encolhe_constraints_inicio.dart
// Ponto de partida: um Container azul VAZIO, direto no body.
//
// Ele preencheu a tela inteira — e isso é a aula passada: um Container sem filho
// pede o máximo que o pai permite. Guarde essa imagem: agora vamos pôr um
// Padding no meio e ver o azul recuar.
//
// ! Por que Container e não ColoredBox para uma caixa só de cor? Porque aqui ela
// ! está VAZIA: sem filho, o ColoredBox mede 0x0 e você não vê nada (ele só
// ! acompanha o tamanho de alguém). A aula de Container já avisou disso.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: Demo()));

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE082),
      body: Container(color: Colors.blue),
    );
  }
}
