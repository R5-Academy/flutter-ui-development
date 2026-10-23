// exemplo_05_herotag_armadilha_inicio.dart
// Ponto de partida: dois FABs na mesma tela — compartilhar e adicionar.
//
// Rode. A tela abre, os dois botões aparecem, os dois respondem ao toque.
// Nenhum erro no console. Está tudo certo?
//
// ! Agora toque em "Ver detalhes", que navega para outra tela. O app QUEBRA:
// !
// !     There are multiple heroes that share the same tag within a subtree.
// !     In this case, multiple heroes had the following tag:
// !     <default FloatingActionButton tag>
// !
// ! Essa é a pior categoria de bug: não acontece onde você escreveu o código,
// ! acontece **em outro lugar, mais tarde**. Passa em qualquer revisão de tela
// ! e só aparece quando alguém navega.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: HeroTagArmadilha()));

class HeroTagArmadilha extends StatelessWidget {
  const HeroTagArmadilha({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dois FABs')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const _TelaDeDetalhes()),
          ),
          child: const Text('Ver detalhes'),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Compartilhar',
            child: const Icon(Icons.share),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Adicionar',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class _TelaDeDetalhes extends StatelessWidget {
  const _TelaDeDetalhes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      body: const Center(child: Text('Você chegou aqui?')),
    );
  }
}
