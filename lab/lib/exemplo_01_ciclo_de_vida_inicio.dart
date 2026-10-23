// exemplo_01_ciclo_de_vida_inicio.dart
// O ScrollController já vem criado como campo do State e ligado à lista — do
// jeito que a aula anterior montou. Aqui ele vai falhar.
//
// A caixa preta é o painel de log: cada erro escreve nela a mensagem literal do
// framework, sem parafrasear. Os dois botões estão apagados de propósito: os
// métodos que eles chamam entram durante a aula.
//
// ! Dois problemas moram neste arquivo. Um deles já está gritando na caixa preta
// ! assim que o app sobe. O outro não aparece em lugar nenhum — nem agora, nem
// ! depois de abrir e fechar esta tela vinte vezes.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const AppDoController());

class AppDoController extends StatelessWidget {
  const AppDoController({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quando o ScrollController não responde',
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple),
      home: const TelaDoController(),
    );
  }
}

class TelaDoController extends StatefulWidget {
  const TelaDoController({super.key});

  @override
  State<TelaDoController> createState() => _TelaDoControllerState();
}

class _TelaDoControllerState extends State<TelaDoController> {
  final controle = ScrollController();

  // O texto da caixa preta.
  var log = '';

  // Quando vira false, o ListView sai da árvore e o Scrollable chama detach().
  var listaNaArvore = true;

  // Quando vira true, o corpo passa a ser DUAS listas com o MESMO controller.
  var duasListas = false;

  @override
  void initState() {
    super.initState();
    // ! O initState roda ANTES do primeiro build: o ListView ainda não existe,
    // ! então não há nenhuma position para responder pelo offset.
    try {
      log = 'offset no initState = ${controle.offset}';
    } catch (erro) {
      log = 'Ao ler o offset no initState:\n\n$erro';
    }
  }

  // ! Não existe dispose() neste arquivo. O Flutter não vai reclamar.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quando o controller não responde')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                // Os dois onPressed são null: os métodos entram na aula.
                FilledButton.tonal(
                  onPressed: null,
                  child: Text('comandar depois de sair'),
                ),
                FilledButton.tonal(
                  onPressed: null,
                  child: Text('ver duas listas'),
                ),
              ],
            ),
          ),
          _PainelDeLog(texto: log),
          const SizedBox(height: 12),
          Expanded(
            child: duasListas
                // Os dois botões do corpo duplo também nascem apagados.
                ? _CorpoDuasListas(
                    controle: controle,
                    aoLerOffset: null,
                    aoPular: null,
                  )
                : listaNaArvore
                ? ListView.builder(
                    controller: controle,
                    itemExtent: 60,
                    itemCount: 200,
                    itemBuilder: (context, indice) =>
                        ListTile(dense: true, title: Text('Item $indice')),
                  )
                : const Center(child: Text('A lista saiu da árvore.')),
          ),
        ],
      ),
    );
  }
}

// As duas listas dividindo o MESMO controller. A árvore monta sem reclamar.
// Os dois botões chegam apagados: os métodos entram durante a aula.
class _CorpoDuasListas extends StatelessWidget {
  const _CorpoDuasListas({
    required this.controle,
    required this.aoLerOffset,
    required this.aoPular,
  });

  final ScrollController controle;
  final VoidCallback? aoLerOffset;
  final VoidCallback? aoPular;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            spacing: 8,
            children: [
              FilledButton.tonal(
                onPressed: aoLerOffset,
                child: const Text('ler offset'),
              ),
              FilledButton.tonal(
                onPressed: aoPular,
                child: const Text('jumpTo(800)'),
              ),
            ],
          ),
        ),
        Expanded(
          child: _Lista(nome: 'Lista A —', controle: controle),
        ),
        const Divider(height: 1),
        Expanded(
          child: _Lista(nome: 'Lista B —', controle: controle),
        ),
      ],
    );
  }
}

class _Lista extends StatelessWidget {
  const _Lista({required this.nome, required this.controle});

  final String nome;
  final ScrollController controle;

  @override
  Widget build(BuildContext context) => ListView.builder(
    controller: controle,
    itemExtent: 60,
    itemCount: 200,
    itemBuilder: (context, indice) =>
        ListTile(dense: true, title: Text('$nome $indice')),
  );
}

class _PainelDeLog extends StatelessWidget {
  const _PainelDeLog({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    height: 190,
    margin: const EdgeInsets.symmetric(horizontal: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.black87,
      borderRadius: BorderRadius.circular(8),
    ),
    child: SingleChildScrollView(
      child: Text(
        texto,
        style: const TextStyle(
          color: Colors.greenAccent,
          fontFamily: 'monospace',
          fontSize: 11,
        ),
      ),
    ),
  );
}
