// exemplo_04_pai_unbounded_inicio.dart
// A armadilha clássica: "fração" só faz sentido quando existe um espaço FINITO
// para fracionar.
//
// ! Este arquivo QUEBRA ao rodar, de propósito. Rode e leia o erro vermelho:
// !   BoxConstraints forces an infinite width.
// ! Vem do mesmo assert que vocês já viram na aula de SizedBox
// ! (BoxConstraints.debugAssertIsValid, disparado por RenderObject.layout),
// ! só que a causa aqui é nova: o UnconstrainedBox entrega largura INFINITA, e
// ! widthFactor: 0.5 calcula "metade de infinito" = infinito. O Flutter aponta o
// ! FractionallySizedBox como culpado e mostra a constraint que ele produziu:
// !   BoxConstraints(w=Infinity, 0.0<=h<=Infinity)
// ! Só a LARGURA é infinita porque heightFactor é null — o eixo sem fator passa
// ! direto e continua saudável.
//
// O UnconstrainedBox aqui é só um gerador de espaço infinito, para provar o
// ponto. Na vida real você cai nisso ao pôr um FractionallySizedBox direto
// dentro de um Row/Column (próxima seção): o eixo principal deles é unbounded.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoUnbounded()));

class DemoUnbounded extends StatelessWidget {
  const DemoUnbounded({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: UnconstrainedBox(
          // A faixa clara existe para dar referência visual ao espaço do pai —
          // é sobre a largura DELA que a fração deveria incidir. Aqui ela nem
          // chega a aparecer, porque o layout estoura antes de pintar.
          child: ColoredBox(
            color: Colors.black12,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: ColoredBox(color: Colors.indigo),
            ),
          ),
        ),
      ),
    );
  }
}
