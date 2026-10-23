import 'package:flutter/material.dart';

import '../../modelos/destino.dart';
import '../inicio/tela_inicio.dart';
import '../perfil/tela_perfil.dart';
import '../tarefas/tela_tarefas.dart';
import 'widgets/barra_de_navegacao.dart';
import 'widgets/menu_lateral.dart';

// * A moldura do app: um Scaffold só, com os quatro slots da seção preenchidos.
// * Quem troca de destino é esta tela — o menu lateral e a barra de baixo
// * apenas avisam qual destino foi tocado.
class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  Destino _destino = .inicio;

  void _selecionarDestino(Destino destino) {
    setState(() => _destino = destino);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // O ☰ aparece sozinho porque existe um drawer pendurado no Scaffold.
      appBar: AppBar(title: const Text('Minha App')),
      drawer: MenuLateral(
        destinoAtivo: _destino,
        aoSelecionarDestino: _selecionarDestino,
      ),
      // * IndexedStack: as três telas existem ao mesmo tempo e só a do índice
      // * é pintada. Por isso as tarefas marcadas continuam marcadas quando o
      // * usuário sai da aba e volta.
      // ! O preço: todas são construídas de cara, mesmo as que ninguém abriu.
      body: IndexedStack(
        // A ordem aqui tem que ser a mesma do enum Destino.
        index: _destino.index,
        children: const [TelaInicio(), TelaTarefas(), TelaPerfil()],
      ),
      bottomNavigationBar: BarraDeNavegacao(
        destinoAtivo: _destino,
        aoSelecionarDestino: _selecionarDestino,
      ),
    );
  }
}
