// exemplo_04_contador_caracteres_inicio.dart
// Ponto de partida: o campo de bio com um contador de caracteres, feito com
// `onChanged`. Digite e veja: o contador acompanha certinho.
//
// A tela também tem um botão "Colar rascunho", que escreve 87 caracteres no
// campo — usando o `.text` do bloco 2.
//
// ! Faça na ordem: digite `abc` (o contador marca **3/150**) e só então toque em
// ! "Colar rascunho". Os 87 caracteres entram no campo... e o contador
// ! **congela no 3/150**. Ele não zera nem erra: ele simplesmente para de
// ! acompanhar, e agora mente sobre o que está na tela.
//
// ? O texto mudou. Por que o `onChanged` não rodou?
//
// Porque ele não é um "avise-me quando o texto mudar". Ele é um "avise-me
// quando o USUÁRIO editar". Mudança por código não passa por ele.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ContadorCaracteres()));

const _limite = 150;
const _rascunho =
    'Desenvolvedor Flutter há 3 anos. Gosto de café e de código '
    'que os outros conseguem ler.';

class ContadorCaracteres extends StatefulWidget {
  const ContadorCaracteres({super.key});

  @override
  State<ContadorCaracteres> createState() => _ContadorCaracteresState();
}

class _ContadorCaracteresState extends State<ContadorCaracteres> {
  final _bioController = TextEditingController();
  int _quantidade = 0;

  @override
  void initState() {
    super.initState();
    _bioController.addListener(_atualizarContador);
  }

  void _atualizarContador() {
    setState(() {
      _quantidade = _bioController.text.length;
    });
  }

  @override
  void dispose() {
    _bioController.removeListener(_atualizarContador);
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passou = _quantidade > _limite;

    return Scaffold(
      appBar: AppBar(title: const Text('Bio com contador')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _bioController,
              maxLines: 4,
              // ! Só dispara quando o USUÁRIO edita.
              // onChanged: (texto) =>
              //     setState(() => _quantidade = texto.characters.length),
              decoration: const InputDecoration(
                labelText: 'Sua bio',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$_quantidade/$_limite',
              style: TextStyle(
                color: passou
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: passou ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => _bioController.text = _rascunho,
              child: const Text('Colar rascunho'),
            ),
          ],
        ),
      ),
    );
  }
}
