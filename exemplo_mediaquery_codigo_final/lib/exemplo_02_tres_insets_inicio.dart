// exemplo_02_tres_insets_inicio.dart
// Ponto de partida: o `padding` do MediaQuery — a safe area efetiva. Usamos ele
// para afastar o botão "Continuar" da barra de gestos do aparelho.
//
// Toque no campo para abrir o teclado e olhe DUAS coisas ao mesmo tempo:
//
// ! 1. o número: `padding.bottom` vai a ZERO.
// ! 2. o botão: ele desce e fica ATRÁS do teclado.
//
// ! Isso costuma pegar todo mundo de surpresa. Por que a safe area de baixo sumiu
// ! justamente quando o teclado apareceu? E com que número o botão escapa dele?
//
// A resposta exige conhecer os outros dois EdgeInsets do MediaQuery.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: RaioXDosInsets()));

class RaioXDosInsets extends StatelessWidget {
  const RaioXDosInsets({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final viewPadding = MediaQuery.viewPaddingOf(context);

    // ! resizeToAvoidBottomInset: false para o teclado NÃO reposicionar a tela
    // ! sozinho e a gente enxergar os números mudando sem interferência.
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Raio-X dos insets')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _LinhaInset(
                  nome: 'padding',
                  insets: padding,
                  cor: Colors.green,
                ),
                const SizedBox(height: 24),
                _LinhaInset(
                  nome: 'viewInsets',
                  insets: viewInsets,
                  cor: Colors.blue,
                ),
                const SizedBox(height: 24),
                _LinhaInset(
                  nome: 'viewPadding',
                  insets: viewPadding,
                  cor: Colors.red,
                ),
                const Text(
                  'Toque no campo abaixo para abrir o teclado e veja o número '
                  'mudar:',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'foque aqui',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          // A safe area afasta o botão da barra de gestos — enquanto o teclado
          // está fechado.
          _Rodape(afastamento: padding.bottom),
        ],
      ),
    );
  }
}

class _Rodape extends StatelessWidget {
  const _Rodape({required this.afastamento});

  final double afastamento;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.withValues(alpha: 0.12),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 12 + afastamento,
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Continuar'),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'afastamento de baixo: ${afastamento.toStringAsFixed(0)} px',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _LinhaInset extends StatelessWidget {
  const _LinhaInset({
    required this.nome,
    required this.insets,
    required this.cor,
  });

  final String nome;
  final EdgeInsets insets;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    String n(double valor) => valor.toStringAsFixed(0);

    return Card(
      color: cor.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nome,
              style: TextStyle(fontWeight: FontWeight.bold, color: cor),
            ),
            const SizedBox(height: 4),
            Text(
              'top: ${n(insets.top)}   bottom: ${n(insets.bottom)}   '
              'left: ${n(insets.left)}   right: ${n(insets.right)}',
            ),
          ],
        ),
      ),
    );
  }
}
