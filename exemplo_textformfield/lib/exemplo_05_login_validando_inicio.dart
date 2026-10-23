// exemplo_04_login_validando_inicio.dart
// Ponto de partida: a tela de login inteira, com tudo o que a aula construiu —
// `TextFormField`, `validator`, `onSaved`, `validate()` + `save()`.
//
// As regras existem: os dois campos são obrigatórios.
//
// ! Só que "obrigatório" é a regra mais fraca que existe. Teste:
// !   e-mail: `a`      -> passa
// !   senha:  `1`      -> passa
// !
// ! O formulário aprova um e-mail que não é e-mail e uma senha de um caractere.
// ! Ele está protegendo contra o campo em branco e contra mais nada.
//
// Validar não é checar se tem alguma coisa. É checar se **serve**.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaLogin()));

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _formKey = GlobalKey<FormState>();

  var _email = '';
  var _senha = '';

  void _entrar() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Entrando como $_email (${_senha.length} car.)'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
                // ! Só checa se digitou alguma coisa.
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o e-mail';
                  }
                  return null;
                },
                onSaved: (valor) => _email = valor?.trim() ?? '',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                obscureText: true,
                // ! Idem: qualquer caractere serve.
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Informe a senha';
                  }
                  return null;
                },
                onSaved: (valor) => _senha = valor ?? '',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _entrar,
                  child: const Text('Entrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
