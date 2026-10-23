// exemplo_01_obrigatorio_e_email_inicio.dart
// Ponto de partida: o formulário de contato, com as validações que a seção
// vinha usando — obrigatório e "tem @".
//
// ! Teste os dois campos com o que um usuário real digita sem querer:
// !
// !   Nome:   "   "        (só espaços)  -> **passa**
// !   E-mail: "@"                        -> **passa**
// !   E-mail: "a@b"                      -> **passa**
// !   E-mail: "joão@@casa"               -> **passa**
//
// ! Três espaços não são um nome. E "@" não é um e-mail — mas `contains('@')`
// ! não sabe disso.
//
// ? "Preenchido" e "válido" não são a mesma coisa. Como escrever regras que
// ? checam o que o valor **precisa ser**?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaContato()));

final _regexEmail = RegExp(
  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
);

class TelaContato extends StatefulWidget {
  const TelaContato({super.key});

  @override
  State<TelaContato> createState() => _TelaContatoState();
}

class _TelaContatoState extends State<TelaContato> {
  final _formKey = GlobalKey<FormState>();

  void _enviar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Formulário válido!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contato')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                // ! `isEmpty` sem trim: três espaços passam.
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe seu nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                // ! "tem @" aceita "@", "a@b", "@@@".
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Informe o e-mail';
                  }
                  if (!_regexEmail.hasMatch(valor)) return 'E-mail inválido';
                  return null;
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
