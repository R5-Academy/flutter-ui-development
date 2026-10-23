// exemplo_02_keyboardtype_inicio.dart
// Ponto de partida: um cadastro com três campos — e-mail, idade e telefone.
//
// ! Rode **no celular ou emulador** e toque em cada um. O teclado é sempre o
// ! mesmo: o alfabético comum.
//
// ! Para digitar a idade, a pessoa precisa achar a tecla que troca para os
// ! números. Para o telefone, de novo. Para o e-mail, ela vai caçar o "@" —
// ! que, no teclado padrão, está escondido atrás de outra troca de modo.
// !
// ! São dois toques extras por campo, num formulário que tem três. E a tecla de
// ! confirmar diz "Enter" em todos, sem indicar que ainda há campos pela frente.
//
// O sistema sabe mostrar teclados diferentes. Só falta alguém pedir.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TiposDeTeclado()));

class TiposDeTeclado extends StatelessWidget {
  const TiposDeTeclado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('keyboardType')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'E-mail',
                hintText: 'voce@exemplo.com',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Idade',
                hintText: 'Somente números',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Telefone',
                hintText: '(11) 90000-0000',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
