// exemplo_01_a_key_e_a_ponte_inicio.dart
// Ponto de partida: o formulário da aula passada, com uma mudança pequena e
// muito comum — o botão "Enviar" saiu de dentro do `Form` e virou **irmão** dele
// na `Column`.
//
// Por que alguém faria isso? Porque é assim que a tela de verdade é montada: o
// formulário rola no meio da tela e o botão fica preso embaixo, separado. No
// bloco 3 a gente leva o botão para o rodapé de verdade
// (`bottomNavigationBar`) e o problema é exatamente este, só que pior.
//
// O `Builder` continua aqui, então a chamada parece a mesma da aula passada.
//
// ! Rode e toque em "Enviar". O app quebra. A mensagem, provocada nesta máquina
// ! (Flutter 3.44.6):
// !
// !     Form.of() was called with a context that does not contain a Form widget.
// !     No Form widget ancestor could be found starting from the context that
// !     was passed to Form.of().
// !
// ! E o Flutter está certo em reclamar. O `Builder` deu um contexto abaixo da
// ! `Column` — e o `Form` não está acima dele, está do lado. `Form.of` só sabe
// ! SUBIR a árvore; ele nunca vai olhar para o irmão.
//
// ? Não existe `Builder` que resolva isso. Como o botão alcança um `Form` que
// ? não é ancestral dele?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaContato()));

class TelaContato extends StatefulWidget {
  const TelaContato({super.key});

  @override
  State<TelaContato> createState() => _TelaContatoState();
}

class _TelaContatoState extends State<TelaContato> {
  void _enviar(FormState form) {
    final valido = form.validate();
    final mensagem = valido ? 'Formulário válido!' : 'Corrija os campos.';
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensagem)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('A key é a ponte')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // O Form é UM filho da Column; o botão é OUTRO, irmão dele.
            Form(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Seu nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe seu nome';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 24),
            // ! O Builder dá um contexto abaixo da Column — não abaixo do Form.
            Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => _enviar(Form.of(context)),
                child: const Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
