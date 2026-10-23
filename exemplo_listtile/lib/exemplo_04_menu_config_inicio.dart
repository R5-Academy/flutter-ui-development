// exemplo_04_menu_config_inicio.dart
// Ponto de partida: quatro opções de configuração, uma embaixo da outra dentro
// de um Card. Todas com ícone, título, subtítulo, seta e onTap.
//
// ! Duas coisas faltam, e as duas são de leitura:
// !   1. as opções se derramam umas nas outras — nada marca onde uma termina;
// !   2. a pessoa está DENTRO de "Aparência" e nada na lista diz isso.
//
// O ListTile tem resposta para as duas, e nenhuma delas é escrever um Container
// colorido na mão.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: MenuConfig()));

class MenuConfig extends StatelessWidget {
  const MenuConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text('Configurações')),
      body: Center(
        child: SizedBox(
          width: 360,
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              // min: a Column abraça só os tiles, não estica a tela toda.
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Conta'),
                  subtitle: const Text('Nome, e-mail, senha'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notificações'),
                  subtitle: const Text('Ativadas'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.palette),
                  title: const Text('Aparência'),
                  subtitle: const Text('Tema, cores'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Sair',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
