import 'package:flutter/material.dart';

// * As cores da marca em um lugar só. Nenhum widget escreve um 0xFF... na mão:
// * quem precisa de cor pega daqui ou do Theme.of(context).
abstract final class CoresDoApp {
  static const azul = Color(0xFF1565D8);
  static const verde = Color(0xFF1FA24A);
  static const roxo = Color(0xFF8B5CF6);

  static const fundo = Color(0xFFF4F5F7);
  static const borda = Color(0xFFE3E5E9);
  static const textoSecundario = Color(0xFF6B7280);

  // Tons da paisagem do topo da tela inicial.
  static const ceuTopo = Color(0xFFCFE4FA);
  static const ceuBase = Color(0xFFEAF2FC);
  static const sol = Color(0xFFF6C445);
  static const montanhaClara = Color(0xFF7BA7DC);
  static const montanhaEscura = Color(0xFF3E6EA8);
}
