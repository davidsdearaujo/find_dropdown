library find_dropdown;

import 'package:select_dialog/select_dialog.dart';
import 'package:flutter/material.dart';

import 'find_dropdown_bloc.dart';

typedef Widget FindDropdownBuilderType<T>(BuildContext context, T selectedText);
typedef Widget FindDropdownItemBuilderType<T>(
    BuildContext context, T item, bool isSelected);

class FindDropdown<T> extends StatefulWidget {
  final String label;
  final TextStyle labelStyle;
  final List<T> items;
  final T selectedItem;
  final Future<List<T>> Function(String text) onFind;
  final void Function(T selectedItem) onChanged;
  final FindDropdownBuilderType<T> dropdownBuilder;
  final FindDropdownItemBuilderType<T> dropdownItemBuilder;

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
    bloc = FindDropdownBloc<T>(seedValue: widget.selectedItem);
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
                            child: Icon(
                              Icons.arrow_drop_down,
                              size: 25,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }
}
