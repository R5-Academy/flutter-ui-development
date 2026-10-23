// exemplo_05_switchlisttile_inicio.dart
// Ponto de partida: o painel de notificações, com um `Switch` no `trailing` de
// cada ListTile. O estado já funciona: ligar e desligar altera o interruptor.
//
// ! O problema é a ÁREA DE TOQUE. Toque no texto "Push": nada. Toque no ícone:
// ! nada. Só o interruptor responde — e ele mede 60 x 48 (medido), contra
// ! 360 x 80 da linha inteira. É dez vezes menos área, encostada na borda
// ! direita. Tente acertar isso andando na rua.
//
// ! E o ListTile ainda por cima não sabe que existe um controle ali: sem
// ! `onTap`, ele nem ripple tem.
//
// A linha inteira deveria alternar o switch. Existe uma variante do ListTile
// exatamente para isso.

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: PainelNotificacoes()));

class PainelNotificacoes extends StatefulWidget {
  const PainelNotificacoes({super.key});

  @override
  State<PainelNotificacoes> createState() => _PainelNotificacoesState();
}

class _PainelNotificacoesState extends State<PainelNotificacoes> {
  // Estado de verdade: cada interruptor guarda ligado/desligado.
  bool _push = true;
  bool _email = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text('Notificações')),
      body: Center(
        child: SizedBox(
          width: 360,
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.notifications_active),
                  title: const Text('Push'),
                  subtitle: const Text('Alertas no aparelho'),
                  // ! O único ponto tocável da linha inteira.
                  trailing: Switch(
                    value: _push,
                    onChanged: (novo) => setState(() => _push = novo),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.mail),
                  title: const Text('E-mail'),
                  subtitle: const Text('Resumo semanal'),
                  trailing: Switch(
                    value: _email,
                    onChanged: (novo) => setState(() => _email = novo),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
