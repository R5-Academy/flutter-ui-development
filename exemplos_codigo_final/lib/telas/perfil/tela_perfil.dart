import 'package:flutter/material.dart';

import '../../app/tema/cores_do_app.dart';
import '../../widgets/titulo_da_secao.dart';
import 'widgets/cartao_do_usuario.dart';

// A tela do destino Perfil. Mesma regra das outras: sem Scaffold, só conteúdo.
class TelaPerfil extends StatelessWidget {
  const TelaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const .all(20),
      children: const [
        TituloDaSecao(
          titulo: 'Meu Perfil',
          descricao: 'Seus dados e as preferências do aplicativo.',
        ),
        SizedBox(height: 20),
        CartaoDoUsuario(nome: 'Usuário', email: 'usuario@email.com'),
        SizedBox(height: 12),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.notifications_outlined),
                title: Text('Notificações'),
                trailing: Icon(
                  Icons.chevron_right,
                  color: CoresDoApp.textoSecundario,
                ),
              ),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.lock_outline),
                title: Text('Privacidade'),
                trailing: Icon(
                  Icons.chevron_right,
                  color: CoresDoApp.textoSecundario,
                ),
              ),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Sobre o app'),
                trailing: Icon(
                  Icons.chevron_right,
                  color: CoresDoApp.textoSecundario,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
