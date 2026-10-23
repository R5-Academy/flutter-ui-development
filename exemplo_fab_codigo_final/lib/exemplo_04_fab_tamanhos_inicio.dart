// exemplo_04_fab_tamanhos_inicio.dart
// Ponto de partida: um app de notas. A lista enche a tela até embaixo e o FAB
// de criar uma nova está no tamanho padrão.
//
// ! Olhe a nota que encosta no rodapé. O FAB está por cima dela — medido numa
// ! tela de 400x800, o FAB ocupa de y=728 a y=784 e a nota que está ali embaixo
// ! vai de y=728 a y=784 também. Ele cobre o ícone e parte do texto. Numa tela
// ! densa como esta, cheia de conteúdo até a borda, um botão de 56 px lógicos é
// ! muito.
//
// ? Duas perguntas, então. O FAB tem um único tamanho? E de quem é a
// ? responsabilidade de deixar o conteúdo respirar embaixo?

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: FabTamanhos()));

class FabTamanhos extends StatelessWidget {
  const FabTamanhos({super.key});

  static const _notas = [
    'Comprar café em grãos',
    'Revisar o orçamento de março',
    'Ligar para a transportadora',
    'Renovar o certificado do app',
    'Fechar a proposta do cliente novo',
    'Conferir o relatório de vendas',
    'Responder o e-mail do fornecedor',
    'Agendar a manutenção do servidor',
    'Atualizar a apresentação da reunião',
    'Pagar a assinatura das ferramentas',
    'Revisar o contrato do freelancer',
    'Organizar as fotos do evento',
    'Fazer backup do banco de dados',
    'Comprar passagem para o congresso',
    'Confirmar o almoço de quinta',
    'Cancelar o plano antigo do celular',
    'Levar o notebook na assistência',
    'Escrever o resumo do trimestre',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notas')),
      body: ListView(
        children: [
          for (final nota in _notas)
            ListTile(leading: const Icon(Icons.notes), title: Text(nota)),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        tooltip: 'Nova nota',
        child: const Icon(Icons.add, size: 15),
      ),
    );
  }
}
