import 'package:flutter/material.dart';

import '../telas/principal/tela_principal.dart';
import 'tema/tema_do_app.dart';

// * A raiz do app: instala o MaterialApp (Navigator, Overlay, Theme) e aponta
// * para a tela principal. Nenhuma regra de aparência mora aqui — tudo vem do
// * TemaDoApp.
class MinhaApp extends StatelessWidget {
  const MinhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha App',
      debugShowCheckedModeBanner: false,
      theme: TemaDoApp.claro,
      home: const TelaPrincipal(),
    );
  }
}
