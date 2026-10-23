// exemplo_02_lados_e_minimum_inicio.dart
// Ponto de partida: o SafeArea no padrão — os quatro lados protegidos.
//
// * A faixa roxa em volta da área branca é o padding que o SafeArea aplicou.
// * Por padrão, `top`, `bottom`, `left` e `right` são todos `true`.
//
// Só que nem sempre você quer proteger os quatro. Uma imagem de topo, por
// exemplo, costuma ir até a beirada de propósito.
//
// ! Este painel injeta um MediaQuery com um padding fictício, e por dois motivos
// ! medidos: (1) um Scaffold COM AppBar remove o padding do topo do MediaQuery
// ! que desce para o body (`material/scaffold.dart:3030`) — medido: 44 acima do
// ! Scaffold, 0 dentro do body; (2) emulador sem notch, Chrome e desktop
// ! reportam padding ZERO, e nenhuma faixa apareceria. Com o padding injetado, o
// ! painel fica igual em qualquer tela. O número REAL, vindo do aparelho, é o do
// ! `exemplo_01`.

import 'package:flutter/material.dart';

void main() => runApp(const AppLadosMinimum());

class AppLadosMinimum extends StatelessWidget {
  const AppLadosMinimum({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaLadosMinimum(),
    );
  }
}

class TelaLadosMinimum extends StatelessWidget {
  const TelaLadosMinimum({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lados e minimum')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          _Aviso(),
          _Painel(
            rotulo: 'padrão: os quatro lados true — faixa 8/44/8/34',
            child: SafeArea(child: _Conteudo()),
          ),

          _Painel(
            rotulo: 'Top: false',
            child: SafeArea(top: false, child: _Conteudo()),
          ),
          _Painel(
            rotulo: 'bottom: false',
            child: SafeArea(bottom: false, child: _Conteudo()),
          ),

          _Painel(
            rotulo:
                'minium: .all(24) - laterais viram 24; top/base seguem'
                ' com 44/34',
            child: SafeArea(
              // O minium precisa ser maior que o padding do device
              minimum: .all(24),
              child: _Conteudo(),
            ),
          ),
        ],
      ),
    );
  }
}

class _Aviso extends StatelessWidget {
  const _Aviso();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        'O painel finge ser um aparelho com padding '
        '${_Painel.legendaDoPadding}.\n'
        'A faixa roxa é o que o SafeArea reservou; o branco é a área segura.',
        style: TextStyle(fontSize: 12, height: 1.4),
      ),
    );
  }
}

// O painel tem altura fixa e fundo roxo; o SafeArea de dentro recorta a área
// branca, então a faixa roxa que sobra é o padding aplicado.
class _Painel extends StatelessWidget {
  const _Painel({required this.rotulo, required this.child});

  final String rotulo;
  final Widget child;

  // * O padding de um aparelho fictício: 44 no topo (status bar + notch), 34
  // * embaixo (barra de gestos) e 8 nas laterais (cantos arredondados).
  static const paddingFicticio = EdgeInsets.fromLTRB(8, 44, 8, 34);
  static const legendaDoPadding = 'left 8, top 44, right 8, bottom 34';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rotulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 110,
            child: ColoredBox(
              color: const Color(0xFF6750A4),
              // * É daqui que o SafeArea do painel lê o padding. Trocar só o
              // * campo `padding` com copyWith preserva o resto do MediaQuery
              // * (textScaler, tamanho, viewInsets).
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(padding: paddingFicticio),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Conteudo extends StatelessWidget {
  const _Conteudo();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.white,
      child: Center(child: Text('área segura')),
    );
  }
}
