// exemplo_03_senha_obscuretext_inicio.dart
// Ponto de partida: o campo de senha do login. Ele já tem o teclado certo
// (`visiblePassword`) e a borda desenhada.
//
// ! Digite uma senha e olhe para a tela: ela está lá, em texto puro, legível
// ! por qualquer pessoa ao lado — no ônibus, na fila, na chamada de vídeo em que
// ! você esqueceu de parar de compartilhar a tela.
//
// Todo campo de senha do mundo esconde o que se digita. E, como esconder
// atrapalha na hora de conferir, todo campo de senha bom também oferece um jeito
// de espiar.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CampoSenha()));

class CampoSenha extends StatefulWidget {
  const CampoSenha({super.key});

  @override
  State<CampoSenha> createState() => _CampoSenhaState();
}

class _CampoSenhaState extends State<CampoSenha> {
  var _senhaEscondida = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('obscureText')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: TextField(
          obscureText: _senhaEscondida,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            labelText: 'Senha',
            hintText: 'Digite sua senha',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _senhaEscondida = !_senhaEscondida;
                });
              },
              tooltip: _senhaEscondida ? 'Mostrar Senha' : 'Ocultar Senha',
              icon: Icon(
                _senhaEscondida ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
