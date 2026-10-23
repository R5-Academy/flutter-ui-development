// exemplo_03_filled_vs_elevated_inicio.dart
// Ponto de partida: o card de um hotel, com a foto de capa e o botão de reserva
// POR CIMA da imagem.
//
// O botão é um `FilledButton` — a ação principal, como a aula vem dizendo.
//
// ! Só que aqui a cor deixa de resolver. O fundo é ESTAMPADO: tem todas as
// ! cores, inclusive tons parecidos com o do próprio botão. A borda do botão
// ! briga com o que está atrás, e não dá para saber de relance onde a foto
// ! termina e o botão começa.
//
// ? O FilledButton se destaca pela COR. E quando o fundo também é colorido?
//
// Existe um caso em que o botão da aula anterior é a escolha certa — e é este.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: FilledVsElevated()));

class FilledVsElevated extends StatelessWidget {
  const FilledVsElevated({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hotel')),
      body: Center(
        child: SizedBox(
          width: 320,
          height: 200,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://picsum.photos/id/1015/640/400',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const FundoEstampado(),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: FilledButton(
                    onPressed: () => debugPrint('Reservar'),
                    child: const Text('Reservar'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Fundo de reserva para quando não houver internet.
//
// ! Ele não é uma cor lisa de propósito. O exemplo inteiro depende de o fundo
// ! ser ESTAMPADO; um retângulo de cor única faria o botão aparecer lindamente e
// ! contaria a história ao contrário.
class FundoEstampado extends StatelessWidget {
  const FundoEstampado({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF00695C),
            Color(0xFFFFB300),
            Color(0xFF6750A4),
            Color(0xFFEF5350),
            Color(0xFF283593),
          ],
        ),
      ),
      child: GridPaper(
        color: Color(0x55FFFFFF),
        interval: 40,
        divisions: 1,
        subdivisions: 1,
      ),
    );
  }
}
