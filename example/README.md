## Simple Example
```dart
DropDown(
  items: ["Brasil", "Itália", "Estados Undos", "Canadá"],
  label: "País",
  onChanged: print,
  selectedItem: "Brasil",
),
```

## Online Endpoint Example
```dart
DropDown<UserModel>(
  label: "Nome",
  onChanged: (UserModel data) {
    print(data);
  },
  onFind: (String filter) async {
    var response = await Dio().get(
        "http://5d85ccfb1e61af001471bf60.mockapi.io/user",
        queryParameters: {"filter": filter},
    );
    var models = UserModel.fromJsonList(response.data);
    return models;
  },
);
```

## Custom Layout Endpoint Example
```dart
DropDown<UserModel>(
  label: "Personagem",
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
  dropdownBuilder: (BuildContext context, UserModel item) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: (item?.avatar == null)
          ? ListTile(
              leading: CircleAvatar(),
              title: Text("No item selected"),
            )
          : ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(item.avatar),
              ),
              title: Text(item.name),
              subtitle: Text(item.createdAt.toString()),
            ),
    );
  },
  dropdownItemBuilder:  (BuildContext context, UserModel item, bool isSelected) {
    return Container(
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.name),
        subtitle: Text(item.createdAt.toString()),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item.avatar),
        ),
      ),
    );
  },
);
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
