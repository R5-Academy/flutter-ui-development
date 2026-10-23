// exemplo_04_preco_inicio.dart
// Ponto de partida: o preço num Text só, com um tamanho único.
//
// ! Cifrão, reais e centavos saem todos em 40. Fica pesado, e o número perde a
// ! leitura rápida que todo e-commerce usa: o VALOR grande, o resto pequeno.
//
// Este é um caso em que só o RichText resolve — o preço precisa ser uma única
// "palavra" visual, com tamanhos diferentes por pedaço.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: DemoPreco()));

class DemoPreco extends StatelessWidget {
  const DemoPreco({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text.rich(
          TextSpan(
            style: TextStyle(
              color: Colors.green.shade800,
              fontWeight: FontWeight.w900,
            ),
            children: [
              TextSpan(text: r'R$', style: TextStyle(fontSize: 16)),
              TextSpan(text: '90', style: TextStyle(fontSize: 40)),
              TextSpan(text: '.90', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        // child: Text(
        //   r'R$ 90,90',
        //   style: TextStyle(
        //     fontSize: 40,
        //     color: Colors.green.shade800,
        //     fontWeight: FontWeight.w900,
        //   ),
        // ),
      ),
    );
  }
}
