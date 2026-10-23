// exemplo_05_asset_e_network_inicio.dart
// Ponto de partida: a vitrine da loja, juntando tudo o que a aula construiu —
// banner no topo, card com a foto do produto, fit, loading e error tratados.
//
// ! Só que tem uma decisão errada aqui, e ela não é de layout. Rode com o wi-fi
// ! desligado (ou modo avião): o card do produto cai no fallback, tudo bem — a
// ! foto vem do catálogo, é natural que dependa da rede.
//
// ! Mas o BANNER da loja também some. E o banner nunca muda: é a identidade
// ! visual do app, a mesma imagem em toda instalação, em toda abertura. Mesmo
// ! online, ele pisca no spinner toda vez que a tela abre.
//
// ? Por que uma imagem que faz parte do app está sendo baixada da internet?

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: VitrineDaLoja()));

class VitrineDaLoja extends StatelessWidget {
  const VitrineDaLoja({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text('Vitrine')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ! O banner fixo da loja, vindo da rede.
          Image.asset(
            'assets/images/welcome_bg.png',
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,

            errorBuilder: (context, error, stackTrace) => SizedBox(
              height: 120,
              child: ColoredBox(
                color: Colors.grey.shade300,
                child: const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const _CardDoProduto(),
        ],
      ),
    );
  }
}

class _CardDoProduto extends StatelessWidget {
  const _CardDoProduto();

  @override
  Widget build(BuildContext context) {
    return Card(
      // clipBehavior recorta os filhos no raio do próprio Card — é o ClipRRect
      // do bloco anterior, já embutido.
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A foto do produto vem do catálogo. Num app real, esta URL chega do
          // backend junto com o nome e o preço.
          Image.network(
            'https://picsum.photos/280/180',
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const SizedBox(
                height: 180,
                child: Center(child: CircularProgressIndicator()),
              );
            },
            errorBuilder: (context, error, stackTrace) => SizedBox(
              height: 180,
              child: ColoredBox(
                color: Colors.grey.shade300,
                child: const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tênis de corrida',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(r'R$ 299,90', style: TextStyle(color: Colors.teal)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
