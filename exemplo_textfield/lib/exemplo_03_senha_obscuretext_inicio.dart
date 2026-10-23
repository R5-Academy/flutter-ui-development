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

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: CampoSenha()));

class CampoSenha extends StatelessWidget {
  const CampoSenha({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('obscureText')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: TextField(
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            labelText: 'Senha',
            hintText: 'Digite sua senha',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
