// exemplo_03_variantes_material3_inicio.dart
// Ponto de partida: a barra de um editor de fotos. Quatro ações com
// importâncias bem diferentes:
//
//   Salvar   -> o objetivo da tela
//   Recortar -> a edição principal
//   Girar    -> uma edição secundária
//   Info     -> os metadados da foto, acessório
//
// ! Os quatro são `IconButton` padrão: sem fundo, mesma cor, mesmo tamanho. A
// ! barra inteira tem um peso só, e o "Salvar" — que é o motivo de a tela
// ! existir — não se distingue de "Info".
//
// ? Nos botões de texto a régua tinha quatro degraus (filled, tonal, outlined,
// ? text). Um botão de ícone só teria um?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: VariantesMaterial3()));

class VariantesMaterial3 extends StatelessWidget {
  const VariantesMaterial3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editor de fotos')),
      body: Center(
        child: Wrap(
          spacing: 24,
          runSpacing: 24,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.check),
              tooltip: 'Salvar',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.crop),
              tooltip: 'Recortar',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.rotate_right),
              tooltip: 'Girar',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.info_outline),
              tooltip: 'Informações',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
