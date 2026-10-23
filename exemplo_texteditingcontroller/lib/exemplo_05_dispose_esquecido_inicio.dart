// exemplo_05_dispose_esquecido_inicio.dart
// Ponto de partida: um cadastro com dois controllers. Rode: digita, cadastra,
// tudo funciona. Navegue para a outra tela e volte: continua funcionando.
//
// ! E é exatamente esse o problema. **Não há `dispose()` neste arquivo.**
//
// ! Cada `TextEditingController` guarda listeners e conversa com o teclado do
// ! sistema. Quando a tela morre sem que ele seja liberado, ele continua vivo na
// ! memória, com tudo pendurado. Abrir e fechar esta tela cem vezes deixa cem
// ! controllers órfãos.
//
// ! Nada avisa. Não há erro, não há log, não há linha vermelha. O app só fica
// ! mais pesado a cada navegação — e, num app grande, isso vira o tipo de
// ! lentidão que ninguém consegue explicar.
//
// ? Onde é o lugar de desfazer o que o `State` criou?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: Cadastro()));

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();

  // ! Não existe dispose() aqui.

  void _cadastrar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Cadastrado: ${_nomeController.text} / ${_emailController.text}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: _cadastrar, child: const Text('Cadastrar')),
            const SizedBox(height: 8),
            // Para a demonstração: sair e voltar cria um State novo a cada vez.
            TextButton(
              onPressed: () => Navigator.of(
                context,
              ).push(MaterialPageRoute<void>(builder: (_) => const Cadastro())),
              child: const Text('Abrir outra vez'),
            ),
          ],
        ),
      ),
    );
  }
}
