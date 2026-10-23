// exemplo_03_detalhe_reflui_inicio.dart
// Ponto de partida: a tela de detalhe de produto no layout de celular —
// imagem em cima, ficha e botão embaixo, tudo numa coluna rolável.
//
// Funciona bem no celular em pé. Rode no desktop e alargue a janela até uns
// 1280px: a imagem vira uma faixa larguíssima de 260px de altura e o título da
// ficha se estica por 437px de linha. Nenhum dos dois fica bom — e repare que
// nada "quebra": não há overflow, não há erro. Só fica ruim.
//
// Este é o capstone da seção: juntar tudo para a tela refluir sozinha.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaDetalheProduto()));

class TelaDetalheProduto extends StatelessWidget {
  const TelaDetalheProduto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhe do produto')),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 260, child: _Imagem()),
              Padding(padding: EdgeInsets.all(16), child: _Ficha()),
            ],
          ),
        ),
      ),
    );
  }
}

class _Imagem extends StatelessWidget {
  const _Imagem();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo.withValues(alpha: 0.7),
            Colors.indigo.withValues(alpha: 0.25),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Center(
        child: Icon(Icons.headphones, size: 96, color: Colors.white),
      ),
    );
  }
}

class _Ficha extends StatelessWidget {
  const _Ficha();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fone Bluetooth ANC',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          r'R$ 499,90',
          style: TextStyle(
            fontSize: 20,
            color: Colors.indigo,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Cancelamento de ruído ativo, até 30 horas de bateria e conexão '
          'multiponto. O mesmo conteúdo desta ficha aparece nos dois layouts; '
          'muda apenas onde ele fica em relação à imagem.',
          style: TextStyle(height: 1.4),
        ),
        const SizedBox(height: 24),
        // Botão montado como Container estilizado (os widgets de botão do
        // Material vêm mais para a frente no curso).
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Adicionar ao carrinho',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
