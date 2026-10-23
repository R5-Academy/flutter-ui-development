// exemplo_02_key_no_build_inicio.dart
// Ponto de partida: um formulário de newsletter. Dois campos e um checkbox
// "Aceito receber novidades" — o tipo de coisa que existe em metade dos
// cadastros.
//
// Faça na ordem:
//
// ! 1. Preencha o nome e o e-mail.
// ! 2. Marque o checkbox.
// !
// ! Os dois campos **esvaziam**. Marcar uma caixinha apagou o formulário
// ! inteiro.
//
// ? O `onChanged` do checkbox só faz `setState` — ele não toca em campo nenhum.
// ? E o `setState` é a coisa mais banal do Flutter: acontece o tempo todo, por
// ? mil motivos. Se isso apaga o formulário, o problema não é o checkbox.
//
// A causa está numa única linha deste arquivo.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaNewsletter()));

class TelaNewsletter extends StatefulWidget {
  const TelaNewsletter({super.key});

  @override
  State<TelaNewsletter> createState() => _TelaNewsletterState();
}

class _TelaNewsletterState extends State<TelaNewsletter> {
  bool _aceitaNovidades = false;

  @override
  Widget build(BuildContext context) {
    // ! A key nasce AQUI, a cada build. Cada rebuild inventa uma identidade
    // ! nova para o mesmo formulário.
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Newsletter')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              CheckboxListTile(
                title: const Text('Aceito receber novidades'),
                value: _aceitaNovidades,
                // Um setState comum, como tantos outros.
                onChanged: (v) => setState(() => _aceitaNovidades = v ?? false),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => formKey.currentState!.validate(),
                child: const Text('Assinar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
