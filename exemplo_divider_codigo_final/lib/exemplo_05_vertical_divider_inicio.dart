// exemplo_05_vertical_divider_inicio.dart
// Ponto de partida: as estatísticas de um perfil lado a lado, separadas por
// `VerticalDivider` — a versão vertical do que a aula fez até agora.
//
// ! Rode. O card, que deveria abraçar as três estatísticas numa faixa de umas 90
// ! unidades de altura, ESTICOU até ocupar a tela inteira. As divisórias viraram
// ! dois riscos gigantes de cima a baixo. Medido numa tela de 400x800: o card
// ! vai de 93 para 744, e cada divisória de 53 para 704.
//
// ? Por quê? Pense em como o `VerticalDivider` descobre a própria altura. Ele
// ? não descobre: o widget é um `SizedBox(width: ...)` que fixa só a LARGURA e
// ? não diz nada sobre a altura. Quem decide é o pai. E o pai aqui é uma `Row`,
// ? que não impõe altura nenhuma aos filhos — ela só repassa a altura que ela
// ? mesma recebeu, que é a tela inteira. O Divider então preenche tudo.
//
// ! Repare no que NÃO aconteceu: nenhuma exceção, nenhum aviso vermelho. O
// ! layout está "certo" para o Flutter — é só a nossa intenção que se perdeu.
//
// Falta alguém dizer à Row qual é a altura dela.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: EstatisticasPerfil()));

class EstatisticasPerfil extends StatelessWidget {
  const EstatisticasPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('VerticalDivider')),
      body: const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _Stat(numero: '128', rotulo: 'Posts'),
                  VerticalDivider(width: 32, thickness: 1),
                  _Stat(numero: '3.4k', rotulo: 'Seguidores'),
                  VerticalDivider(width: 32, thickness: 1),
                  _Stat(numero: '291', rotulo: 'Seguindo'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.numero, required this.rotulo});

  final String numero;
  final String rotulo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          numero,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          rotulo,
          style: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
        ),
      ],
    );
  }
}
