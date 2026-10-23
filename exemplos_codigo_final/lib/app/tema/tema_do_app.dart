import 'package:flutter/material.dart';

import 'cores_do_app.dart';

// * Todo o visual do app definido de uma vez: AppBar, Drawer, barra inferior,
// * cartões e itens de lista. Nenhuma tela repete cor, altura ou formato — é a
// * mesma ideia do AppBarTheme, do DrawerThemeData e do NavigationBarThemeData
// * que vimos nas aulas da seção.
abstract final class TemaDoApp {
  static ThemeData get claro {
    final ColorScheme cores = .fromSeed(seedColor: CoresDoApp.azul);

    return ThemeData(
      colorScheme: cores,
      scaffoldBackgroundColor: CoresDoApp.fundo,

      // A AppBar do Material 3 nasce quase branca. O app tem barra azul, então
      // a cor é definida aqui uma vez, e não em cada tela.
      appBarTheme: const AppBarTheme(
        backgroundColor: CoresDoApp.azul,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: .w600,
          color: Colors.white,
        ),
      ),

      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
        // Canto reto: o arredondado padrão do M3 não combina com este layout.
        shape: RoundedRectangleBorder(),
      ),

      // Vale para os itens do menu lateral e para qualquer ListTile do app:
      // o item ativo ganha a pílula azul clara.
      listTileTheme: ListTileThemeData(
        selectedColor: CoresDoApp.azul,
        selectedTileColor: CoresDoApp.azul.withValues(alpha: 0.10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: CoresDoApp.azul.withValues(alpha: 0.12),
        labelBehavior: .alwaysShow,
      ),

      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: CoresDoApp.borda),
        ),
      ),

      dividerTheme: const DividerThemeData(color: CoresDoApp.borda),
    );
  }
}
