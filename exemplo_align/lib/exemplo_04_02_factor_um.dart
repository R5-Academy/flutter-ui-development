// exemplo_04_02_factor_um.dart
// O terceiro caso do factor: 1 em vez de 2.
//
// * O Align cola no tamanho exato do filho — o amarelo some completamente,
// * porque não sobrou moldura nenhuma.
//
// Prova a regra: factor multiplica o tamanho do filho.
//   sem factor -> o maior possível (o pai)
//   factor 1   -> igual ao filho
//   factor 2   -> o dobro do filho
//
// * Com factor 1 o alignment perde o efeito: não há espaço livre onde escolher
// * um canto. Prove ao vivo — troque bottomRight por topLeft e o roxo NÃO se
// * mexe (medido: nos dois casos o filho fica no offset (0,0) do Align).

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: DemoFator()));

class DemoFator extends StatelessWidget {
  const DemoFator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('widthFactor / heightFactor')),
      body: const Align(
        child: ColoredBox(
          color: Colors.amber,
          child: Align(
            alignment: Alignment.bottomRight,
            widthFactor: 1,
            heightFactor: 1,
            child: _Filho(),
          ),
        ),
      ),
    );
  }
}

class _Filho extends StatelessWidget {
  const _Filho();

  @override
  Widget build(BuildContext context) {
    return Container(width: 80, height: 80, color: Colors.deepPurple);
  }
}
