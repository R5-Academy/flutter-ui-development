// exemplo_03_indent_inicio.dart
// Ponto de partida: quatro divisores, e os quatro vão de ponta a ponta.
//
// Cada rótulo diz o que a gente PRECISA que aquela linha faça. Nenhuma delas
// faz — todas estão iguais, cortando a tela de borda a borda.
//
// ! Uma linha que fura até a borda "corta" a tela em duas. Quando o conteúdo
// ! tem uma margem (e quase sempre tem), o separador precisa respeitar a mesma
// ! margem, senão ele briga com o alinhamento em vez de organizar.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: IndentEndIndent()));

class IndentEndIndent extends StatelessWidget {
  const IndentEndIndent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('indent / endIndent')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('De ponta a ponta (é o que queremos aqui):'),
            Divider(thickness: 2),

            SizedBox(height: 24),

            Text('Queremos: recuada 32 só na esquerda'),
            Divider(thickness: 2),

            SizedBox(height: 24),

            Text('Queremos: recuada 32 nos dois lados'),
            Divider(thickness: 2),

            SizedBox(height: 24),

            Text('Queremos: recuo dos dois lados e cor própria'),
            Divider(thickness: 2),
          ],
        ),
      ),
    );
  }
}
