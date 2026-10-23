import 'package:flutter/material.dart';

// * Os destinos principais do app declarados uma vez só.
// * A barra de baixo e o menu lateral leem daqui, então é impossível eles
// * saírem de sincronia — e a ordem do enum é a ordem das telas no IndexedStack.
enum Destino {
  inicio(rotulo: 'Início', icone: Icons.home_outlined, iconeAtivo: Icons.home),
  tarefas(
    rotulo: 'Tarefas',
    icone: Icons.list_alt_outlined,
    iconeAtivo: Icons.list_alt,
  ),
  perfil(
    rotulo: 'Perfil',
    icone: Icons.person_outline,
    iconeAtivo: Icons.person,
  );

  const Destino({
    required this.rotulo,
    required this.icone,
    required this.iconeAtivo,
  });

  final String rotulo;
  final IconData icone;

  // O par outline/filled: o ícone preenchido marca o destino ativo.
  final IconData iconeAtivo;
}
