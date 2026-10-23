// exemplo_02_tree_shaking_inicio.dart
// Ponto de partida: a lista de seções vem do backend. Cada item traz o título e
// uma chave de ícone ('wifi', 'bluetooth'...), e a tela traduz essa chave para
// um code point antes de desenhar.
//
// Roda em debug, roda no `flutter run`, e os quatro ícones aparecem certos.
//
// ! O problema não aparece rodando. Aparece no build de release:
// !   flutter build web --release \
// !     -t lib/03-flutter-ui-development/06-componentes-visuais/04-icon/exemplo_02_tree_shaking_inicio.dart
// ! Rode o comando e leia a mensagem inteira antes de abrir o `_completo`.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaDeConfiguracoes()));

// Simula a resposta do backend. É uma função (e não uma constante) de
// propósito: numa app de verdade estes dados chegam pela rede, e só existem
// depois que o app já está rodando.
List<Map<String, String>> buscarSecoes() => [
  {'titulo': 'Wi-Fi', 'icone': 'wifi'},
  {'titulo': 'Bluetooth', 'icone': 'bluetooth'},
  {'titulo': 'Bateria', 'icone': 'battery_full'},
  {'titulo': 'Segurança', 'icone': 'security'},
];

// A tabela de code points, copiada do catálogo de ícones.
const codigosDosIcones = {
  'wifi': 0xe6e7,
  'bluetooth': 0xe0e4,
  'battery_full': 0xe0d2,
  'security': 0xe569,
};

class TelaDeConfiguracoes extends StatelessWidget {
  const TelaDeConfiguracoes({super.key});

  @override
  Widget build(BuildContext context) {
    final secoes = buscarSecoes();
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: Column(
        children: [
          for (final secao in secoes)
            _ItemDeSecao(
              titulo: secao['titulo']!,
              chaveDoIcone: secao['icone']!,
            ),
        ],
      ),
    );
  }
}

class _ItemDeSecao extends StatelessWidget {
  const _ItemDeSecao({required this.titulo, required this.chaveDoIcone});

  final String titulo;
  final String chaveDoIcone;

  @override
  Widget build(BuildContext context) {
    // ! Esta linha é o problema: o code point só é conhecido rodando, então
    // ! este `IconData` não é `const`. O analisador já avisa — quem está
    // ! segurando o aviso é o `// ignore:` de baixo. Apague-o e leia:
    // !   warning • Argument 'codePoint' must be a constant. Try replacing the
    // !   argument with a constant • non_const_argument_for_const_parameter
    final icone = IconData(
      // ignore: non_const_argument_for_const_parameter
      codigosDosIcones[chaveDoIcone] ?? 0xe000,
      fontFamily: 'MaterialIcons',
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(icone, size: 24, color: Colors.blueGrey),
          const SizedBox(width: 16),
          Text(titulo, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
