library find_dropdown;

import 'package:select_dialog/select_dialog.dart';
import 'package:flutter/material.dart';

import 'find_dropdown_bloc.dart';

typedef Future<List<T>> FindDropdownFindType<T>(String text);
typedef void FindDropdownChangedType<T>(T selectedItem);
typedef Widget FindDropdownBuilderType<T>(BuildContext context, T selectedText);
typedef String FindDropdownValidationType<T>(T selectedText);
typedef Widget FindDropdownItemBuilderType<T>(
    BuildContext context, T item, bool isSelected);

class FindDropdown<T> extends StatefulWidget {
  final String label;
  final bool showSearchBox;
  final TextStyle labelStyle;
  final List<T> items;
  final T selectedItem;
  final FindDropdownFindType<T> onFind;
  final FindDropdownChangedType<T> onChanged;
  final FindDropdownBuilderType<T> dropdownBuilder;
  final FindDropdownItemBuilderType<T> dropdownItemBuilder;
  final FindDropdownValidationType<T> validate;

  const FindDropdown({
    Key key,
    @required this.onChanged,
    this.label,
    this.showSearchBox,
    this.labelStyle,
    this.items,
    this.selectedItem,
    this.onFind,
    this.dropdownBuilder,
    this.dropdownItemBuilder,
    this.validate,
  })  : assert(onChanged != null),
        super(key: key);
  @override
  _FindDropdownState<T> createState() => _FindDropdownState<T>();
}

class _FindDropdownState<T> extends State<FindDropdown<T>> {
  FindDropdownBloc<T> bloc;

  @override
  void initState() {
    super.initState();
    bloc = FindDropdownBloc<T>(
      seedValue: widget.selectedItem,
      validate: widget.validate,
    );
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
        if (widget.label != null)
          Text(
            widget.label,
            style: widget.labelStyle ?? Theme.of(context).textTheme.subhead,
          ),
        if (widget.label != null) SizedBox(height: 5),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder<T>(
              stream: bloc.selected$,
              builder: (context, snapshot) {
                return GestureDetector(
                  onTap: () {
                    SelectDialog.showModal(
                      context,
                      items: widget.items,
                      label: widget.label,
                      onFind: widget.onFind,
                      showSearchBox: showSearchBox,
                      itemBuilder: widget.dropdownItemBuilder,
                      onChange: (item) {
                        bloc.selected$.add(item);
                        widget.onChanged(item);
                      },
                      selectedValue: snapshot.data,
                    );
                  },
                  child: (widget.dropdownBuilder != null)
                      ? widget.dropdownBuilder(context, snapshot.data)
                      : Container(
                          padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: Theme.of(context).dividerColor,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(snapshot.data?.toString() ?? ""),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  children: <Widget>[
                                    snapshot.data != null
                                        ? IconButton(
                                            onPressed: () {
                                              bloc.selected$.add(null);
                                              widget.onChanged(null);
                                            },
                                            icon: Icon(Icons.clear),
                                            iconSize: 25,
                                          )
                                        : Container(),
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
                        ),
                );
              },
            ),
            StreamBuilder<String>(
              stream: bloc.validateMessageOut,
              builder: (context, snapshot) {
                return ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      snapshot.data ?? "",
                      style: Theme.of(context).textTheme.body1.copyWith(
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
