# drop_down package

Simple and robust Dropdown with item search feature, making it possible to use an offline item list or filtering URL for easy customization.


## packages.yaml
```yaml
drop_down: <lastest version>
```

## Import
```dart
import 'package:drop_down/drop_down.dart';
```

## Simple implementation
```dart
DropDown(
  items: ["Brasil", "Itália", "Estados Unidos", "Canadá"],
  label: "País",
  onChanged: print,
  selectedItem: "Brasil",
);
```

## Endpoint implementation
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
## Customization
You can customize the layout of the dropdown and its items. [EXAMPLE]

To customize the dropdown, we have the `dropdownBuilder` property, which takes a function with the parameters:
    - `BuildContext context`: current context;
    - `T item`: Current item, where **T** is the type passed in the DropDown constructor.

To customize the items, we have the `dropdownItemBuilder` property, which takes a function with the parameters:
    - `BuildContext context`: current context;
    - `T item`: Current item, where **T** is the type passed in the DropDown constructor.
    - `bool isSelected`: Boolean that tells you if the current item is selected.


## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
