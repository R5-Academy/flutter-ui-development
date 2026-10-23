// painel_diagnostico.dart
// A bancada compartilhada pelos exemplos do bloco 1.
//
// Ela existe para deixar VISÍVEL o que normalmente só aparece em comentário:
// a altura que o ListView recebeu do pai. É esse número que decide tudo —
// altura infinita obriga o ListView a medir o conteúdo inteiro, e medir é
// construir.

import 'package:flutter/material.dart';

const double kAlturaItem = 80.0;
const int kTotal = 500;

/// Junta o que a tela quer provar e publica de uma vez só, depois do primeiro
/// frame — assim o painel não fica trocando de número enquanto a lista constrói.
class Diagnostico {
  Diagnostico({required this.quemFazARolagem});

  /// Quem responde pelo gesto de arrastar: a própria lista ou um pai rolável.
  /// No passo 2 a lista tem o tamanho exato do conteúdo, então não sobra
  /// distância nenhuma para percorrer — quem assume é o widget de fora.
  final String quemFazARolagem;

  final pronto = ValueNotifier<bool>(false);
  final _relogio = Stopwatch();

  double alturaRecebida = double.nan;
  int construidos = 0;
  int msPrimeiroFrame = 0;
  bool _congelado = false;

  /// Chame no `initState`.
  void comecar() {
    _relogio.start();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _relogio.stop();
      msPrimeiroFrame = _relogio.elapsedMilliseconds;
      _congelado = true;
      pronto.value = true;
    });
  }

  /// Chame no `build` de cada item.
  void registrarItem() {
    if (_congelado) return;
    construidos++;
  }

  void descartar() => pronto.dispose();
}

/// O placar. Fica ACIMA da lista, para o número ficar à vista durante a aula.
class PainelDiagnostico extends StatelessWidget {
  const PainelDiagnostico({super.key, required this.diagnostico});

  final Diagnostico diagnostico;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: diagnostico.pronto,
      builder: (context, pronto, _) {
        final altura = diagnostico.alturaRecebida;
        final infinita = altura.isInfinite;
        // * A cor sai do MECANISMO, não do resultado: vermelho quando a altura
        // * que desceu é infinita, verde quando é finita.
        final cor = infinita ? Colors.red.shade100 : Colors.green.shade100;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: pronto ? cor : Colors.grey.shade200,
          child: DefaultTextStyle(
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: Colors.black87,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Linha(
                  rotulo: 'altura que o ListView recebeu',
                  valor: !pronto
                      ? '...'
                      : infinita
                      ? 'INFINITA'
                      : '${altura.toStringAsFixed(1)} px',
                  destaque: true,
                ),
                const SizedBox(height: 4),
                _Linha(rotulo: 'itens declarados', valor: '$kTotal'),
                _Linha(
                  rotulo: 'construídos no 1o frame',
                  valor: pronto ? '${diagnostico.construidos}' : '...',
                  destaque: true,
                ),
                _Linha(
                  rotulo: 'custo do 1o frame',
                  valor: pronto ? '${diagnostico.msPrimeiroFrame} ms' : '...',
                ),
                _Linha(
                  rotulo: 'quem faz a rolagem',
                  valor: diagnostico.quemFazARolagem,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Linha extends StatelessWidget {
  const _Linha({
    required this.rotulo,
    required this.valor,
    this.destaque = false,
  });

  final String rotulo;
  final String valor;
  final bool destaque;

  @override
  Widget build(BuildContext context) {
    final estilo = TextStyle(
      fontWeight: destaque ? FontWeight.bold : FontWeight.normal,
    );
    return Row(
      children: [
        SizedBox(width: 260, child: Text('$rotulo ', style: estilo)),
        Expanded(child: Text(valor, style: estilo)),
      ],
    );
  }
}

/// O item da lista. Avisa o diagnóstico toda vez que é construído.
class ItemDaLista extends StatelessWidget {
  const ItemDaLista({
    super.key,
    required this.indice,
    required this.diagnostico,
  });

  final int indice;
  final Diagnostico diagnostico;

  @override
  Widget build(BuildContext context) {
    diagnostico.registrarItem();
    return SizedBox(
      height: kAlturaItem,
      child: ListTile(
        leading: CircleAvatar(child: Text('$indice')),
        title: Text('Item $indice'),
      ),
    );
  }
}

/// Mede a altura que chega ao filho e anota no diagnóstico.
///
/// É um `LayoutBuilder` com uma anotação: ele entrega ao filho exatamente as
/// mesmas constraints que receberia sem ele, então não muda o que a tela prova.
class EspiaoDeAltura extends StatelessWidget {
  const EspiaoDeAltura({
    super.key,
    required this.diagnostico,
    required this.builder,
  });

  final Diagnostico diagnostico;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        diagnostico.alturaRecebida = constraints.maxHeight;
        return builder(context);
      },
    );
  }
}
