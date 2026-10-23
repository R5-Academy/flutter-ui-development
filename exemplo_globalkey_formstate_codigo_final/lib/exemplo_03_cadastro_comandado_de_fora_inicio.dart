// exemplo_03_cadastro_comandado_de_fora_inicio.dart
// Ponto de partida: o cadastro completo, com três campos validados e o botão
// "Cadastrar" **fixo no rodapé** (`bottomNavigationBar`) — fora do `Form`,
// funcionando pela ponte.
//
// O pedido novo é de design: um botão de **limpar na AppBar**, para a pessoa
// recomeçar sem precisar apagar campo por campo.
//
// ! Repare onde esse botão está: dentro do `actions` da `AppBar`. Ele não é
// ! filho do `Form` — nem sequer está no `body`. É outro ramo inteiro da
// ! árvore.
// !
// ! Do jeito que está, ele só mostra um aviso: não há caminho daqui até os
// ! campos.
//
// ? A ponte que valida do rodapé alcança também a barra do topo?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: TelaCadastro()));

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();

  final _nomeCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _emailCtrl.dispose();
    _senhaCtrl.dispose();
    super.dispose();
  }

  void _cadastrar() {
    // O botão vive no rodapé, fora do Form. A key é o único caminho até ele.
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cadastrado: ${_nomeCtrl.text} <${_emailCtrl.text}>'),
      ),
    );
  }

  void _limpar() {
    // ! Sem caminho até os campos: só avisa.
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        actions: [
          IconButton(
            onPressed: _limpar,
            icon: const Icon(Icons.cleaning_services_outlined),
            tooltip: 'Limpar',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final texto = value?.trim() ?? '';
                  if (texto.isEmpty) return 'Informe o e-mail';
                  if (!texto.contains('@')) return 'E-mail inválido';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _senhaCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if ((value ?? '').length < 6) {
                    return 'Mínimo de 6 caracteres';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      // O botão fica FORA do Form — e fora do body inteiro.
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: _cadastrar,
            child: const Text('Cadastrar'),
          ),
        ),
      ),
    );
  }
}
