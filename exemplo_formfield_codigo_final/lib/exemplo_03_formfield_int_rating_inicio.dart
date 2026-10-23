// exemplo_03_formfield_int_rating_inicio.dart
// Ponto de partida: um seletor de estrelas — agora um `FormField<int>`, não
// mais `<bool>`. Com validator e errorText, como no bloco anterior.
//
// O campo funciona: as estrelas acendem, o erro aparece quando a nota é 0, o
// botão só passa quando existe nota. O `onSaved` está escrito, logo abaixo do
// `validator`. Só que o envio sai errado.
//
// ! Escolha 4 estrelas e toque em "Enviar". A mensagem diz:
// !     "Avaliação enviada: 0 estrela(s)"
// !
// ! Quatro estrelas acesas na tela, e zero no envio. O `validate()` viu a nota
// ! (por isso deixou passar), mas `_notaSalva` continua em 0 — o `onSaved`
// ! nunca rodou.
//
// ? `validate()` só CHECA. Quem dispara o `onSaved` de cada campo é outro
// ? comando do `Form`. Qual?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: FormFieldRating()));

class FormFieldRating extends StatefulWidget {
  const FormFieldRating({super.key});

  @override
  State<FormFieldRating> createState() => _FormFieldRatingState();
}

class _FormFieldRatingState extends State<FormFieldRating> {
  final _formKey = GlobalKey<FormState>();

  // Destino da nota. Quem escreve aqui é o onSaved do campo — quando ele rodar.
  int _notaSalva = 0;

  void _enviar() {
    // ! Checa e já sai usando o valor. Falta um passo entre as duas coisas.
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Avaliação enviada: $_notaSalva estrela(s)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final corDeErro = Theme.of(context).colorScheme.error;

    return Scaffold(
      appBar: AppBar(title: const Text('FormField<int>')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Como você avalia a compra?'),
              FormField<int>(
                initialValue: 0,
                validator: (nota) {
                  if (nota == null || nota == 0) {
                    return 'Toque nas estrelas para avaliar';
                  }
                  return null;
                },
                // ? Está aqui, escrito. Quem manda ele rodar?
                onSaved: (nota) => _notaSalva = nota ?? 0,
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
              ElevatedButton(onPressed: _enviar, child: const Text('Enviar')),
            ],
          ),
        ),
      ),
    );
  }
}
