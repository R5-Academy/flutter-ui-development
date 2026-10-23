// exemplo_04_maxlength_maxlines_inicio.dart
// Ponto de partida: o campo de observações do pedido — "sem cebola", "ponto da
// carne", esse tipo de coisa.
//
// ! Digite um texto longo e repare em dois problemas ao mesmo tempo:
// !
// ! 1. O campo tem **uma linha só**. O texto vai rolando para a esquerda e some
// !    do começo — a pessoa não consegue reler o que escreveu.
// ! 2. O backend aceita **140 caracteres**. Nada na tela avisa isso. A pessoa
// !    escreve um parágrafo, toca em enviar, e só então descobre o limite.
//
// Os dois se resolvem com um parâmetro cada — e um deles traz um contador de
// brinde.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: CampoObservacao()));

class CampoObservacao extends StatefulWidget {
  const CampoObservacao({super.key});

  @override
  State<CampoObservacao> createState() => _CampoObservacaoState();
}

class _CampoObservacaoState extends State<CampoObservacao> {
  var _texto = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('maxLength e maxLines')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (valor) => setState(() => _texto = valor),
              decoration: const InputDecoration(
                labelText: 'Observações do pedido',
                hintText: 'Ex.: sem cebola, ponto da carne, troco para 50...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Text('Caracteres digitados: ${_texto.length}'),
          ],
        ),
      ),
    );
  }
}
