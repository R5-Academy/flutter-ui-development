// exemplo_01_03_nuance_pai_finito.dart
// PASSO 4 DE 4 — a prova de que a flag nunca foi o vilão.
//
// A lista abaixo tem shrinkWrap: true, exatamente como no passo 2. A mesma
// flag, os mesmos 500 itens.
//
// A única diferença é o pai: em vez de uma Column dentro de um
// SingleChildScrollView (altura infinita), ela está dentro de um
// SizedBox(height: 400) — altura FINITA.
//
// ! Olhe o painel: o número de itens construídos NÃO é 500.
//
// Por quê: com um teto de 400 px chegando de cima, "encolher até o tamanho do
// conteúdo" vira "encolher até 400, porque é o máximo que eu posso ocupar". A
// lista não precisa medir os 500 itens para descobrir isso — basta ir
// somando altura até bater no teto e parar. E parar de medir é parar de
// construir.
//
// A conclusão que fecha o bloco:
//
//   O que mata o lazy é a ALTURA INFINITA, não o shrinkWrap.
//
// O shrinkWrap só ficou com a fama porque ele é justamente a flag que as
// pessoas ligam quando estão com altura infinita nas mãos — ele é a
// testemunha que aparece em toda cena do crime, não o criminoso.

import 'package:flutter/material.dart';

import 'painel_diagnostico.dart';

void main() => runApp(const AppNuance());

class AppNuance extends StatelessWidget {
  const AppNuance({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shrinkWrap com pai finito',
      theme: ThemeData(colorSchemeSeed: Colors.orange),
      home: const TelaNuance(),
    );
  }
}

class TelaNuance extends StatefulWidget {
  const TelaNuance({super.key});

  @override
  State<TelaNuance> createState() => _TelaNuanceState();
}

class _TelaNuanceState extends State<TelaNuance> {
  final _diagnostico = Diagnostico(quemFazARolagem: 'a própria lista');

  @override
  void initState() {
    super.initState();
    _diagnostico.comecar();
  }

  @override
  void dispose() {
    _diagnostico.descartar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('shrinkWrap + pai finito')),
      body: Column(
        children: [
          PainelDiagnostico(diagnostico: _diagnostico),
          // O teto de 400 px é tudo o que muda em relação ao passo 2.
          Expanded(
            child: EspiaoDeAltura(
              diagnostico: _diagnostico,
              builder: (context) => ListView.builder(
                // A MESMA flag do passo 2, e aqui ela não faz mal nenhum.
                // shrinkWrap: true,
                itemCount: kTotal,
                itemBuilder: (context, index) =>
                    ItemDaLista(indice: index, diagnostico: _diagnostico),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
