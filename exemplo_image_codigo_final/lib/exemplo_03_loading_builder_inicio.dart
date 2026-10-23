// exemplo_03_loading_builder_inicio.dart
// Ponto de partida: duas fotos de network, as duas já com o `errorBuilder` que
// a gente escreveu no primeiro bloco. A de baixo tem URL quebrada de propósito
// e cai no fallback — isso já está resolvido.
//
// ! O problema agora é a de cima. Dê um hot restart e olhe o espaço dela: por
// ! um instante não tem NADA ali. Um buraco branco no meio da tela.
//
// ! Aqui, no wi-fi do escritório, o buraco dura um piscar de olhos. No 3G do
// ! usuário ele dura segundos — e segundos de tela vazia parecem app travado.
//
// Falta avisar que a imagem está vindo.

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: FotosDaGaleria()));

class FotosDaGaleria extends StatelessWidget {
  const FotosDaGaleria({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fotos da galeria')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Uma URL que carrega:'),
            SizedBox(height: 8),
            // O picsum já devolve uma foto diferente a cada requisição. O
            // ?random=1 serve para diferenciar a URL de outras da mesma tela —
            // a URL é a chave do cache de imagens do Flutter, então duas
            // iguais viram um download só.
            _Foto(url: 'https://picsum.photos/4500/1300?random=1'),
            SizedBox(height: 24),
            Text('Uma URL quebrada:'),
            SizedBox(height: 8),
            _Foto(url: 'https://picsum.photos/esse-caminho-nao-existe'),
          ],
        ),
      ),
    );
  }
}

class _Foto extends StatelessWidget {
  const _Foto({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: 300,
      height: 180,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        final total = loadingProgress.expectedTotalBytes;
        final baixado = loadingProgress.cumulativeBytesLoaded;

        return SizedBox(
          width: 300,
          height: 180,
          child: Center(
            child: CircularProgressIndicator(
              value: total != null ? baixado / total : null,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => SizedBox(
        width: 300,
        height: 180,
        child: ColoredBox(
          color: Colors.red.withValues(alpha: 0.08),
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.broken_image, color: Colors.red, size: 40),
                SizedBox(height: 8),
                Text('Não foi possível carregar'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
