// exemplo_05_onsubmitted_inicio.dart
// Ponto de partida: uma lista de tarefas. Digite no campo, toque em "Adicionar",
// e a tarefa entra na lista. Funciona.
//
// ! Agora faça isso **no celular**, com o teclado aberto, cinco vezes seguidas:
// !
// !   digita -> tira a mão do teclado -> mira no botão -> toca -> volta pro
// !   campo
// !
// ! A cada tarefa, o polegar percorre a tela inteira. E a tecla de confirmar do
// ! teclado, que está bem debaixo do dedo, não faz nada.
//
// ? A pessoa já está dizendo "terminei" ao apertar essa tecla. Dá para escutar
// ? isso?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: ListaDeTarefas()));

class ListaDeTarefas extends StatefulWidget {
  const ListaDeTarefas({super.key});

  @override
  State<ListaDeTarefas> createState() => _ListaDeTarefasState();
}

class _ListaDeTarefasState extends State<ListaDeTarefas> {
  final List<String> _tarefas = [];

  // Um controller só para conseguir limpar o campo depois de adicionar. Ele é o
  // tema da próxima aula; aqui aparece de leve, só pelo `.clear()`.
  final _controller = TextEditingController();

  void _adicionar(String texto) {
    final tarefa = texto.trim();
    if (tarefa.isEmpty) return;
    setState(() {
      _tarefas.add(tarefa);
      _controller.clear();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('onSubmitted')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Nova tarefa',
                hintText: 'Digite e use o botão',
                prefixIcon: Icon(Icons.add_task),
              ),
            ),
            const SizedBox(height: 12),
            // ! O único jeito de adicionar: tirar a mão do teclado e vir aqui.
            ElevatedButton(
              onPressed: () => _adicionar(_controller.text),
              child: const Text('Adicionar'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _tarefas.isEmpty
                  ? const Center(child: Text('Nenhuma tarefa ainda.'))
                  : ListView.builder(
                      itemCount: _tarefas.length,
                      itemBuilder: (context, i) => ListTile(
                        leading: const Icon(Icons.check_circle_outline),
                        title: Text(_tarefas[i]),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
