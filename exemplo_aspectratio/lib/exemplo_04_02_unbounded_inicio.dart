// exemplo_04_02_unbounded_inicio.dart
// A segunda armadilha: UNBOUNDED nas duas direções.
//
// ! Este arquivo QUEBRA ao rodar, de propósito. Rode e leia a primeira exceção
// ! do console:
// !   RenderAspectRatio has unbounded constraints.
// !   This RenderAspectRatio was given an aspect ratio of 1.7777777777777777
// !   but was given both unbounded width and unbounded height constraints.
// ! As exceções seguintes ("RenderBox was not laid out") são só a consequência
// ! desta primeira.
//
// A lista vertical não limita a ALTURA dos filhos — a rolagem pode crescer o
// quanto quiser. A Row não limita a LARGURA dos filhos — o eixo dela também é
// livre. Juntando os dois, o AspectRatio recebe largura E altura ilimitadas:
// não sobra âncora nenhuma, e ele não tem de onde tirar um tamanho.
//
// O conserto está no exemplo_04_02_unbounded_completo.dart.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaArmadilhaUnbounded()));

class TelaArmadilhaUnbounded extends StatelessWidget {
  const TelaArmadilhaUnbounded({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Armadilha: unbounded')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _Rotulo('Sem nenhuma âncora: o layout estoura'),
          // ! A lista deixa a altura livre; a Row deixa a largura livre.
          Row(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ColoredBox(color: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Rotulo extends StatelessWidget {
  const _Rotulo(this.texto);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(texto, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
