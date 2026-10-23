// exemplo_05_cadastro_completo_inicio.dart
// Ponto de partida: o cadastro completo — cinco campos — com a biblioteca de
// validators do bloco anterior já montada e aplicada.
//
// Nome, e-mail, senha e confirmação estão resolvidos.
//
// ! Falta o **telefone**, e ele não cabe em nenhuma das peças prontas:
// !   - `obrigatorio()` serve, mas é só metade;
// !   - não existe `tamanhoMinimo` que diga "10 **ou** 11 dígitos";
// !   - e `email()` obviamente não tem nada a ver.
// !
// ! Do jeito que está, ele só checa se foi preenchido — e aceita
// ! `"meu telefone"` como número.
//
// ? Nem toda regra vira uma peça reutilizável. Como o campo com regra própria
// ? convive com a biblioteca?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaCadastro()));

typedef Validador = String? Function(String?);

final _regexEmail = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

Validador obrigatorio([String mensagem = 'Campo obrigatório']) {
  return (valor) {
    if (valor == null || valor.trim().isEmpty) return mensagem;
    return null;
  };
}

Validador tamanhoMinimo(int minimo, [String? mensagem]) {
  return (valor) {
    if ((valor ?? '').length < minimo) {
      return mensagem ?? 'Mínimo de $minimo caracteres';
    }
    return null;
  };
}

Validador email([String mensagem = 'E-mail inválido']) {
  return (valor) {
    if (!_regexEmail.hasMatch(valor?.trim() ?? '')) return mensagem;
    return null;
  };
}

Validador combinar(List<Validador> validators) {
  return (valor) {
    for (final validar in validators) {
      final erro = validar(valor);
      if (erro != null) return erro;
    }
    return null;
  };
}

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Conta criada!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta')),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome completo',
                prefixIcon: Icon(Icons.person_outline),
              ),
              textCapitalization: TextCapitalization.words,
              validator: combinar([
                obrigatorio('Informe seu nome'),
                tamanhoMinimo(3, 'Nome muito curto'),
              ]),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: combinar([obrigatorio('Informe o e-mail'), email()]),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _telefoneController,
              decoration: const InputDecoration(
                labelText: 'Telefone (só números)',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              keyboardType: TextInputType.phone,
              // ! Só checa se foi preenchido: "meu telefone" passa.
              validator: obrigatorio('Informe o telefone'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _senhaController,
              decoration: const InputDecoration(
                labelText: 'Senha',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
              validator: combinar([
                obrigatorio('Informe a senha'),
                tamanhoMinimo(8),
              ]),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Confirmar senha',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
              // * combinar() aceita uma peça pronta e um validator escrito na
              // * hora na mesma lista. O obrigatorio() é o que faz a
              // * confirmação vazia reprovar: sem ele, '' == '' e o campo passa.
              validator: combinar([
                obrigatorio('Confirme a senha'),
                (valor) => valor != _senhaController.text
                    ? 'As senhas não conferem'
                    : null,
              ]),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _cadastrar,
              child: const Text('Criar conta'),
            ),
          ],
        ),
      ),
    );
  }
}
