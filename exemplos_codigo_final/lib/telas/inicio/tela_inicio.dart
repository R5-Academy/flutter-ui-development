import 'package:flutter/material.dart';

import '../../app/tema/cores_do_app.dart';
import '../../modelos/dado_de_resumo.dart';
import '../../widgets/titulo_da_secao.dart';
import 'widgets/cartao_de_resumo.dart';

// * A tela do destino Início. Repare que ela NÃO tem Scaffold: quem tem a
// * moldura é a TelaPrincipal. Um Scaffold por tela — aqui só entra o conteúdo
// * do slot body.
class TelaInicio extends StatelessWidget {
  const TelaInicio({super.key});

  static const _resumo = <DadoDeResumo>[
    DadoDeResumo(
      icone: Icons.description_outlined,
      cor: CoresDoApp.azul,
      valor: '12',
      rotulo: 'Itens',
    ),
    DadoDeResumo(
      icone: Icons.notifications_outlined,
      cor: CoresDoApp.verde,
      valor: '5',
      rotulo: 'Notificações',
    ),
    DadoDeResumo(
      icone: Icons.person_outline,
      cor: CoresDoApp.roxo,
      valor: '3',
      rotulo: 'Mensagens',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // O body do Scaffold não rola sozinho. O ListView aqui é a mesma receita do
    // menu lateral — rolagem tem aula própria na próxima seção.
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Image.asset('assets/montanha.png'),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: .max,
            children: [
              TituloDaSecao(
                titulo: 'Página Inicial',
                descricao:
                    'Bem-vindo à página inicial! Aqui você pode colocar '
                    'um resumo do seu aplicativo.',
              ),
              SizedBox(height: 20),
              CartaoDeResumo(dados: _resumo),
            ],
          ),
        ),
      ],
    );
  }
}
