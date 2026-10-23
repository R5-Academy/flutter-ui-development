// exemplo_01_02_shrinkwrap_inicio.dart
// PASSO 2 DE 4 — a correção que a internet dá.
//
// A mesma tela do exemplo_01_01_armadilha_viewport_sem_altura.dart, agora com
// a resposta que aparece em primeiro lugar quando você pesquisa o erro:
//
//   shrinkWrap: true
//
// O QUE A FLAG FAZ, na frase da própria documentação: em vez de ocupar o
// espaço disponível no eixo do scroll, a lista passa a "encolher até o tamanho
// do conteúdo".
//
// ! E é aí que está a conta. Para encolher até o tamanho do conteúdo, ela
// ! precisa saber qual é o tamanho do conteúdo. Para saber o tamanho, ela
// ! precisa MEDIR os 500 itens. E medir um item é CONSTRUIR o item.
//
// Duas consequências, e as duas estão no painel:
//
//   1. os 500 itens nascem no primeiro frame — o lazy morreu, em silêncio,
//      sem erro nenhum;
//   2. a lista deixa de ter rolagem própria: com o tamanho exato do
//      conteúdo, não sobra distância nenhuma para percorrer. Quem assume o
//      gesto é o SingleChildScrollView que teve de entrar por fora — e é ele
//      que manda a altura infinita que aparece no painel.
//
// Repare que a altura infinita NÃO sumiu. Ela continua ali: a flag só ensinou
// o ListView a conviver com ela, pagando o preço de construir tudo.

import 'package:material_ui/material_ui.dart';

import 'painel_diagnostico.dart';

void main() => runApp(const AppShrink());

class AppShrink extends StatelessWidget {
  const AppShrink({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shrinkWrap: true',
      theme: ThemeData(colorSchemeSeed: Colors.orange),
      home: const TelaShrink(),
    );
  }
}

class TelaShrink extends StatefulWidget {
  const TelaShrink({super.key});

  @override
  State<TelaShrink> createState() => _TelaShrinkState();
}

class _TelaShrinkState extends State<TelaShrink> {
  final _diagnostico = Diagnostico(quemFazARolagem: 'o pai (SingleChildScrollView)');

  @override
  void initState() {
    super.initState();
    _diagnostico.comecar();
  }

  @override
  void dispose() {
    _diagnostico.descartar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('shrinkWrap: true')),
      // O gesto de arrastar é atendido por este SingleChildScrollView, e
      // não mais pela lista.
      body: SingleChildScrollView(
        child: Column(
          children: [
            PainelDiagnostico(diagnostico: _diagnostico),
            EspiaoDeAltura(
              diagnostico: _diagnostico,
              builder: (context) => ListView.builder(
                // A flag que fez o erro sumir — e levou o lazy junto.
                shrinkWrap: true,
                // Sem isto, dois roláveis no mesmo eixo brigam pelo gesto.
                physics: const NeverScrollableScrollPhysics(),
                itemCount: kTotal,
                itemBuilder: (context, index) =>
                    ItemDaLista(indice: index, diagnostico: _diagnostico),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
