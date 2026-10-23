// exemplo_03_receita_inicio.dart
// Uma tela de login: logo em cima, formulário no meio e o "não tem conta?"
// que deveria ficar GRUDADO na parte de baixo da tela.
//
// O SingleChildScrollView já está aqui, então em tela pequena rola e não
// estoura.
//
// ! Mas rode numa tela grande e olhe o rodapé: ele não fica embaixo. Ele sobe
// ! e cola no final do conteúdo, com um vazio enorme sobrando abaixo dele.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppLogin());

class AppLogin extends StatelessWidget {
  const AppLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const TelaLogin(),
    );
  }
}

class TelaLogin extends StatelessWidget {
  const TelaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 48),
              const FlutterLogo(size: 96),
              const SizedBox(height: 12),
              Text(
                'Academia do Flutter',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 32),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('Entrar'),
                ),
              ),
              const SizedBox(height: 24),
              const Divider(),
              TextButton(
                onPressed: () {},
                child: const Text('Não tem conta? Cadastre-se'),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
