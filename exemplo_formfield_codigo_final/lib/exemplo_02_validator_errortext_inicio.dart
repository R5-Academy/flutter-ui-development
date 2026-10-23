// exemplo_02_validator_errortext_inicio.dart
// Ponto de partida: o `FormField<bool>` agora está dentro de um `Form`, com uma
// `GlobalKey<FormState>` e um `validator` que exige o aceite.
//
// O botão chama `validate()` — e a validação **está funcionando**.
//
// ! Prove: sem marcar o checkbox, toque em "Enviar". A SnackBar não aparece,
// ! porque `validate()` devolveu false e o `if` barrou.
//
// ! E é exatamente aí que está o problema: **nada acontece na tela**. Nenhuma
// ! mensagem, nenhum vermelho, nenhuma pista. Do ponto de vista de quem usa, o
// ! botão simplesmente não funciona.
//
// ? No `TextFormField` a mensagem aparecia sozinha embaixo do campo. Por que
// ? aqui não aparece?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: FormFieldValidator()));

class FormFieldValidator extends StatefulWidget {
  const FormFieldValidator({super.key});

  @override
  State<FormFieldValidator> createState() => _FormFieldValidatorState();
}

class _FormFieldValidatorState extends State<FormFieldValidator> {
  final _formKey = GlobalKey<FormState>();

  void _enviar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Cadastro enviado!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('validator + errorText')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormField<bool>(
                initialValue: false,
                // A regra existe e roda: String = erro, null = válido.
                validator: (aceito) {
                  if (aceito != true) {
                    return 'Você precisa aceitar os termos para continuar OK!';
                  }
                  return null;
                },
                builder: (field) {
                  // ! O builder desenha só o checkbox. E o erro?
                  return Column(
                    children: [
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Aceito os termos de uso'),
                        value: field.value ?? false,
                        onChanged: (novo) => field.didChange(novo),
                      ),
                      if (field.hasError)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            field.errorText ?? 'Erro',
                            style: TextStyle(color: Colors.red, fontSize: 12),
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
