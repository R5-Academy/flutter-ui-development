import 'package:material_ui/material_ui.dart';

// A lista de 500 itens da aula passada, com o mesmo espião contando os builds.
//
// Ela funciona: rola liso, constrói só o que aparece. O item tem os mesmos 80px
// da aula passada, e o painel mostra a conta que explica o número:
//
//   construídos = ceil((altura da lista + cacheExtent) / altura do item)
//
// Repare que o painel já fala em COLUNAS e em CÉLULA, com kColunas valendo 1.
// Não é enfeite: uma lista É uma grade de uma coluna só, com a altura da célula
// cravada em 80. É essa a ponte que esta aula atravessa.
//
// A pergunta: e se em vez de uma coluna de itens eu quiser duas por linha?

// A altura do item, cravada — é a mesma da aula 02.
const double kAlturaItem = 80.0;

// Quantas colunas a "grade" tem hoje. Uma lista é uma grade de uma coluna.
const int kColunas = 1;

// null  -> a altura sai da conta largura / childAspectRatio (padrão 1.0).
// 80.0  -> a altura é cravada, igualzinha ao item da lista da aula passada.
// O tipo é double? porque este é o valor que vai virar null quando a lista
// virar grade; é esse null que o painel testa.
// ignore: unnecessary_nullable_for_final_variable_declarations
const double? kAlturaDaCelula = kAlturaItem;

// O cache que o viewport mantém fora da tela, acima e abaixo (padrão do Flutter:
// RenderAbstractViewport.defaultCacheExtent).
const double kCacheExtentPadrao = 250.0;

void main() => runApp(const AppDaPonte());

class AppDaPonte extends StatelessWidget {
  const AppDaPonte({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A ponte: lista vira grade',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const TelaDaPonte(),
    );
  }
}

class TelaDaPonte extends StatelessWidget {
  const TelaDaPonte({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista vira grade')),
      body: Column(
        children: <Widget>[
          const PainelDoContador(),
          // ! Expanded: sem ele, o viewport recebe altura infinita e quebra.
          Expanded(
            // O LayoutBuilder está aqui só para o painel poder mostrar a ALTURA
            // REAL da lista. É ela que define quantos itens ele constrói — sem
            // esse número, o total vira número mágico.
            child: LayoutBuilder(
              builder: (context, constraints) {
                contador.alturaDoViewport = constraints.maxHeight;
                contador.larguraDoViewport = constraints.maxWidth;
                return ListView.builder(
                  itemCount: 500,
                  itemBuilder: (context, indice) {
                    contador.registrarBuild();
                    return SizedBox(
                      height: kAlturaItem,
                      child: Celula(indice: indice),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// O espião: conta os builds e sabe quem está vivo. Mesmo truque das aulas
// anteriores.
class Contador extends ChangeNotifier {
  int _builds = 0;
  final _vivos = <int>{};

  // A altura real do viewport, medida pelo LayoutBuilder. É o que explica o
  // número de builds — não a altura da tela.
  double alturaDoViewport = 0;
  double larguraDoViewport = 0;

  int get builds => _builds;
  int get vivos => _vivos.length;

  void registrarBuild() {
    _builds++;
    // Notifica no fim do frame: não dá para chamar setState durante o build.
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
  }

  void nasceu(int indice) => _vivos.add(indice);
  void morreu(int indice) => _vivos.remove(indice);
}

final contador = Contador();

// A célula é um StatefulWidget para dar para ver o nascimento e a morte.
class Celula extends StatefulWidget {
  const Celula({super.key, required this.indice});

  final int indice;

  @override
  State<Celula> createState() => _CelulaState();
}

class _CelulaState extends State<Celula> {
  @override
  void initState() {
    super.initState();
    contador.nasceu(widget.indice);
  }

  @override
  void dispose() {
    contador.morreu(widget.indice);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.primaries[widget.indice % Colors.primaries.length].shade100,
      child: Center(
        child: Text(
          '${widget.indice}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// O placar ao vivo.
class PainelDoContador extends StatelessWidget {
  const PainelDoContador({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: contador,
      builder: (context, _) {
        final altura = contador.alturaDoViewport;
        // A conta do delegate: a largura desce (é fato), a altura é derivada
        // dela — a não ser que mainAxisExtent crave a altura.
        final larguraDaCelula = contador.larguraDoViewport / kColunas;
        final alturaDaCelula = kAlturaDaCelula ?? larguraDaCelula;
        final linhas = alturaDaCelula == 0
            ? 0
            : ((altura + kCacheExtentPadrao) / alturaDaCelula).ceil();
        return Container(
          width: double.infinity,
          color: Colors.indigo.shade50,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'São 500 itens no total.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text('itemBuilder chamado: ${contador.builds} vezes'),
              Text('Elements vivos agora: ${contador.vivos}'),
              const SizedBox(height: 4),
              Text(
                'viewport: ${altura.toStringAsFixed(0)}px de altura, '
                'célula: ${larguraDaCelula.toStringAsFixed(0)}x'
                '${alturaDaCelula.toStringAsFixed(0)}\n'
                'conta: ceil((${altura.toStringAsFixed(0)} + '
                '${kCacheExtentPadrao.toStringAsFixed(0)}) / '
                '${alturaDaCelula.toStringAsFixed(0)}) x $kColunas = '
                '${linhas * kColunas}',
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}
