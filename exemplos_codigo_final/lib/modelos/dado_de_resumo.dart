import 'package:flutter/material.dart';

// Um número do painel da tela inicial: o ícone, a cor, o valor e o rótulo.
class DadoDeResumo {
  const DadoDeResumo({
    required this.icone,
    required this.cor,
    required this.valor,
    required this.rotulo,
  });

  final IconData icone;
  final Color cor;
  final String valor;
  final String rotulo;
}
