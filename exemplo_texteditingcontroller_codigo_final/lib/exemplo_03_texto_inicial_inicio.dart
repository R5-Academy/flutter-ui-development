// exemplo_03_texto_inicial_inicio.dart
// Ponto de partida: a tela de editar perfil. O nome já está cadastrado — veio do
// banco, do servidor, da tela anterior — e precisa aparecer no campo assim que a
// tela abre, pronto para a pessoa corrigir.
//
// ! Rode. O cadastro aparece no rótulo de cima, mas o campo abre VAZIO. Quem
// ! entra nessa tela é obrigado a digitar o nome de novo, do zero, só para
// ! trocar uma letra.
//
// ? O `onChanged` da aula passada me deixa LER o que a pessoa digita. Mas aqui o
// ? caminho é o contrário: eu quero ESCREVER no campo antes de ela chegar. Que
// ? parte do controller faz isso?

import 'package:flutter/material.dart';

const _nomeCadastrado = 'Ana Souza';

void main() => runApp(const MaterialApp(home: TextoInicial()));

class TextoInicial extends StatefulWidget {
  const TextoInicial({super.key});

  @override
  State<TextoInicial> createState() => _TextoInicialState();
}

class _TextoInicialState extends State<TextoInicial> {
  final _nomeController = TextEditingController(text: _nomeCadastrado);

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
            const _CadastroAtual(),
            const SizedBox(height: 16),
            TextField(
              controller: _nomeController,
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

// O rótulo que mostra o dado que já existe. Ele é a régua do exemplo: enquanto o
// campo não nascer preenchido, os dois vão discordar na tela.
class _CadastroAtual extends StatelessWidget {
  const _CadastroAtual();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Cadastro atual: $_nomeCadastrado',
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
