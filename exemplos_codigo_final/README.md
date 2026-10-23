# minha_app — exercício da seção Estrutura da Tela

App que reproduz o `layout.png` do exercício usando **só** o que a seção
ensinou: `Scaffold`, `AppBar`, `Drawer` e `NavigationBar`. Projeto Flutter de
verdade, com iOS e Android apenas.

## Como rodar

```bash
flutter pub get
flutter run
flutter test
```

## A moldura

Existe **um Scaffold só** no app inteiro, na `TelaPrincipal`. As telas dos
destinos (`TelaInicio`, `TelaTarefas`, `TelaPerfil`) não têm Scaffold: elas são
apenas o conteúdo do slot `body`.

| Slot | Quem preenche |
| --- | --- |
| `appBar` | `AppBar(title: Text('Minha App'))` — o ☰ aparece sozinho porque existe `drawer` |
| `drawer` | `MenuLateral` (`ListView` com `padding: EdgeInsets.zero` + `DrawerHeader` + `ListTile`) |
| `body` | `IndexedStack` com as três telas — preserva o estado de cada aba |
| `bottomNavigationBar` | `BarraDeNavegacao` (`NavigationBar` do Material 3) |

Quem guarda o destino ativo é a `TelaPrincipal`. O menu lateral e a barra de
baixo não guardam estado nenhum: recebem qual destino está ativo e avisam qual
foi tocado — o `setState` é sempre da tela.

## Estrutura

```
lib/
├── main.dart                        runApp
├── app/
│   ├── minha_app.dart               MaterialApp
│   └── tema/
│       ├── cores_do_app.dart        as cores da marca
│       └── tema_do_app.dart         AppBarTheme, DrawerThemeData, NavigationBarThemeData...
├── modelos/
│   ├── destino.dart                 os 3 destinos (barra e menu leem daqui)
│   ├── tarefa.dart
│   └── dado_de_resumo.dart
├── widgets/
│   └── titulo_da_secao.dart         compartilhado entre telas
└── telas/
    ├── principal/
    │   ├── tela_principal.dart      o Scaffold com os 4 slots
    │   └── widgets/
    │       ├── menu_lateral.dart
    │       ├── cabecalho_do_menu.dart
    │       ├── item_do_menu.dart
    │       └── barra_de_navegacao.dart
    ├── inicio/
    │   ├── tela_inicio.dart
    │   └── widgets/ banner_da_paisagem · cartao_de_resumo · item_de_resumo
    ├── tarefas/
    │   ├── tela_tarefas.dart
    │   └── widgets/ cartao_de_tarefa · etiqueta_de_situacao
    └── perfil/
        ├── tela_perfil.dart
        └── widgets/ cartao_do_usuario
```

## Pontos da seção que o código exercita

- **Um Scaffold por tela.** As telas dos destinos são só conteúdo.
- **Slot vazio não existe.** Nenhum slot é preenchido "por precaução".
- **`Scaffold.of(context)` precisa de um context abaixo do Scaffold.** Por isso o
  `ItemDoMenu` é um widget extraído — é dele que sai o `closeDrawer()`.
- **`closeDrawer()` em vez de `Navigator.pop`**, que derruba a tela se o menu já
  estiver fechado.
- **Receita do `ListView` com `padding: EdgeInsets.zero`** no menu lateral.
- **A barra não guarda estado**: `selectedIndex` + `onDestinationSelected` +
  `setState`.
- **`IndexedStack`**: marque uma tarefa, vá para Perfil e volte — a marcação
  continua lá.
- **Padronizar pelo tema**: nenhuma tela repete cor, altura ou formato.
