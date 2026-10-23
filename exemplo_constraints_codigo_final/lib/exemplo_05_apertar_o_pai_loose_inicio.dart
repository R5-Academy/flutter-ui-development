// exemplo_05_apertar_o_pai_loose_inicio.dart
// Ponto de partida: o problema inverso do exemplo 04.
//
// Agora o pai é FROUXO (loose): ele deixa o filho escolher. E o filho escolhe
// mal — cada cartão fica do tamanho do próprio texto, então os dois saem com
// larguras diferentes e a tela fica torta. Não tem bug nenhum aqui: com folga,
// quem decide o tamanho é o filho, e o Container sem width escolhe o tamanho do
// conteúdo.
//
// * A pergunta: que widget eu ponho ENTRE o pai e o cartão para APERTAR, ou
// * seja, para transformar a constraint frouxa em tight e fixar os dois em
// * 220x48?

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TelaApertarPaiLoose()));

// Encurta o número para caber na legenda do cartão (300.0 vira 300).
String _n(double valor) =>
    valor == double.infinity ? 'inf' : valor.toStringAsFixed(0);

// O filho da história: sem tamanho próprio, ele fica do tamanho do conteúdo.
// A legenda mostra a constraint de largura que chegou até aqui.
class _Cartao extends StatelessWidget {
  const _Cartao(this.rotulo);

  final String rotulo;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          color: Colors.indigo,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // O texto pede a largura inteira dele. Quando sobra folga, é esse
              // pedido que define a largura do cartão — por isso rótulos
              // diferentes dão cartões diferentes.
              Text(
                rotulo,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'w ${_n(constraints.minWidth)}..${_n(constraints.maxWidth)} '
                '${constraints.isTight ? 'TIGHT' : 'LOOSE'}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white70, fontSize: 9),
              ),
            ],
          ),
        );
      },
    );
  }
}

// O pai frouxo: reserva 300x60 e deixa o filho escolher dentro disso.
class _PaiLoose extends StatelessWidget {
  const _PaiLoose({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey.shade300,
      child: SizedBox(
        width: 300,
        height: 60,
        // * O Align afrouxa o que o SizedBox apertou: o filho recebe
        // * w 0..300, h 0..60. É a situação do exemplo 04 já resolvida.
        child: Align(alignment: Alignment.centerLeft, child: child),
      ),
    );
  }
}

// Só o rótulo em cima do caso, para a tela ficar legível.
class _Caso extends StatelessWidget {
  const _Caso({required this.titulo, required this.child});

  final String titulo;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class TelaApertarPaiLoose extends StatelessWidget {
  const TelaApertarPaiLoose({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('O pai é loose. E agora?')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'O pai deixa escolher (w 0..300) e cada cartão escolhe o tamanho '
            'do próprio texto. Como fixar os dois em 220x48?',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          _Caso(
            titulo: 'O problema: larguras diferentes, tela torta',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PaiLoose(child: _Cartao('Salvar')),
                SizedBox(height: 8),
                _PaiLoose(child: _Cartao('Cancelar pedido')),
              ],
            ),
          ),
          _Caso(
            titulo: 'O problema: larguras diferentes, tela torta',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PaiLoose(
                  child: SizedBox(
                    width: 220,
                    height: 48,
                    child: _Cartao('Salvar'),
                  ),
                ),
                SizedBox(height: 8),
                _PaiLoose(
                  child: SizedBox(
                    width: 220,
                    height: 48,
                    child: _Cartao('Cancelar pedido'),
                  ),
                ),
              ],
            ),
          ),

          _Caso(
            titulo: 'O problema: larguras diferentes, tela torta',
            child: _PaiLoose(
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(220, 48)),
                child: _Cartao('Salvar'),
              ),
            ),
          ),

          _Caso(
            titulo: 'O problema: larguras diferentes, tela torta',
            child: _PaiLoose(
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: _Cartao('Salvar'),
              ),
            ),
          ),

          _Caso(
            titulo: 'O problema: larguras diferentes, tela torta',
            child: _PaiLoose(child: SizedBox.expand(child: _Cartao('Salvar'))),
          ),

          _Caso(
            titulo: 'O problema: larguras diferentes, tela torta',
            child: _PaiLoose(
              child: SizedBox(width: 400, height: 48, child: _Cartao('Salvar')),
            ),
          ),
        ],
      ),
    );
  }
}
