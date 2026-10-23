// exemplo_02_autovalidate_inicio.dart
// Ponto de partida: o cadastro, com `Form` + `validator` nos dois campos. A
// validação funciona.
//
// Faça o teste como um usuário faria:
//
// ! 1. Digite um nome de usuário curto ("ab").
// ! 2. Digite uma senha curta ("123").
// ! 3. Toque em "Cadastrar".
// !
// ! Só AGORA os dois erros aparecem. A pessoa preencheu o formulário inteiro
// ! achando que estava tudo certo, e o app esperou até o último momento para
// ! contar que não estava.
//
// ? Dá para avisar enquanto a pessoa digita, sem acusar erro num formulário
// ? ainda em branco? E, se der, esse aviso vale por campo ou para o formulário
// ? inteiro?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaCadastro()));

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Autovalidação')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome de usuário',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().length < 3) {
                    return 'Use ao menos 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Mínimo de 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    if (Form.of(context).validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cadastro válido!')),
                      );
                    }
                  },
                  child: const Text('Cadastrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
