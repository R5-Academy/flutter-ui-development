// exemplo_01_promessa_inicio.dart
// A tela que fechou a aula passada: 500 itens dentro de um
// SingleChildScrollView, com um espião contando quantos foram construídos.
//
// Role a lista. Olhe o número no painel.
//
// ! 500 itens declarados. 500 construídos. Meia dúzia aparece na tela.
// ! O painel mostra a altura real da lista, para você conferir a conta.

import 'package:material_ui/material_ui.dart';

const double kAlturaItem = 80.0;
const int kTotal = 500;

void main() => runApp(const AppPromessa());

class AppPromessa extends StatelessWidget {
  const AppPromessa({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '500 itens. Quantos ele constrói?',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const TelaLista(),
    );
  }
}

// O contador conta durante o LAYOUT, então só pode avisar a tela DEPOIS do
// frame — senão vira setState durante o layout, que é erro.
class Contador {
  int total = 0;
  double alturaLista = 0;
  final exibido = ValueNotifier<int>(0);
  final janela = ValueNotifier<double>(0);
  bool congelado = false;

  void registrar() {
    if (congelado) return;
    total++;
  }
}

class TelaLista extends StatefulWidget {
  const TelaLista({super.key});

  @override
  State<TelaLista> createState() => _TelaListaState();
}

class _TelaListaState extends State<TelaLista> {
  final _contador = Contador();

  @override
  void initState() {
    super.initState();
    // Depois do primeiro frame, congela: o número que interessa é
    // "quantos foram construídos para montar a tela".
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _contador.congelado = true;
      _contador.exibido.value = _contador.total;
      _contador.janela.value = _contador.alturaLista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('500 itens. Quantos ele constrói?')),
      body: Column(
        children: [
          _Painel(contador: _contador),
          const Divider(height: 1),
          Expanded(
            // O LayoutBuilder só serve para o painel saber a altura real da
            // lista — é ela que decide quantos itens cabem na tela.
            child: LayoutBuilder(
              builder: (context, constraints) {
                _contador.alturaLista = constraints.maxHeight;
                // ! UM filho, uma Column, 500 filhos dentro. Para medir a
                // ! Column, ele constrói os 500. Sem escolha.
                return SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      kTotal,
                      (i) => _Item(indice: i, contador: _contador),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Painel extends StatelessWidget {
  const _Painel({required this.contador});

  final Contador contador;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: contador.exibido,
      builder: (context, valor, _) {
        final altura = contador.janela.value;
        final cabem = (altura / kAlturaItem).floor();
        return Container(
          width: double.infinity,
          color: Colors.red.shade50,
          padding: const EdgeInsets.all(12),
          child: Text(
            'Itens declarados:  $kTotal\n'
            'Itens CONSTRUÍDOS: $valor\n'
            'Itens visíveis:    ~$cabem   '
            '(lista de ${altura.toStringAsFixed(0)} px)',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
          ),
        );
      },
    );
  }
}

// O espião: registra e repassa.
class _Item extends StatelessWidget {
  const _Item({required this.indice, required this.contador});

  final int indice;
  final Contador contador;

  @override
  Widget build(BuildContext context) {
    contador.registrar();
    return SizedBox(
      height: kAlturaItem,
      child: ListTile(
        leading: CircleAvatar(child: Text('$indice')),
        title: Text('Item $indice'),
        subtitle: const Text('fui construído'),
      ),
    );
  }
}
