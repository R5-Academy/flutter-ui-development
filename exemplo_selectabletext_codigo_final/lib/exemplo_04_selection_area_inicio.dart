// exemplo_04_selection_area_inicio.dart
// Ponto de partida: uma ficha de produto em que TODOS os textos já são
// SelectableText.
//
// ! Cada um seleciona SOZINHO. Tente arrastar do título até o rodapé: a seleção
// ! para na borda do primeiro widget. São três ilhas independentes.
//
// Medido em telas de 360, 400, 800 e 1280 px: arrastando do título ao rodapé,
// só o onSelectionChanged do TÍTULO dispara. Os outros dois nunca são chamados.
//
// Para copiar a ficha inteira, o usuário teria que selecionar e copiar três
// vezes. Isso não é o que ninguém espera de uma página.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoSelectionArea()));

class DemoSelectionArea extends StatelessWidget {
  const DemoSelectionArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SelectionArea')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SelectionArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fone Bluetooth XZ-90',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade900,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Cancelamento de ruído ativo, 30 horas de bateria e conexão '
                'multiponto para trocar entre o celular e o notebook.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 16),
              Text(
                'SKU: XZ90-BLK  ·  Garantia: 12 meses',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
