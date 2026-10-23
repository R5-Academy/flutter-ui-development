// exemplo_01_textfield_basico_inicio.dart
// Ponto de partida: uma tela de boas-vindas com um campo para o nome e uma
// saudação embaixo.
//
// O `TextField` já está lá, e funciona: digite e as letras aparecem, o cursor
// anda, dá para apagar, selecionar, colar.
//
// ! Mas a saudação embaixo nunca muda. Digite o seu nome inteiro e ela continua
// ! em "Nada digitado ainda...".
//
// ? O campo guarda o texto — ele está na tela, você está vendo. Só que o resto
// ? do app não faz ideia do que foi digitado. Como o seu código descobre?

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CampoBasico()));

class CampoBasico extends StatefulWidget {
  const CampoBasico({super.key});

  @override
  State<CampoBasico> createState() => _CampoBasicoState();
}

class _CampoBasicoState extends State<CampoBasico> {
  // ! Repare no `final` em string vazia: ninguém escreve nesta variável. E o
  // ! `TextField` logo abaixo é `const`, sem um único callback — não existe
  // ! nenhum caminho do campo até o seu código.
  var _nome = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextField básico')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _nome = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Seu nome',
                hintText: 'Digite seu nome',
              ),
            ),
            const SizedBox(height: 24),
            // ! Preso em "Nada digitado ainda": `_nome` nunca muda.
            Text(
              _nome.isEmpty ? 'Nada digitado ainda...' : 'Olá, $_nome!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
