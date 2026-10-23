// exemplo_02_alterar_e_limpar_inicio.dart
// Ponto de partida: o campo de cupom do carrinho. O app **já sabe** que existe
// um cupom disponível — ele está ali, escrito na tela, logo abaixo do campo.
//
// ! E mesmo assim a pessoa precisa digitar "FRETEGRATIS" letra por letra, do
// ! jeito certo, sem errar. Num celular. Enquanto lê da tela.
//
// ! O botão "Limpar" tem o mesmo problema ao contrário: ele não tem como
// ! esvaziar o campo — a pessoa precisa apagar caractere por caractere.
//
// ? O controller leu o texto no bloco anterior. Ele consegue **escrever**
// ? também?

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: AlterarELimpar()));

const _cupomSugerido = 'FRETEGRATIS';

class AlterarELimpar extends StatefulWidget {
  const AlterarELimpar({super.key});

  @override
  State<AlterarELimpar> createState() => _AlterarELimparState();
}

class _AlterarELimparState extends State<AlterarELimpar> {
  final _cupomController = TextEditingController();

  @override
  void dispose() {
    _cupomController.dispose();
    super.dispose();
  }

  void _aplicar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cupom enviado: "${_cupomController.text}"')),
    );
  }

  void _usarSugestao() {
    _cupomController.text = _cupomSugerido;
  }

  void _limpar() {
    _cupomController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cupom')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _cupomController,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: 'Cupom de desconto',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            // ! O app sabe o cupom — e pede para a pessoa digitá-lo.
            Text('Disponível para você: $_cupomSugerido'),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _usarSugestao,
                    child: Text('Usar $_cupomSugerido'),
                  ),
                ),
                TextButton(onPressed: _limpar, child: Text('Limpar')),
              ],
            ),

            FilledButton(onPressed: _aplicar, child: const Text('Aplicar')),
          ],
        ),
      ),
    );
  }
}
