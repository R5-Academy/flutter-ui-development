// exemplo_04_initialvalue_com_controller_inicio.dart
// Ponto de partida: a mesma tela de editar perfil do bloco anterior — só que
// agora o campo também tem um `TextEditingController`, porque a tela precisa ler
// o valor depois (é o objeto da aula de `TextEditingController`, a 02).
//
// O nome cadastrado precisa aparecer no campo. O `initialValue` que você acabou
// de aprender é o parâmetro para isso, certo?
//
// ! Rode. O app **quebra na hora**, antes de desenhar qualquer coisa. A
// ! mensagem literal, provocada nesta máquina (Flutter 3.44.6):
// !
// !     'package:flutter/src/material/text_form_field.dart':
// !     Failed assertion: line 194 pos 15:
// !     'initialValue == null || controller == null': is not true.
// !
// ! Repare que não há texto explicando — é um assert **sem mensagem**: o Flutter
// ! só mostra a condição que ele esperava. E, por ser assert, ele **só existe em
// ! debug**: em release essa mesma linha passa batida. Passar os dois é pedir
// ! para duas peças mandarem no mesmo texto.
//
// ? Se o controller é o dono do texto, de onde deveria vir o valor inicial?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TextoInicial()));

class TextoInicial extends StatefulWidget {
  const TextoInicial({super.key});

  @override
  State<TextoInicial> createState() => _TextoInicialState();
}

class _TextoInicialState extends State<TextoInicial> {
  final _nomeController = TextEditingController(text: 'Ana Sousa');

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _salvar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Nome salvo: ${_nomeController.text}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nomeController,
              // ! Os dois juntos: assert na inicialização.
              // initialValue: 'Ana Souza',
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: _salvar, child: const Text('Salvar')),
          ],
        ),
      ),
    );
  }
}
