// exemplo_01_textbutton_basico_inicio.dart
// Ponto de partida: um aviso de política de privacidade, com duas ações.
//
// ! "Aceitar" é a ação principal — e "Saiba mais" está com exatamente o mesmo
// ! peso. Dois botões preenchidos, um do lado do outro, disputando o olhar por
// ! uma decisão que não é disputa nenhuma.
//
// ! "Saiba mais" é acessório: a maioria das pessoas nunca vai tocar nele, e
// ! quem quiser vai procurar. Ele precisa estar disponível, não visível.
//
// O `.tonal` da aula passada baixaria um degrau na régua —
// mas ainda é um botão
// preenchido. Aqui a gente precisa de menos que isso.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TextButtonBasico()));

class TextButtonBasico extends StatelessWidget {
  const TextButtonBasico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacidade')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Usamos cookies para melhorar a sua experiência.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ! Ação acessória com peso de ação principal.
                  TextButton(
                    onPressed: () => debugPrint('tocou em Saiba mais'),
                    child: const Text('Saiba mais'),
                  ),

                  TextButton(onPressed: null, child: const Text('Saiba mais')),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: () => debugPrint('aceitou'),
                    child: const Text('Aceitar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
