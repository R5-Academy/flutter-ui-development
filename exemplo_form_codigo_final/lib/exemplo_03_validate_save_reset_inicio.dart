// exemplo_03_validate_save_reset_inicio.dart
// Ponto de partida: o formulário de contato, com validação funcionando. Ao
// enviar, ele monta um resumo com o que foi digitado.
//
// Para conseguir esse resumo, cada campo precisou de um `onChanged` guardando o
// valor numa variável do State. E o "Limpar" precisou zerar tudo na mão.
//
// ! Repare no custo: dois campos, dois `onChanged`, duas variáveis, e um
// ! `_limpar` que precisa lembrar de cada uma delas. Num formulário de dez
// ! campos, é dez de cada — e esquecer um no `_limpar` é um bug silencioso.
//
// ! Repare também no `trim()` do nome: ele está no `onChanged`, ou seja, roda a
// ! cada tecla digitada. Só precisaria rodar uma vez, no envio.
//
// O `Form` já coordena a validação de todos os campos. Ele coordena mais duas
// coisas.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaContato()));

class const TelaContato({super.key}) extends StatefulWidget {
  @override
  State<TelaContato> createState() => _TelaContatoState();
}

class _TelaContatoState extends State<TelaContato> {
  var _nome = '';
  var _email = '';
  String? _resumo;

  void _enviar(FormState form) {
    if (!form.validate()) return;
    form.save();
    setState(() => _resumo = 'Recebido: $_nome <$_email>');
  }

  void _limpar(FormState form) {
    // ! Zerando tudo na mão — e o campo na tela nem sabe disso.
    setState(() {
      _nome = '';
      _email = '';
      _resumo = null;
    });
    form.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contato')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe seu nome';
                  }
                  return null;
                },
                // ! Roda a cada tecla, só para guardar o valor.
                onSaved: (value) => _nome = value?.trim() ?? '',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
                onSaved: (value) => _email = value?.trim() ?? '',
              ),
              const SizedBox(height: 24),
              Builder(
                builder: (context) => Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _enviar(Form.of(context)),
                      child: const Text('Enviar'),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: () => _limpar(Form.of(context)),
                      child: const Text('Limpar'),
                    ),
                  ],
                ),
              ),
              if (_resumo != null) ...[
                const SizedBox(height: 24),
                Text(_resumo!, style: const TextStyle(fontSize: 16)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
