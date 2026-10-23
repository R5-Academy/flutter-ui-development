// exemplo_01_ler_texto_inicio.dart
// Ponto de partida: ler o campo do jeito que a aula de TextField ensinou —
// `onChanged` copiando o texto para uma variável do State a cada tecla.
//
// Funciona. Mas olhe o custo:
//
// ! - o `setState` roda a **cada letra digitada**, reconstruindo a tela inteira
// !   por um valor que só vai ser usado quando alguém tocar em "Entrar";
// ! - para cada campo, uma variável e um `onChanged`. Num cadastro de seis
// !   campos, são seis de cada;
// ! - e a variável é uma **cópia**: se ela e o campo saírem de sincronia, você
// !   tem duas verdades e nenhuma confiável.
//
// ? O campo já guarda o texto. Em vez de copiá-lo continuamente, dá para
// ? simplesmente **perguntar** a ele quando precisar?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: LerTexto()));

class LerTexto extends StatefulWidget {
  const LerTexto({super.key});

  @override
  State<LerTexto> createState() => _LerTextoState();
}

class _LerTextoState extends State<LerTexto> {
  // Nossa cópia do que está no campo, mantida a cada tecla.
  var _email = '';

  void _entrar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _email.isEmpty
            ? const Text('Digite um e-mail primeiro.')
            : Text('E-mail lido: $_email'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ler o texto do campo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              // ! Um rebuild da tela inteira a cada tecla.
              onChanged: (valor) => setState(() => _email = valor),
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: _entrar, child: const Text('Entrar')),
          ],
        ),
      ),
    );
  }
}
