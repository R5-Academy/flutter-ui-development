import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// * Rodada 2: refinar as nuances que a rodada 1 levantou.

const double kAlturaItem = 80.0;

int gWidgetsCriados = 0;
int gBuilds = 0;
int gMontados = 0;

class Espiao extends StatefulWidget {
  Espiao({super.key, required this.indice}) {
    // ! Conta a CRIAÇÃO do objeto Widget (o construtor rodando).
    gWidgetsCriados++;
  }
  final int indice;

  @override
  State<Espiao> createState() => _EspiaoState();
}

class _EspiaoState extends State<Espiao> {
  @override
  void initState() {
    super.initState();
    gMontados++; // ! Element montado de verdade
  }

  @override
  Widget build(BuildContext context) {
    gBuilds++;
    return SizedBox(height: kAlturaItem, child: Text('Item ${widget.indice}'));
  }
}

void zerar() {
  gWidgetsCriados = 0;
  gBuilds = 0;
  gMontados = 0;
}

Widget envolver(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  const int kTotal = 500;

  testWidgets('NUANCE A: ListView(children:) — widgets criados vs montados', (
    tester,
  ) async {
    zerar();
    await tester.pumpWidget(
      envolver(
        ListView(children: List.generate(kTotal, (i) => Espiao(indice: i))),
      ),
    );
    debugPrint(
      '### ListView(children:): widgetsCriados=$gWidgetsCriados '
      'ELEMENTS montados=$gMontados builds=$gBuilds',
    );

    zerar();
    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(
      envolver(
        ListView.builder(
          itemCount: kTotal,
          itemBuilder: (c, i) => Espiao(indice: i),
        ),
      ),
    );
    debugPrint(
      '### ListView.builder:   widgetsCriados=$gWidgetsCriados '
      'ELEMENTS montados=$gMontados builds=$gBuilds',
    );

    zerar();
    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(
      envolver(
        SingleChildScrollView(
          child: Column(
            children: List.generate(kTotal, (i) => Espiao(indice: i)),
          ),
        ),
      ),
    );
    debugPrint(
      '### SCSV+Column:       widgetsCriados=$gWidgetsCriados '
      'ELEMENTS montados=$gMontados builds=$gBuilds',
    );
  });
}
