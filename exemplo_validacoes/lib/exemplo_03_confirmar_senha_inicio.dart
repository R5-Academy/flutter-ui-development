// exemplo_03_confirmar_senha_inicio.dart
// Ponto de partida: cadastro com senha e confirmação. Os dois campos têm a
// regra de tamanho mínimo.
//
// ! E é só isso que eles têm. Digite `12345678` na senha e `87654321` na
// ! confirmação: os dois passam, e o cadastro é aceito.
//
// ! O campo "Confirmar senha" só existe para responder **uma** pergunta — as
// ! duas são iguais? — e ele não a faz. Do jeito que está, é um campo decorativo
// ! que ainda dá trabalho para a pessoa preencher.
//
// ? Um `validator` recebe só o texto do **próprio** campo. Como o segundo campo
// ? enxerga o que foi digitado no primeiro?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaCadastroSenha()));

class TelaCadastroSenha extends StatefulWidget {
  const TelaCadastroSenha({super.key});

  @override
  State<TelaCadastroSenha> createState() => _TelaCadastroSenhaState();
}

class _TelaCadastroSenhaState extends State<TelaCadastroSenha> {
  final _formKey = GlobalKey<FormState>();

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Cadastrado!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar senha')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (valor) {
                  final texto = valor ?? '';
                  if (texto.length < 8) return 'Mínimo de 8 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confirmar senha'),
                obscureText: true,
                // ! A mesma regra do campo de cima — e nada comparando os dois.
                validator: (valor) {
                  final texto = valor ?? '';
                  if (texto.length < 8) return 'Mínimo de 8 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _cadastrar,
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
