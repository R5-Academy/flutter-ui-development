// exemplo_02_02_setstate_por_fora.dart
// Cace o bug. Este arquivo tem o `FormField<bool>`, tem o `validator`, tem o
// `errorText` desenhado — e mesmo assim o formulário nunca envia.
//
// ! Marque o checkbox. Ele fica marcado na tela. Toque em "Enviar":
// !     "Você precisa aceitar os termos para continuar"
// !
// ! Medido: `validate()` devolve **false** e o `validator` recebe `v = false`,
// ! com o checkbox visivelmente marcado.
//
// ! O motivo: o valor foi guardado num `bool` do State, com `setState`. O
// ! `FormField` nunca soube da mudança — para ele, o valor continua sendo o
// ! `initialValue` (`false`). Quem o `validator` e o `onSaved` enxergam é o
// ! valor do `FormFieldState`, não o da sua variável.
//
// * A correção é uma linha: `value: field.value ?? false` e
// * `onChanged: field.didChange`. `didChange` troca o valor guardado, marca o
// * campo como "o usuário mexeu" e avisa o `Form`. `setState` não faz nada
// * disso — ele só repinta.
//
// * Regra da casa: dentro de um `FormField`, o dono do valor é o campo. Você
// * lê com `field.value` e escreve com `field.didChange`. Ter um `bool` seu em
// * paralelo é ter duas verdades — e uma delas sempre fica para trás.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: SetStatePorFora()));

class SetStatePorFora extends StatefulWidget {
  const SetStatePorFora({super.key});

  @override
  State<SetStatePorFora> createState() => _SetStatePorForaState();
}

class _SetStatePorForaState extends State<SetStatePorFora> {
  final _formKey = GlobalKey<FormState>();

  // ! A segunda verdade: o FormField não conhece esta variável.
  bool _aceito = false;

  void _enviar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Cadastro enviado!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final corDeErro = Theme.of(context).colorScheme.error;

    return Scaffold(
      appBar: AppBar(title: const Text('Cace o bug')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormField<bool>(
                initialValue: false,
                validator: (aceito) {
                  if (aceito != true) {
                    return 'Você precisa aceitar os termos para continuar';
                  }
                  return null;
                },
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Aceito os termos de uso'),
                        // ! Lendo e escrevendo a variável de fora do campo.
                        value: _aceito,
                        onChanged: (novo) =>
                            setState(() => _aceito = novo ?? false),
                      ),
                      if (field.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            field.errorText!,
                            style: TextStyle(color: corDeErro, fontSize: 12),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _enviar, child: const Text('Enviar')),
            ],
          ),
        ),
      ),
    );
  }
}
