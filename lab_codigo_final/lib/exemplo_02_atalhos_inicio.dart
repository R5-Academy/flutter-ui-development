// exemplo_02_atalhos_inicio.dart
// Quatro abas, quatro grades — e as quatro estão escritas do MESMO jeito: o
// construtor cru do GridView, com o delegate instanciado na mão e os 500 filhos
// prontos numa lista.
//
// A aba 3 é a única que muda de cara: o delegate dela é o de largura máxima
// (200 px por coluna), não o de contagem fixa.
//
// O placar separa duas coisas: quantos objetos Widget foram criados na mão, e
// quantos Elements estão vivos de verdade.
//
// ! Olhe o primeiro número do painel, aba por aba.

import 'package:flutter/material.dart';

const int kTotal = 500;

void main() => runApp(const AppDosAtalhos());

class AppDosAtalhos extends StatelessWidget {
  const AppDosAtalhos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Os atalhos do GridView',
      theme: ThemeData(colorSchemeSeed: Colors.green),
      home: const TelaDosAtalhos(),
    );
  }
}

/// As quatro maneiras de pedir a mesma grade de 500 células.
enum FormaDaGrade {
  original('GridView'),
  count('.count'),
  extent('.extent'),
  builder('.builder');

  const FormaDaGrade(this.rotulo);

  final String rotulo;
}

class TelaDosAtalhos extends StatefulWidget {
  const TelaDosAtalhos({super.key});

  @override
  State<TelaDosAtalhos> createState() => _TelaDosAtalhosState();
}

class _TelaDosAtalhosState extends State<TelaDosAtalhos> {
  FormaDaGrade _forma = .original;

  // Trocar de aba joga a grade antiga fora e monta outra do zero. O placar
  // zera junto para que os números sejam sempre os DESTA aba.
  void _trocarDeForma(Set<FormaDaGrade> escolha) {
    placar.zerar();
    setState(() => _forma = escolha.first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quatro jeitos, uma grade')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: SegmentedButton<FormaDaGrade>(
              showSelectedIcon: false,
              style: SegmentedButton.styleFrom(
                visualDensity: VisualDensity.compact,
                textStyle: const TextStyle(fontSize: 12),
              ),
              segments: <ButtonSegment<FormaDaGrade>>[
                for (final forma in FormaDaGrade.values)
                  ButtonSegment<FormaDaGrade>(
                    value: forma,
                    label: Text(forma.rotulo),
                  ),
              ],
              selected: <FormaDaGrade>{_forma},
              onSelectionChanged: _trocarDeForma,
            ),
          ),
          const PainelDoPlacar(total: kTotal),
          Expanded(
            child: switch (_forma) {
              FormaDaGrade.original => const _GradeOriginal(),
              FormaDaGrade.count => const _GradeCount(),
              FormaDaGrade.extent => const _GradeExtent(),
              FormaDaGrade.builder => const _GradeBuilder(),
            },
          ),
        ],
      ),
    );
  }
}

// O construtor cru: você mesmo instancia o delegate e você mesmo entrega a
// lista de filhos. É assim que as QUATRO abas começam.
class _GradeOriginal extends StatelessWidget {
  const _GradeOriginal();

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      children: List<Widget>.generate(kTotal, (indice) {
        placar.widgetCriado();
        return Celula(indice: indice);
      }),
    );
  }
}

// Mesma grade da aba anterior, escrita do mesmo jeito: três colunas pedidas ao
// delegate na mão.
class _GradeCount extends StatelessWidget {
  const _GradeCount();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List<Widget>.generate(kTotal, (indice) {
        placar.widgetCriado();
        return Celula(indice: indice);
      }),
    );
  }
}

// A mesma grade com o OUTRO delegate: em vez de "três colunas", "no máximo 200
// px por coluna". Continua o construtor cru.
class _GradeExtent extends StatelessWidget {
  const _GradeExtent();

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 200,
      children: List<Widget>.generate(kTotal, (indice) {
        placar.widgetCriado();
        return Celula(indice: indice);
      }),
    );
  }
}

// De novo a grade de três colunas do construtor cru — e é a última vez que os
// 500 filhos vêm prontos numa lista.
class _GradeBuilder extends StatelessWidget {
  const _GradeBuilder();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: kTotal,
      itemBuilder: (context, index) {
        placar.widgetCriado();
        return Celula(indice: index);
      },
    );
  }
}

// Placar: separa o que é WIDGET criado do que é ELEMENT montado. É a distinção
// que Keys (Foundations) plantou — a planta é barata, o capataz é caro.
class Placar extends ChangeNotifier {
  int widgetsCriados = 0;
  int buildsDoItemBuilder = 0;
  int elementsVivos = 0;

  void widgetCriado() => widgetsCriados++;
  void itemBuilderChamado() => buildsDoItemBuilder++;

  // Os Elements se equilibram sozinhos: cada nascimento tem uma morte. Só a
  // contagem de criação é que precisa recomeçar a cada aba.
  void zerar() {
    widgetsCriados = 0;
    buildsDoItemBuilder = 0;
    notifyListeners();
  }

  void elementNasceu() {
    elementsVivos++;
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
  }

  void elementMorreu() {
    elementsVivos--;
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
  }
}

final placar = Placar();

// O painel serve às quatro abas sozinho: a nota sai do PRÓPRIO placar. Se algum
// Widget nasceu na mão, foi o children; se o itemBuilder rodou, foi o builder.
// Nada aqui é editado ao vivo.
class PainelDoPlacar extends StatelessWidget {
  const PainelDoPlacar({super.key, required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.green.shade50,
      padding: const EdgeInsets.all(12),
      child: ListenableBuilder(
        listenable: placar,
        builder: (context, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Total de itens: $total'),
            Text(
              'Widgets instanciados na mão: ${placar.widgetsCriados}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: placar.widgetsCriados > 0
                    ? Colors.red.shade700
                    : Colors.green.shade700,
              ),
            ),
            Text('itemBuilder chamado: ${placar.buildsDoItemBuilder}'),
            Text('Elements vivos: ${placar.elementsVivos}'),
            const SizedBox(height: 6),
            Text(_nota, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  String get _nota {
    if (placar.widgetsCriados > 0) {
      return 'children: a lista inteira foi criada ANTES de chegar na grade. '
          'Os ${placar.widgetsCriados} objetos existem, aparecendo ou não.';
    }
    if (placar.buildsDoItemBuilder > 0) {
      return 'itemBuilder: nenhum Widget nasceu na mão. A receita é chamada só '
          'para quem aparece.';
    }
    // Só aparece no primeiro frame: o painel é construído antes da grade.
    return 'Contando as células desta aba…';
  }
}

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
    placar.elementNasceu();
  }

  @override
  void dispose() {
    placar.elementMorreu();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.primaries[widget.indice % Colors.primaries.length].shade100,
      child: Center(child: Text('${widget.indice}')),
    );
  }
}
