// exemplo_03_filter_chip_inicio.dart
// Ponto de partida: a barra de filtros de uma loja. As cinco categorias estão
// na tela, bonitas e alinhadas.
//
// ! E completamente inertes. Toque em "Tênis": nada — nem sequer o efeito de
// ! toque. O `Chip` é um rótulo: ele exibe informação e não responde ao toque no
// ! corpo. Não existe `selected` nem `onPressed` nele; o único callback é o
// ! `onDeleted`, e ele só vale para o "x".
//
// Um filtro precisa de duas coisas que faltam aqui: saber se está marcado e
// avisar quando o usuário mudar isso. Existe uma variante do Chip para
// exatamente esse par.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: FiltroCategorias()));

class FiltroCategorias extends StatelessWidget {
  const FiltroCategorias({super.key});

  static const _categorias = [
    'Camisetas',
    'Calças',
    'Tênis',
    'Acessórios',
    'Bolsas',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filtros')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filtrar por categoria:'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final categoria in _categorias)
                  Chip(label: Text(categoria)),
              ],
            ),
            const SizedBox(height: 24),
            // ! Fixo: não há o que refletir, porque não há seleção.
            const Text(
              'Nenhum filtro ativo',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
