// exemplo_01_textformfield_no_form_inicio.dart
// Ponto de partida: juntando o que as duas últimas aulas ensinaram — um `Form`
// com `GlobalKey<FormState>` (aula de Form) e um `TextField` dentro dele (aula
// passada). O botão chama `validate()`.
//
// ! Deixe o campo VAZIO e toque em "Enviar". A mensagem de sucesso aparece.
//
// ! O `validate()` devolveu `true` num formulário em branco. E não é bug: ele
// ! percorreu os campos de formulário que existiam dentro do `Form`... e não
// ! havia nenhum. O `TextField` está lá na tela, mas o `Form` não o enxerga.
//
// ? Um `TextField` dentro de um `Form` não vira um campo do formulário. O que
// ? falta?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: FormularioNome()));

class FormularioNome extends StatefulWidget {
  const FormularioNome({super.key});

  @override
  State<FormularioNome> createState() => _FormularioNomeState();
}

class _FormularioNomeState extends State<FormularioNome> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextFormField no Form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ! Um TextField comum: não tem `validator` e o Form o ignora.
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Como você se chama?',
                ),
                validator: (value) {
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  final valido = _formKey.currentState!.validate();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        valido ? 'Tudo certo!' : 'Corrija os erros',
                      ),
                    ),
                  );
                },
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
