// exemplo_03_listtile_no_card_inicio.dart
// Ponto de partida: o combo clássico — um `ListTile` dentro de um `Card`. O
// Card dá a superfície (cantos, sombra), o ListTile dá o miolo da linha.
//
// ! Este defeito você só vê TOCANDO. Segure o dedo (ou o mouse) sobre o card: o
// ! efeito de toque é RETANGULAR — o realce cinza cobre o tile inteiro e o
// ! splash se espalha em círculo — e os dois passam por cima dos cantos
// ! arredondados. Nos quatro cantos aparece um naco de cor fora da curva.
//
// ? Por que vaza: o `ListTile` monta um `InkWell` sem recorte
// ? (`customBorder: null`, medido), e o `Card` vem com `clipBehavior: Clip.none`
// ? de fábrica — ninguém no caminho manda respeitar a curva.
//
// ? É o mesmo problema da imagem que vazava o card na aula passada — só que
// ? agora quem vaza é o efeito de toque, e por isso ele não aparece parado.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: ListTileNoCard()));

class ListTileNoCard extends StatelessWidget {
  const ListTileNoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text('ListTile no Card')),
      body: Center(
        child: SizedBox(
          width: 340,
          child: Card(
            // Raio bem redondo para o vazamento não passar despercebido.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo.shade100,
                child: const Text('AS'),
              ),
              title: const Text('Ana Souza'),
              subtitle: const Text('ana.souza@email.com'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}
