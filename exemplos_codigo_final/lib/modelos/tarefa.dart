// * O modelo é imutável: para marcar uma tarefa como concluída não se altera o
// * objeto, cria-se outro. Quem manda no estado é a tela, com setState.
class Tarefa {
  const Tarefa({
    required this.titulo,
    required this.descricao,
    this.concluida = false,
  });

  final String titulo;
  final String descricao;
  final bool concluida;

  Tarefa alternarConclusao() => Tarefa(
    titulo: titulo,
    descricao: descricao,
    concluida: !concluida,
  );
}
