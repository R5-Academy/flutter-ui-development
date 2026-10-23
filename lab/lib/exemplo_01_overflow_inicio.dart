// exemplo_01_overflow_inicio.dart
// Um formulário de cadastro: onze campos e um botão, empilhados numa Column.
//
// ! Rode e olhe a tela: a listra amarela e preta na borda de baixo, e no
// ! console "A RenderFlex overflowed by N pixels on the bottom".
//
// O conteúdo é maior que a tela. A Column não tem para onde crescer.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppCadastro());

class AppCadastro extends StatelessWidget {
  const AppCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const TelaCadastro(),
    );
  }
}

class TelaCadastro extends StatelessWidget {
  const TelaCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _Campo(rotulo: 'Nome completo'),
            _Campo(rotulo: 'E-mail'),
            _Campo(rotulo: 'CPF'),
            _Campo(rotulo: 'Telefone'),
            _Campo(rotulo: 'CEP'),
            _Campo(rotulo: 'Endereço'),
            _Campo(rotulo: 'Número'),
            _Campo(rotulo: 'Complemento'),
            _Campo(rotulo: 'Bairro'),
            _Campo(rotulo: 'Cidade'),
            _Campo(rotulo: 'Estado'),
            SizedBox(height: 16),
            _BotaoSalvar(),
          ],
        ),
      ),
    );
  }
}

class _Campo extends StatelessWidget {
  const _Campo({required this.rotulo});

  final String rotulo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        decoration: InputDecoration(
          labelText: rotulo,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class _BotaoSalvar extends StatelessWidget {
  const _BotaoSalvar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(onPressed: () {}, child: const Text('Salvar')),
    );
  }
}
