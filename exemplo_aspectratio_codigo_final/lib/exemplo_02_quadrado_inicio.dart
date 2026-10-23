// exemplo_02_quadrado_inicio.dart
// Ponto de partida: a mesma ideia do bloco 1, trocando só o formato.
// aspectRatio 1/1 = quadrado. A proporção é genérica: quadrado, retrato,
// paisagem — é sempre largura / altura.
//
// ! Só que o quadrado ficou ENORME. O AspectRatio tenta a MAIOR largura
// ! possível e só recua se a altura resultante não couber. Aqui ele recebeu a
// ! tela inteira, então o resultado é o maior quadrado que cabe nela: num
// ! celular em pé ele para na largura (a altura sobra); numa janela de desktop
// ! deitada ele para na altura (a largura sobra).

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaQuadrado()));

class TelaQuadrado extends StatelessWidget {
  const TelaQuadrado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AspectRatio 1/1')),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 260),
            child: AspectRatio(
              // * 1 / 1 = 1.0. Largura igual à altura: sempre quadrado,
              // qualquer que seja a largura disponível.
              aspectRatio: 1 / 1,
              child: _Miniatura(),
            ),
          ),
        ),
      ),
    );
  }
}

class _Miniatura extends StatelessWidget {
  const _Miniatura();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple),
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.image, color: Colors.deepPurple, size: 48),
    );
  }
}
