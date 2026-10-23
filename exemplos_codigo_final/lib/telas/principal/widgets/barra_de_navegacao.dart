import 'package:flutter/material.dart';

import '../../../modelos/destino.dart';

// * A barra de baixo não guarda estado nenhum: ela recebe qual destino está
// * ativo e avisa quando outro é tocado. Quem chama o setState é a TelaPrincipal.
class BarraDeNavegacao extends StatelessWidget {
  const BarraDeNavegacao({
    super.key,
    required this.destinoAtivo,
    required this.aoSelecionarDestino,
  });

  final Destino destinoAtivo;
  final ValueChanged<Destino> aoSelecionarDestino;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: destinoAtivo.index,
      onDestinationSelected: (int indice) =>
          aoSelecionarDestino(Destino.values[indice]),
      destinations: [
        for (final Destino destino in Destino.values)
          NavigationDestination(
            icon: Icon(destino.icone),
            selectedIcon: Icon(destino.iconeAtivo),
            label: destino.rotulo,
          ),
      ],
    );
  }
}
