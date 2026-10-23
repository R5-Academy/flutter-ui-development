// exemplo_04_afrouxar_o_pai_tight_inicio.dart
// Ponto de partida: agora não é mais para ENTENDER o problema, é para RESOLVER.
//
// O alvo pede 120x60 e saiu 280x130, porque o pai é um SizedBox de tamanho
// fixo: ele manda TIGHT e pronto. E dessa vez você NÃO pode mexer no pai — ele
// é de outra tela, de outro pacote, de outra equipe. O SizedBox nem tem um
// parâmetro para afrouxar.
//
// * A pergunta: que widget eu ponho ENTRE o pai e o alvo para afrouxar?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaAfrouxarPaiTight()));

// Encurta o número para caber dentro do bloco (280.0 vira 280).
String _n(double valor) =>
    valor == double.infinity ? 'inf' : valor.toStringAsFixed(0);

// O filho da história: ele pede um tamanho e relata a constraint que chegou.
class _Alvo extends StatelessWidget {
  const _Alvo();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: 120,
          height: 60,
          color: Colors.indigo,
          alignment: Alignment.center,
          child: Text(
            'quero 120x60\n'
            'w ${_n(constraints.minWidth)}..${_n(constraints.maxWidth)}\n'
            'h ${_n(constraints.minHeight)}..${_n(constraints.maxHeight)}\n'
            '${constraints.isTight ? 'TIGHT' : 'LOOSE'}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              height: 1.15,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}

// O pai que você não controla. A moldura cinza é a área dele.
class _PaiTight extends StatelessWidget {
  const _PaiTight({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // ! SizedBox de tamanho fixo manda TIGHT: min == max nos dois eixos. E não
    // ! existe parâmetro nele para afrouxar — é justamente essa a graça.
    return ColoredBox(
      color: Colors.grey.shade300,
      child: SizedBox(width: 280, height: 130, child: child),
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

class TelaAfrouxarPaiTight extends StatelessWidget {
  const TelaAfrouxarPaiTight({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('O pai é tight. E agora?')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'O alvo pede 120x60. O pai é um SizedBox fixo e você não pode '
            'mexer nele. Que widget entra no meio?',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          _Caso(
            titulo: 'O problema: pedido ignorado, o alvo vira 280x130',
            child: _PaiTight(child: _Alvo()),
          ),
        ],
      ),
    );
  }
}
