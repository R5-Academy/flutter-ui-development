// exemplo_06_scaffold_of_armadilha.dart
// Demonstra: a armadilha clássica do Scaffold.of(context) e as três saídas.
// Novo em relação ao 05: aqui não é layout, é ÁRVORE — o mesmo erro de
// BuildContext que já vimos, agora com um widget de verdade.
//
// Roteiro: rode como está, toque no botão e leia o erro no console.
// Depois troque o `home` do MaterialApp pelas outras telas deste arquivo.

import 'package:flutter/material.dart';

void main() => runApp(const AppArmadilha());

class AppArmadilha extends StatelessWidget {
  const AppArmadilha({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Scaffold.of',
      // Troque por: TelaComBuilder(), TelaComFilhoExtraido() ou TelaComGlobalKey().
      home: TelaComBuilder(),
    );
  }
}

// ! ERRADO — compila, mas quebra quando o botão é tocado.
class TelaContextErrado extends StatelessWidget {
  const TelaContextErrado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(child: Center(child: Text('menu'))),
      endDrawer: const Drawer(child: Center(child: Text('menu End'))),
      body: Center(
        child: ElevatedButton(
          // ! Este `context` é o da TelaContextErrado, que está ACIMA do Scaffold
          // ! que este mesmo build acabou de retornar. Como Scaffold.of só olha
          // ! para os ancestrais, ele nunca encontra o Scaffold daqui de baixo.
          onPressed: () => Scaffold.of(context).openDrawer(),
          child: const Text('Abrir menu'),
        ),
      ),
    );
  }
}

// * SAÍDA 1 — Builder: a mais simples.
class TelaComBuilder extends StatelessWidget {
  const TelaComBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const Drawer(child: Center(child: Text('menu'))),
      endDrawer: const Drawer(child: Center(child: Text('menu End'))),
      body: Center(
        // O Builder cria um novo BuildContext, agora ABAIXO do Scaffold.
        child: Builder(
          builder: (BuildContext contextInterno) {
            return Row(
              children: [
                ElevatedButton(
                  onPressed: () => Scaffold.of(contextInterno).openDrawer(),
                  child: const Text('Abrir menu (Builder)'),
                ),
                ElevatedButton(
                  onPressed: () => Scaffold.of(contextInterno).openEndDrawer(),
                  child: const Text('Open End(Builder)'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// * SAÍDA 2 — extrair um widget filho: a preferida pelo time do Flutter.
class TelaComFilhoExtraido extends StatelessWidget {
  const TelaComFilhoExtraido({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: Drawer(child: Center(child: Text('menu'))),
      body: Center(child: _BotaoAbrirMenu()),
    );
  }
}

class _BotaoAbrirMenu extends StatelessWidget {
  const _BotaoAbrirMenu();

  @override
  Widget build(BuildContext context) {
    // Aqui o context já nasce abaixo do Scaffold: subir a árvore encontra ele.
    return ElevatedButton(
      onPressed: () => Scaffold.of(context).openDrawer(),
      child: const Text('Abrir menu (widget extraído)'),
    );
  }
}

// * SAÍDA 3 — GlobalKey<ScaffoldState>: acessa o State direto, sem context.
// É o mesmo mecanismo da aula de Keys, agora apontando para o ScaffoldState.
class TelaComGlobalKey extends StatefulWidget {
  const TelaComGlobalKey({super.key});

  @override
  State<TelaComGlobalKey> createState() => _TelaComGlobalKeyState();
}

class _TelaComGlobalKeyState extends State<TelaComGlobalKey> {
  // A key vive no State, criada fora do build, para não trocar a cada rebuild.
  final _chaveDoScaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _chaveDoScaffold,
      drawer: const Drawer(child: Center(child: Text('menu'))),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _chaveDoScaffold.currentState?.openDrawer(),
          child: const Text('Abrir menu (GlobalKey)'),
        ),
      ),
    );
  }
}
