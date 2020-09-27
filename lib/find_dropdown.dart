library find_dropdown;

import 'package:select_dialog/select_dialog.dart';
import 'package:flutter/material.dart';

import 'find_dropdown_bloc.dart';

typedef Future<List<T>> FindDropdownFindType<T>(String text);
typedef void FindDropdownChangedType<T>(T selectedItem);
typedef void FindDropdownMultipleItemsChangedType<T>(List<T> selectedItem);
typedef String FindDropdownValidationType<T>(T selectedText);
typedef Widget FindDropdownBuilderType<T>(BuildContext context, T selectedItem);
typedef Widget FindDropdownMultipleItemsBuilderType<T>(
  BuildContext context,
  List<T> selectedItem,
);
typedef Widget FindDropdownItemBuilderType<T>(
  BuildContext context,
  T item,
  bool isSelected,
);

class FindDropdown<T> extends StatefulWidget {
  final String label;
  final bool labelVisible;
  final bool showClearButton;
  final TextStyle labelStyle;
  final List<T> items;
  final T selectedItem;
  final List<T> multipleSelectedItems;
  final FindDropdownFindType<T> onFind;
  final FindDropdownChangedType<T> onChanged;
  final FindDropdownMultipleItemsChangedType<T> onMultipleItemsChanged;
  final FindDropdownBuilderType<T> dropdownBuilder;
  final FindDropdownMultipleItemsBuilderType<T> dropdownMultipleItemsBuilder;
  final FindDropdownItemBuilderType<T> dropdownItemBuilder;
  final FindDropdownValidationType<T> validate;
  final FindDropdownValidationType<List<T>> validateMultipleItems;
  final Color backgroundColor;
  final WidgetBuilder emptyBuilder;
  final WidgetBuilder loadingBuilder;
  final ErrorBuilderType errorBuilder;
  final bool autofocus;
  final int searchBoxMaxLines;
  final int searchBoxMinLines;
  final ButtonBuilderType okButtonBuilder;

  ///![image](https://user-images.githubusercontent.com/16373553/80187339-db365f00-85e5-11ea-81ad-df17d7e7034e.png)
  final bool showSearchBox;

  ///![image](https://user-images.githubusercontent.com/16373553/80187339-db365f00-85e5-11ea-81ad-df17d7e7034e.png)
  final InputDecoration searchBoxDecoration;

  ///![image](https://user-images.githubusercontent.com/16373553/80187103-72e77d80-85e5-11ea-9349-e4dc8ec323bc.png)
  final TextStyle titleStyle;

  ///|**Max width**: 90% of screen width|**Max height**: 70% of screen height|
  ///|---|---|
  ///|![image](https://user-images.githubusercontent.com/16373553/80189438-0a020480-85e9-11ea-8e63-3fabfa42c1c7.png)|![image](https://user-images.githubusercontent.com/16373553/80190562-e2ac3700-85ea-11ea-82ef-3383ae32ab02.png)|
  final BoxConstraints constraints;

  const FindDropdown.multiSelect({
    Key key,
    @required FindDropdownMultipleItemsChangedType<T> onChanged,
    this.label,
    this.labelStyle,
    this.items,
    List<T> selectedItems,
    this.onFind,
    FindDropdownMultipleItemsBuilderType<T> dropdownBuilder,
    this.dropdownItemBuilder,
    this.showSearchBox = true,
    this.showClearButton = false,
    FindDropdownValidationType<List<T>> validate,
    this.searchBoxDecoration,
    this.backgroundColor,
    this.titleStyle,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.constraints,
    this.autofocus,
    this.searchBoxMaxLines,
    this.searchBoxMinLines,
    this.okButtonBuilder,
    bool labelVisible = true,
  })  : assert(onChanged != null),
        this.labelVisible = labelVisible ?? true,
        this.dropdownMultipleItemsBuilder = dropdownBuilder,
        this.multipleSelectedItems = selectedItems,
        this.onMultipleItemsChanged = onChanged,
        this.validateMultipleItems = validate,
        this.validate = null,
        this.dropdownBuilder = null,
        this.selectedItem = null,
        this.onChanged = null,
        super(key: key);

  const FindDropdown({
    Key key,
    @required this.onChanged,
    this.label,
    this.labelStyle,
    this.items,
    this.selectedItem,
    this.onFind,
    this.dropdownBuilder,
    this.dropdownItemBuilder,
    this.showSearchBox = true,
    this.showClearButton = false,
    this.validate,
    this.searchBoxDecoration,
    this.backgroundColor,
    this.titleStyle,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.constraints,
    this.autofocus,
    this.searchBoxMaxLines,
    this.searchBoxMinLines,
    this.okButtonBuilder,
    bool labelVisible = true,
  })  : assert(onChanged != null),
        labelVisible = labelVisible ?? true,
        this.validateMultipleItems = null,
        this.dropdownMultipleItemsBuilder = null,
        this.multipleSelectedItems = null,
        this.onMultipleItemsChanged = null,
        super(key: key);

  @override
  _FindDropdownState<T> createState() => _FindDropdownState<T>();
}

class _FindDropdownState<T> extends State<FindDropdown<T>> {
  FindDropdownBloc bloc;

  bool get isMultipleItems => widget.onMultipleItemsChanged != null;

  @override
  void initState() {
    super.initState();
    if (isMultipleItems) {
      bloc = FindDropdownBloc<List<T>>(
        seedValue: widget.multipleSelectedItems,
        validate: widget.validateMultipleItems,
      );
    } else {
      bloc = FindDropdownBloc<T>(
        seedValue: widget.selectedItem,
        validate: widget.validate,
      );
    }
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null && widget.labelVisible)
          Text(
            widget.label,
            style: widget.labelStyle ?? Theme.of(context).textTheme.subtitle1,
          ),
        if (widget.label != null) SizedBox(height: 5),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder(
              stream: bloc.selected$,
              builder: (context, snapshot) {
                return GestureDetector(
                  onTap: () {
                    SelectDialog.showModal<T>(
                      context,
                      items: widget.items,
                      label: widget.label,
                      onFind: widget.onFind,
                      multipleSelectedValues:
                          isMultipleItems ? snapshot.data : null,
                      okButtonBuilder: widget.okButtonBuilder,
                      showSearchBox: widget.showSearchBox,
                      itemBuilder: widget.dropdownItemBuilder,
                      selectedValue: isMultipleItems ? null : snapshot.data,
                      searchBoxDecoration: widget.searchBoxDecoration,
                      backgroundColor: widget.backgroundColor,
                      titleStyle: widget.titleStyle,
                      autofocus: widget.autofocus,
                      constraints: widget.constraints,
                      emptyBuilder: widget.emptyBuilder,
                      errorBuilder: widget.errorBuilder,
                      loadingBuilder: widget.loadingBuilder,
                      searchBoxMaxLines: widget.searchBoxMaxLines,
                      searchBoxMinLines: widget.searchBoxMinLines,
                      onMultipleItemsChange: isMultipleItems
                          ? (items) {
                              bloc.selected$.add(items);
                              widget.onMultipleItemsChanged(items);
                            }
                          : null,
                      onChange: isMultipleItems
                          ? null
                          : (item) {
                              bloc.selected$.add(item);
                              widget.onChanged(item);
                            },
                    );
                  },
                  child: (widget.dropdownBuilder != null)
                      ? widget.dropdownBuilder(context, snapshot.data)
                      : widget.dropdownMultipleItemsBuilder != null
                          ? widget.dropdownMultipleItemsBuilder(
                              context, snapshot.data)
                          : Builder(builder: (context) {
                              String title;
                              if (isMultipleItems) {
                                title = snapshot.data?.join(", ")?.toString();
                              } else {
                                title = snapshot.data?.toString();
                              }
                              bool showClearButton = snapshot.data != null &&
                                  widget.showClearButton;
                              return Container(
                                padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(title ?? ""),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        children: <Widget>[
                                          if (showClearButton)
                                            GestureDetector(
                                              onTap: () {
                                                bloc.selected$.add(null);
                                                widget.onChanged(null);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 0,
                                                ),
                                                child: Icon(
                                                  Icons.clear,
                                                  size: 25,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                          if (!showClearButton)
                                            Icon(
                                              Icons.arrow_drop_down,
                                              size: 25,
                                              color: Colors.black54,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                );
              },
            ),
            if (widget.validate != null || widget.validateMultipleItems != null)
              StreamBuilder<String>(
                stream: bloc.validateMessageOut,
                builder: (context, snapshot) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        snapshot.data ?? "",
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: snapshot.hasData
                                ? Theme.of(context).errorColor
                                : Colors.transparent),
                      ),
                    ),
                  );
                },
              )
          ],
        ),
      ],
    );
  }
}
