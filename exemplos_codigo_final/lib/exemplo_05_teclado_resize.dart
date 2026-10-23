// exemplo_05_teclado_resize.dart
// Demonstra: resizeToAvoidBottomInset — o que o Scaffold faz quando o teclado sobe.
// Novo em relação ao 04: a moldura reage a uma mudança do sistema (o teclado),
// não a uma mudança do nosso código.
//
// O TextField aqui é só o gatilho para abrir o teclado; ele tem aula própria
// mais pra frente, na seção de Formulários.

import 'package:flutter/material.dart';

void main() => runApp(const AppTeclado());

class AppTeclado extends StatelessWidget {
  const AppTeclado({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Teclado e Scaffold', home: TelaTeclado());
  }
}

class TelaTeclado extends StatefulWidget {
  const TelaTeclado({super.key});

  @override
  State<TelaTeclado> createState() => _TelaTecladoState();
}

class _TelaTecladoState extends State<TelaTeclado> {
  bool _encolherComTeclado = true;

  @override
  Widget build(BuildContext context) {
    // viewInsets.bottom é a altura do que o sistema está cobrindo por baixo:
    // com o teclado fechado vale 0; aberto, vale a altura do teclado.
    final alturaDoTeclado = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      appBar: AppBar(title: const Text('Teclado')),
      // * Este parâmetro é bool?, mas o comportamento efetivo quando você não
      // * informa nada é true: o body encolhe para o teclado caber.
      // ! Com false o teclado passa a COBRIR o body — e o campo focado pode
      // ! sumir atrás dele. Só desligue se você mesmo cuidar disso.
      resizeToAvoidBottomInset: _encolherComTeclado,
      body: Center(
        child: TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Toque para abrir o teclado',
            helperText: 'teclado ocupando: ${alturaDoTeclado.toStringAsFixed(0)}',
          ),
        ),
      ),
      persistentFooterButtons: [
        TextButton(
          onPressed: () =>
              setState(() => _encolherComTeclado = !_encolherComTeclado),
          child: Text(
            'resizeToAvoidBottomInset: $_encolherComTeclado',
          ),
        ),
      ],
    );
  }
}
