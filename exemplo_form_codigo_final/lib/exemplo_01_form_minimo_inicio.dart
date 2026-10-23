// exemplo_01_form_minimo_inicio.dart
// Ponto de partida: a tela de login. O controller da aula passada guarda o que
// foi digitado, e o botão confere se está preenchido antes de seguir.
//
// A validação está aqui, escrita na mão, dentro do `onPressed`.
//
// ! Rode e toque em "Entrar" com o campo vazio. O erro aparece... numa barrinha
// ! no rodapé da tela, longe do campo que causou o problema.
//
// ! E agora imagine este mesmo formulário com cinco campos. O `if` do botão
// ! vira uma escada, o SnackBar só consegue mostrar UM erro por vez, e a pessoa
// ! precisa adivinhar qual campo ele está criticando.
//
// Validação de formulário é um problema tão comum que o Flutter tem uma
// estrutura pronta para ele.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaLogin()));

class const TelaLogin({super.key}) extends StatefulWidget {
  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // void _entrar() {
  //   // ! A validação na mão: cada regra é um if, e o erro sai longe do campo.
  //   final email = _emailController.text;
  //   if (email.isEmpty) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Informe o e-mail')));
  //     return;
  //   }
  //   if (!email.contains('@')) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('E-mail inválido')));
  //     return;
  //   }
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(const SnackBar(content: Text('Formulário válido!')));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form mínimo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o e-mail';
                  }

                  if (!value.contains('@')) {
                    return 'E-mail inválido!';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome Inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      if (Form.of(context).validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Formulário Válido!')),
                        );
                      }
                    },
                    child: const Text('Entrar'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
