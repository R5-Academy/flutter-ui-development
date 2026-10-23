// exemplo_01_sem_scaffold.dart
// Demonstra: como uma tela fica quando não existe moldura nenhuma.
// É o gancho da aula: rode isto primeiro e deixe a turma reagir.

import 'package:flutter/material.dart';

void main() => runApp(const AppSemMoldura());

class AppSemMoldura extends StatelessWidget {
  const AppSemMoldura({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sem Scaffold',
      // Troque o home pelas outras telas deste arquivo para comparar ao vivo.
      home: TelaComMaterialPuro(),
    );
  }
}

class TelaSemMoldura extends StatelessWidget {
  const TelaSemMoldura({super.key});

  @override
  Widget build(BuildContext context) {
    // ! Texto vermelho gigante, monoespaçado, com sublinhado duplo amarelo.
    // ! Não é bug: o MaterialApp instala esse estilo de propósito como
    // ! DefaultTextStyle do app inteiro, para você notar que falta um Material.
    // O fundo preto tem outra causa: sem Material, ninguém pintou o fundo da tela.
    return const Center(child: Text('Cadê a moldura?'));
  }
}

// * Segundo passo da demonstração: um Material puro já conserta o TEXTO...
// * ...mas continua não sendo uma tela (sem appBar, sem slots, sem coordenação).
class TelaComMaterialPuro extends StatelessWidget {
  const TelaComMaterialPuro({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: const Center(child: Text('Texto legível, mas sem moldura')),
    );
  }
}
