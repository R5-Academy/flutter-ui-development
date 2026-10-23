// exemplo_04_form_completo_reset_inicio.dart
// Ponto de partida: os dois campos customizados juntos — o aceite e a nota —
// num formulário só, com validação, `onSaved` e envio funcionando.
//
// Falta o "Limpar". Ele existe e faz o que parece certo: zera as variáveis do
// State.
//
// ! Preencha o formulário: marque o aceite, escolha 4 estrelas. Agora toque em
// ! "Limpar".
// !
// ! Nada acontece na tela. O checkbox continua marcado, as estrelas continuam
// ! amarelas. As variáveis foram zeradas — mas os valores que a pessoa vê não
// ! moram nelas.
//
// ? Onde mora o valor de um `FormField`? E quem pode mandar nele?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: FormCompleto()));

class FormCompleto extends StatefulWidget {
  const FormCompleto({super.key});

  @override
  State<FormCompleto> createState() => _FormCompletoState();
}

class _FormCompletoState extends State<FormCompleto> {
  final _formKey = GlobalKey<FormState>();

  bool _aceite = false;
  int _nota = 0;

  void _enviar() {
    final form = _formKey.currentState!;
    if (!form.validate()) return;
    form.save();
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Recebido'),
        content: Text('Aceite: $_aceite\nNota: $_nota estrela(s)'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final corDeErro = Theme.of(context).colorScheme.error;

    return Scaffold(
      appBar: AppBar(title: const Text('Form completo')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormField<bool>(
                initialValue: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) =>
                    v == true ? null : 'É preciso aceitar os termos',
                onSaved: (v) => _aceite = v ?? false,
                builder: (field) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Aceito os termos'),
                      value: field.value ?? false,
                      onChanged: field.didChange,
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
                ),
              ),
              const SizedBox(height: 16),
              const Text('Sua nota:'),
              FormField<int>(
                initialValue: 0,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (n) => (n ?? 0) > 0 ? null : 'Escolha uma nota',
                onSaved: (n) => _nota = n ?? 0,
                builder: (field) {
                  final nota = field.value ?? 0;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: List.generate(5, (i) {
                          final indice = i + 1;
                          return IconButton(
                            icon: Icon(
                              indice <= nota ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                            ),
                            tooltip: '$indice estrela(s)',
                            onPressed: () => field.didChange(indice),
                          );
                        }),
                      ),
                      if (field.hasError)
                        Text(
                          field.errorText!,
                          style: TextStyle(color: corDeErro, fontSize: 12),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _enviar,
                    child: const Text('Enviar'),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () => _formKey.currentState!.reset(),
                    child: const Text('Limpar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
