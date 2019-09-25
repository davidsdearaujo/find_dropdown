# DropDown package - [[view english](/README.md)]

Simples e robusto Dropdown com recurso de busca entre os itens, possibilitando utilizar uma lista de itens offline ou uma URL para filtragem, com fácil customização.

![](https://github.com/davidsdearaujo/drop_down/blob/master/screenshots/Screenshot_4.png?raw=true)

<img src="https://github.com/davidsdearaujo/drop_down/blob/master/screenshots/GIF_Endpoint.gif?raw=true" width="49.5%" /> <img src="https://github.com/davidsdearaujo/drop_down/blob/master/screenshots/GIF_Custom_Layout.gif?raw=true" width="49.5%" />


## packages.yaml
```yaml
drop_down: <lastest version>
```

## Import
```dart
import 'package:drop_down/drop_down.dart';
```

## Implementação simples
```dart
DropDown(
  items: ["Brasil", "Itália", "Estados Unidos", "Canadá"],
  label: "País",
  onChanged: (String item) => print(item),
  selectedItem: "Brasil",
);
```

## Implementação com endpoint (utilizando o [package Dio](https://pub.dev/packages/dio))
```dart
DropDown<UserModel>(
  label: "Nome",
  onFind: (String filter) async {
    var response = await Dio().get(
        "http://5d85ccfb1e61af001471bf60.mockapi.io/user",
        queryParameters: {"filter": filter},
    );
    var models = UserModel.fromJsonList(response.data);
    return models;
  },
  onChanged: (UserModel data) {
    print(data);
  },
);
```
## Customização
É possível customizar o layout do dropdown e de seus itens. [EXAMPLE]

Para **customizar o dropdown**, temos a propriedade `dropdownBuilder`, que recebe uma função com os parâmetros:
- `BuildContext context`: Contexto do item atual;
- `T item`: Item atual, onde **T** é o tipo passado no construtor do DropDown.

Para **customizar os itens**, temos a propriedade `dropdownItemBuilder`, que recebe uma função com os parâmetros:
- `BuildContext context`: Contexto do item atual;
- `T item`: Item atual, onde **T** é o tipo passado no construtor do DropDown.
- `bool isSelected`: Boolean que informa se o item atual está selecionado.

# [Ver mais Exemplos](https://github.com/davidsdearaujo/drop_down/tree/master/example)