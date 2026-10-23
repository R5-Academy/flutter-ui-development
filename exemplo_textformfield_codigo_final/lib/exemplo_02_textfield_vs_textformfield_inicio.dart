// exemplo_02_textfield_vs_textformfield_inicio.dart
// Ponto de partida: um cadastro com dois campos de naturezas diferentes:
//
//   Apelido -> opcional, sem regra nenhuma
//   E-mail  -> obrigatório
//
// Os dois são `TextField`, e o botão manda validar.
//
// ! Deixe tudo em branco e toque em "Validar": passa. O e-mail é obrigatório e
// ! ninguém reclamou — é o mesmo silêncio do bloco anterior.
//
// ? A correção você já sabe. A pergunta deste bloco é outra: **os dois campos
// ? precisam mudar?** Ou existe um critério para decidir caso a caso?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: Comparacao()));

class Comparacao extends StatefulWidget {
  const Comparacao({super.key});

  @override
  State<Comparacao> createState() => _ComparacaoState();
}

class _ComparacaoState extends State<Comparacao> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextField × TextFormField')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Apelido (opcional)',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const TextField(
                decoration: InputDecoration(labelText: 'Como quer ser chamado'),
              ),
              const SizedBox(height: 32),

              const Text(
                'E-mail (obrigatório)',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              // ! Obrigatório — e sem nenhuma regra escrita.
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final valido = _formKey.currentState!.validate();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(valido ? 'Válido!' : 'Tem erro')),
                    );
                  },
                  child: const Text('Validar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
