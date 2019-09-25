[![Buy Me A Coffee](https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-yellow.svg)](https://www.buymeacoffee.com/deivao)

# FindDropdown package - [[ver em português](https://github.com/davidsdearaujo/find_dropdown/blob/master/README-PT.md)]

Simple and robust FindDropdown with item search feature, making it possible to use an offline item list or filtering URL for easy customization.

![](https://github.com/davidsdearaujo/find_dropdown/blob/master/screenshots/Screenshot_4.png?raw=true)

<img src="https://github.com/davidsdearaujo/find_dropdown/blob/master/screenshots/GIF_Endpoint.gif?raw=true" width="49.5%" /> <img src="https://github.com/davidsdearaujo/find_dropdown/blob/master/screenshots/GIF_Custom_Layout.gif?raw=true" width="49.5%" />


## packages.yaml
```yaml
find_dropdown: <lastest version>
```

## Import
```dart
import 'package:find_dropdown/find_dropdown.dart';
```

## Simple implementation

```dart
FindDropdown(
  items: ["Brasil", "Itália", "Estados Unidos", "Canadá"],
  label: "País",
  onChanged: (String item) => print(item),
  selectedItem: "Brasil",
);
```


## Endpoint implementation (using [Dio package](https://pub.dev/packages/dio))
```dart
FindDropdown<UserModel>(
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
## Customization
You can customize the layout of the FindDropdown and its items. [EXAMPLE](https://github.com/davidsdearaujo/find_dropdown/tree/master/example#custom-layout-endpoint-example)

To **customize the FindDropdown**, we have the `dropdownBuilder` property, which takes a function with the parameters:
- `BuildContext context`: current context;
- `T item`: Current item, where **T** is the type passed in the FindDropdown constructor.

To **customize the items**, we have the `dropdownItemBuilder` property, which takes a function with the parameters:
- `BuildContext context`: current context;
- `T item`: Current item, where **T** is the type passed in the FindDropdown constructor.
- `bool isSelected`: Boolean that tells you if the current item is selected.

# [View more Examples](https://github.com/davidsdearaujo/find_dropdown/tree/master/example)