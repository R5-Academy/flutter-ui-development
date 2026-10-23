// exemplo_04_choice_chip_inicio.dart
// Ponto de partida: a escolha de tamanho de uma camiseta, resolvida com o
// `FilterChip` que acabamos de aprender. Funciona: marca, desmarca, mostra o
// check.
//
// ! Marque P. Agora marque M. Agora G. Os três ficam marcados ao mesmo tempo,
// ! e o rodapé anuncia "Tamanho: P, M, G".
//
// ? Qual camiseta seria enviada?
//
// O widget não está errado — o ESTADO está. Um `Set` diz "vários podem estar
// marcados", e é exatamente isso que a tela faz.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: EscolhaTamanho()));

class EscolhaTamanho extends StatefulWidget {
  const EscolhaTamanho({super.key});

  @override
  State<EscolhaTamanho> createState() => _EscolhaTamanhoState();
}

class _EscolhaTamanhoState extends State<EscolhaTamanho> {
  static const _tamanhos = ['P', 'M', 'G', 'GG'];

  var _selecionado = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tamanho')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Escolha o tamanho:'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                for (final tamanho in _tamanhos)
                  ChoiceChip(
                    label: Text(tamanho),
                    selected: _selecionado == tamanho,
                    onSelected: (marcado) {
                      setState(() {
                        if (marcado) {
                          _selecionado = tamanho;
                        } else {
                          _selecionado = '';
                        }
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Tamanho: $_selecionado',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
