# DropDown package - [[ver em português](/README-PT.md)]

Simple and robust Dropdown with item search feature, making it possible to use an offline item list or filtering URL for easy customization.
<center>

![](https://github.com/davidsdearaujo/drop_down/blob/master/screenshots/Screenshot_4.png?raw=true)
</center>
<img src="https://github.com/davidsdearaujo/drop_down/blob/master/screenshots/GIF_Endpoint.gif?raw=true" width="49.5%"/> <img src="https://github.com/davidsdearaujo/drop_down/blob/master/screenshots/GIF_Custom_Layout.gif?raw=true" width="49.5%"/>


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
  onChanged: (String item) => print(item),
  selectedItem: "Brasil",
);
```


## Endpoint implementation (using [Dio package](https://pub.dev/packages/dio))
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
You can customize the layout of the dropdown and its items. [EXAMPLE](https://github.com/davidsdearaujo/drop_down/tree/master/example#custom-layout-endpoint-example)

To **customize the dropdown**, we have the `dropdownBuilder` property, which takes a function with the parameters:
- `BuildContext context`: current context;
- `T item`: Current item, where **T** is the type passed in the DropDown constructor.

To **customize the items**, we have the `dropdownItemBuilder` property, which takes a function with the parameters:
- `BuildContext context`: current context;
- `T item`: Current item, where **T** is the type passed in the DropDown constructor.
- `bool isSelected`: Boolean that tells you if the current item is selected.

# [View more Examples](https://github.com/davidsdearaujo/drop_down/tree/master/example)