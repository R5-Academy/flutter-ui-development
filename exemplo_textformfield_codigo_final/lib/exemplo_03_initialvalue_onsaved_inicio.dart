// exemplo_03_initialvalue_onsaved_inicio.dart
// Ponto de partida: a tela de **editar** perfil. O nome cadastrado do usuário
// já veio do servidor — está ali na variável `_nomeCadastrado`.
//
// ! Mas o campo abre VAZIO. Para trocar uma letra do nome, a pessoa precisa
// ! digitar tudo de novo. E, se ela fechar a tela sem digitar nada, o formulário
// ! reprova dizendo "informe seu nome" — para um nome que já existe.
//
// ! Repare também no botão: ele valida, mas o `_nomeSalvo` nunca é preenchido.
// ! Não há nada colhendo o valor do campo.
//
// Editar é diferente de cadastrar: a tela precisa **começar preenchida** e
// devolver o valor final.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: EditarPerfil()));

class EditarPerfil extends StatefulWidget {
  const EditarPerfil({super.key});

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  final _formKey = GlobalKey<FormState>();

  // O que veio do servidor.
  static const _nomeCadastrado = 'Rodrigo';

  // ! Repare no `final`: nada escreve aqui, e o analisador não reclama disso —
  // ! quem tem que perceber é você. Não existe ninguém colhendo o valor do campo,
  // ! então o snack do botão vai sair vazio por mais que a pessoa digite.
  var _nomeSalvo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // O dado está aqui, na tela, ao lado de um campo vazio.
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Nome atualizado: $_nomeSalvo'),
              ),
              const SizedBox(height: 8),
              // ! O nome cadastrado existe — e o campo ignora.
              TextFormField(
                initialValue: _nomeCadastrado,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe seu nome';
                  }
                  return null;
                },
                onSaved: (newValue) => _nomeSalvo = newValue ?? '',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Salvo: "$_nomeSalvo"')),
                    );
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
