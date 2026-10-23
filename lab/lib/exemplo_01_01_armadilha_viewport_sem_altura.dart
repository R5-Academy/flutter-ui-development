// exemplo_01_01_armadilha_viewport_sem_altura.dart
// PASSO 1 DE 4 — rode este primeiro.
//
// ! ESTE ARQUIVO QUEBRA DE PROPÓSITO.
//
// Um cabeçalho e uma lista, empilhados numa Column. Parece a coisa mais
// natural do mundo, e é o layout que todo app tem.
//
// ! O erro:
// !
// !   Vertical viewport was given unbounded height.
//
// A Column mede os filhos um por um, e para cada um ela pergunta "de que
// tamanho você quer ser?" — sem impor teto nenhum na vertical. Ou seja: ela
// manda altura INFINITA para baixo.
//
// O ListView não consegue trabalhar com isso. Ele é uma janela que mostra um
// pedaço de um conteúdo maior, e uma janela de altura infinita não é uma
// janela: não existe "o que cabe" nem "o quanto dá para rolar".
//
// Por isso ele não tenta adivinhar — ele para e reclama.
//
// Os próximos três arquivos são as duas saídas para isto: a que a internet dá
// (exemplo_01_02_shrinkwrap_inicio) e a certa (exemplo_01_02_shrinkwrap_completo).

import 'package:material_ui/material_ui.dart';

import 'painel_diagnostico.dart';

void main() => runApp(const AppShrinkErrado());

class AppShrinkErrado extends StatelessWidget {
  const AppShrinkErrado({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView dentro de Column',
      theme: ThemeData(colorSchemeSeed: Colors.orange),
      home: const TelaQuebra(),
    );
  }
}

class TelaQuebra extends StatelessWidget {
  const TelaQuebra({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isto quebra')),
      body: Column(
        children: [
          const _Cabecalho(),
          // ! ESTA LINHA EXPLODE.
          // ! A Column não impôs teto de altura; o ListView precisa de um.
          ListView.builder(
            itemCount: kTotal,
            itemBuilder: (context, index) => SizedBox(
              height: kAlturaItem,
              child: ListTile(
                leading: CircleAvatar(child: Text('$index')),
                title: Text('Item $index'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Cabecalho extends StatelessWidget {
  const _Cabecalho();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.orange.shade100,
      child: const Text('Destaques da semana'),
    );
  }
}
