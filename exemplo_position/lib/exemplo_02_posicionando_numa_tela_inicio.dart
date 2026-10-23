// exemplo_02_posicionando_numa_tela_inicio.dart
// Ponto de partida: uma tela de verdade, com as quatro caixas já no lugar —
// mas ninguém disse ONDE, dentro de cada caixa, o conteúdo deve ficar.
//
// O título e o preço colam no topo-esquerda. O bloco do meio já vem
// centralizado na horizontal (herança do Column), mas colado no topo. E o
// botão do rodapé ESTICA e toma a faixa inteira: sem um pai que afrouxe, ele
// recebe a constraint tight da caixa e não consegue ter o próprio tamanho.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaDetalheDoCurso()));

class TelaDetalheDoCurso extends StatelessWidget {
  const TelaDetalheDoCurso({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhe do curso')),
      body: const Column(
        // O stretch faz cada caixa ocupar a largura inteira da tela.
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Capa(),
          _LinhaDoPreco(),
          Expanded(child: _EstadoVazio()),
          _Rodape(),
        ],
      ),
    );
  }
}

// A capa do curso. O título deveria ficar no canto inferior esquerdo dela.
class _Capa extends StatelessWidget {
  const _Capa();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ColoredBox(
        color: Colors.deepPurple,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Flutter do Zero ao Deploy',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// A faixa do preço. O valor deveria ficar encostado à direita.
class _LinhaDoPreco extends StatelessWidget {
  const _LinhaDoPreco();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.grey.shade200),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'R\$ 149,90',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

// O miolo da tela, quando o aluno ainda não começou o curso.
// Esse bloco deveria ficar no meio do espaço livre, um pouco acima do centro.
class _EstadoVazio extends StatelessWidget {
  const _EstadoVazio();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.play_circle_outline, size: 64, color: Colors.grey),
        SizedBox(height: 12),
        Text(
          'Você ainda não começou este curso',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}

// O rodapé com a ação principal. O botão deveria ficar centralizado nele.
class _Rodape extends StatelessWidget {
  const _Rodape();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.grey.shade100),
        child: FilledButton(
          onPressed: () {},
          child: const Text('Começar agora'),
        ),
      ),
    );
  }
}
