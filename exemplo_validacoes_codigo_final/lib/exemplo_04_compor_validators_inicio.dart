// exemplo_04_compor_validators_inicio.dart
// Ponto de partida: dois campos, cada um com o seu `validator` escrito à mão —
// exatamente como nos blocos anteriores.
//
// ! Olhe os dois `validator` lado a lado. Os dois começam checando o vazio, com
// ! a mesma estrutura, quase as mesmas linhas. Num formulário de seis campos,
// ! esse "obrigatório" vai estar escrito **seis vezes**.
//
// ! E cada cópia é uma chance de divergir: uma com `trim()`, outra sem; uma com
// ! "Campo obrigatório", outra com "Informe o e-mail". O formulário fica
// ! inconsistente sem ninguém decidir isso.
//
// ? Um validator é só uma função `String? Function(String?)`. Funções a gente
// ? sabe reaproveitar — mas aqui cada uma precisa de uma **mensagem diferente**.
// ? Como reaproveitar e parametrizar ao mesmo tempo?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaCompor()));

typedef Validador = String? Function(String?);

final _regexEmail = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

Validador obrigatorio([String message = 'Campo obrigatório']) {
  return (valor) {
    if (valor == null || valor.trim().isEmpty) return message;
    return null;
  };
}

Validador tamanhoMinimo(int minimo, [String? message]) {
  return (valor) {
    if ((valor ?? '').length < minimo) {
      return message ?? 'Mínimo de $minimo caracteres';
    }
    return null;
  };
}

Validador email([String message = 'E-mail inválido']) {
  return (valor) {
    if (!_regexEmail.hasMatch(valor?.trim() ?? '')) return message;
    return null;
  };
}

Validador combinador(List<Validador> validatores) {
  return (valor) {
    for (final validar in validatores) {
      final erro = validar(valor);
      if (erro != null) return erro;
    }
    return null;
  };
}

class TelaCompor extends StatefulWidget {
  const TelaCompor({super.key});

  @override
  State<TelaCompor> createState() => _TelaComporState();
}

class _TelaComporState extends State<TelaCompor> {
  final _formKey = GlobalKey<FormState>();

  void _enviar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Tudo válido!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Validators compostos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                // ! Obrigatório + formato, escritos aqui.
                validator: combinador([
                  obrigatorio('Informe o e-mail'),
                  email(),
                ]),
                // validator: (valor) {
                //   final texto = valor?.trim() ?? '';
                //   if (texto.isEmpty) return 'Informe o e-mail';
                //   if (!_regexEmail.hasMatch(texto)) return 'E-mail inválido';
                //   return null;
                // },
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                // ! Obrigatório de novo, com outra estrutura.
                validator: combinador([obrigatorio(), tamanhoMinimo(8)]),
                // validator: (valor) {
                //   final texto = valor ?? '';
                //   if (texto.isEmpty) return 'Informe a senha';
                //   if (texto.length < 8) return 'Mínimo de 8 caracteres';
                //   return null;
                // },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _enviar,
                  child: const Text('Enviar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
