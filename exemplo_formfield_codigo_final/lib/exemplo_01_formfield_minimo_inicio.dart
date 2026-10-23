// exemplo_01_formfield_minimo_inicio.dart
// Ponto de partida: o aceite dos termos, resolvido do jeito que a gente já
// sabe — um `bool` no State e um `CheckboxListTile` com `setState`.
//
// Funciona perfeitamente... enquanto ele está sozinho na tela.
//
// ! O problema aparece quando esse campo entra num formulário de verdade: o
// ! `Form` não faz ideia de que ele existe.
// !   - `validate()` não valida o aceite;
// !   - `save()` não colhe o aceite;
// !   - `reset()` não desmarca o aceite.
// !
// ! Tudo o que a aula anterior construiu passa ao largo dele, e você acaba
// ! tratando esse campo na mão, em paralelo, para sempre.
//
// ? O `TextFormField` participa do Form. Como fazer um checkbox participar
// ? também — ou um seletor de estrelas, ou um mapa, ou o que for?

import 'package:material_ui/material_ui.dart';

void main() => runApp(const MaterialApp(home: FormFieldMinimo()));

class const FormFieldMinimo({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aceite dos termos')),
      body: Center(
        child: FormField(
          initialValue: false,
          builder: (field) {
            return CheckboxListTile(
              title: const Text('Aceito os termos de uso'),
              value: field.value ?? false,
              onChanged: (novo) => field.didChange(novo),
            );
          },
        ),
      ),
    );
  }
}
