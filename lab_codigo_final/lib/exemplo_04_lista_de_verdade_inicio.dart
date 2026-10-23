// exemplo_04_lista_de_verdade_inicio.dart
// Uma agenda de contatos: 2000 pessoas numa lista.
//
// O modelo já vem pronto (nome, cargo, iniciais e cor), e os dados já estão
// montados. A lista rola liso, mesmo com dois mil itens.
//
// O que falta: uma busca, um divisor entre os itens e o teclado que abaixa
// sozinho quando você começa a rolar.

import 'package:flutter/material.dart';

void main() => runApp(const AppContatos());

class AppContatos extends StatelessWidget {
  const AppContatos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contatos',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const TelaContatos(),
    );
  }
}

// O modelo. O `iniciais` já vem pronto, calculado uma vez só.
class Contato {
  const Contato({
    required this.nome,
    required this.cargo,
    required this.iniciais,
    required this.cor,
  });

  final String nome;
  final String cargo;
  final String iniciais;
  // MaterialColor (e não Color) porque usamos os tons .shade100/.shade900.
  final MaterialColor cor;
}

// Os dados. Numa vida real vêm de uma API ou de um banco.
final List<Contato> kContatos = .generate(2000, (i) {
  const nomes = ['Ana', 'Bruno', 'Carla', 'Diego', 'Elisa', 'Felipe', 'Gabi'];
  const cargos = [
    'Desenvolvedora Flutter',
    'Designer de produto',
    'Analista de dados',
    'Gerente de projeto',
  ];
  const cores = <MaterialColor>[
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];
  final nome =
      '${nomes[i % nomes.length]} ${String.fromCharCode(65 + i % 26)}.';
  return Contato(
    nome: nome,
    cargo: cargos[i % cargos.length],
    iniciais: nome[0],
    cor: cores[i % cores.length],
  );
});

class TelaContatos extends StatefulWidget {
  const TelaContatos({super.key});

  @override
  State<TelaContatos> createState() => _TelaContatosState();
}

class _TelaContatosState extends State<TelaContatos> {
  var _busca = '';

  @override
  Widget build(BuildContext context) {
    final filtrados = _busca.isEmpty
        ? kContatos
        : kContatos
              .where((c) => c.nome.toLowerCase().contains(_busca.toLowerCase()))
              .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos (${filtrados.length})'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const .fromLTRB(12, 0, 12, 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar contato ...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() {
                _busca = v;
              }),
            ),
          ),
        ),
      ),
      body: filtrados.isEmpty
          ? Center(child: Text('Ninguem com esse nome'))
          : ListView.separated(
              separatorBuilder: (context, index) => Divider(height: 1),
              padding: const EdgeInsets.symmetric(vertical: 8),
              // itemCount sempre sai dos dados, nunca de um número digitado.
              itemCount: filtrados.length,
              itemBuilder: (context, index) =>
                  _LinhaContato(contato: filtrados[index]),
            ),
    );
  }
}

class _LinhaContato extends StatelessWidget {
  const _LinhaContato({required this.contato});
  final Contato contato;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: contato.cor.shade100,
        foregroundColor: contato.cor.shade900,
        child: Text(
          contato.iniciais,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(contato.nome),
      subtitle: Text(contato.cargo),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(contato.nome),
            duration: const Duration(milliseconds: 600),
          ),
        );
      },
    );
  }
}
