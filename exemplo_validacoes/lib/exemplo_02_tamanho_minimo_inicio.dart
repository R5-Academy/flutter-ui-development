// exemplo_02_tamanho_minimo_inicio.dart
// Ponto de partida: a tela de definir senha, com a regra de tamanho mínimo já
// escrita e funcionando.
//
// ! A mensagem diz "Mínimo de 8 caracteres". Quantos faltam? A pessoa tem que
// ! contar o que digitou — num campo que mostra bolinhas. E ela só recebe esse
// ! recado depois de tocar em "Salvar".
//
// ? A mensagem pode dizer **o quanto falta**? E, já que o `autovalidateMode`
// ? você conhece da aula de `Form`, o que muda quando ela aparece enquanto se
// ? digita em vez de só no clique?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaSenha()));

class TelaSenha extends StatefulWidget {
  const TelaSenha({super.key});

  @override
  State<TelaSenha> createState() => _TelaSenhaState();
}

class _TelaSenhaState extends State<TelaSenha> {
  final _formKey = GlobalKey<FormState>();

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Senha aceita!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Definir senha')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          // ! Sem autovalidação: o erro só aparece no clique.
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  helperText: 'Ao menos 8 caracteres',
                ),
                obscureText: true,
                validator: (valor) {
                  final texto = valor ?? '';
                  if (texto.isEmpty) return 'Informe a senha';
                  // ! A mensagem não diz quanto falta.
                  if (texto.length < 8) return 'Mínimo de 8 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _salvar,
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
