// exemplo_01_03_tamanho_encolhe_no_filho.dart
// Terceiro passo, e o mais contraintuitivo: tirei o width/height e coloquei um
// FILHO.
//
// ! O mesmo Container que enchia a tela agora tem 36x26 — o tamanho exato do
// ! texto. Sem alignment, um Container COM filho passa as constraints do pai
// ! para o filho e depois se ENCOLHE no tamanho que o filho devolveu.
//
// Compare os dois números lado a lado, é o coração da aula:
//   Container(color: azul)                 -> 400x800 (a tela toda)
//   Container(color: azul, child: Text())  ->   36x26 (o texto)
//
// * E repare no efeito colateral: o texto também está no canto. Não é o
// * Container empurrando ele para lá — é que não SOBROU espaço nenhum dentro do
// * Container para posicionar coisa alguma. Um Container do tamanho do filho não
// * tem onde alinhar nada.
//
// Daí a pergunta que fecha o bloco: e se eu quiser esse texto no meio?
// Resposta no exemplo_01_01_tamanho_completo.dart.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoTamanho()));

class DemoTamanho extends StatelessWidget {
  const DemoTamanho({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: const Text(
          'oi',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
