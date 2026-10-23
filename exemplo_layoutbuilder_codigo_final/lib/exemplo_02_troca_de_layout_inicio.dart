// exemplo_02_troca_de_layout_inicio.dart
// Ponto de partida: avatar em cima, texto embaixo. Sempre.
//
// No celular está ótimo. Rode no desktop ou na web e alargue a janela: o avatar
// continua sozinho no topo, com um oceano de espaço vazio ao lado dele.
//
// Já sabemos LER as constraints. Agora vamos DECIDIR com elas.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaTrocaDeLayout()));

class TelaTrocaDeLayout extends StatelessWidget {
  const TelaTrocaDeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trocar layout conforme a largura')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (_, constrains) {
            if (constrains.maxWidth > 600) {
              return Row(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _Avatar(),
                  SizedBox(height: 20),
                  Flexible(child: _TextoDoPerfil()),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [_Avatar(), SizedBox(height: 20), _TextoDoPerfil()],
            );
          },
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.teal.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.person, size: 56, color: Colors.teal),
    );
  }
}

class _TextoDoPerfil extends StatelessWidget {
  const _TextoDoPerfil();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Rodrigo Rahman',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Este avatar fica em cima do texto sempre — não importa se a janela '
          'tem 400 ou 1400px de largura.',
        ),
      ],
    );
  }
}
