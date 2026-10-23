import 'package:flutter/material.dart';

import '../../../modelos/dado_de_resumo.dart';
import 'item_de_resumo.dart';

// O painel branco com os números do app. O cartão não sabe quais são os
// números: recebe a lista pronta de quem o usa.
class CartaoDeResumo extends StatelessWidget {
  const CartaoDeResumo({super.key, required this.dados});

  final List<DadoDeResumo> dados;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const .symmetric(vertical: 20, horizontal: 8),
        child: Row(
          children: [
            for (final DadoDeResumo dado in dados)
              Expanded(child: ItemDeResumo(dado: dado)),
          ],
        ),
      ),
    );
  }
}
