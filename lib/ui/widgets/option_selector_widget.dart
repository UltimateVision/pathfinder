import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnElementSelected<T> = Function (T element);

class OptionSelector<T> extends StatelessWidget {

  final Map<T, String> options;
  final OnElementSelected<T> onElementSelected;
  final T initialSelection;

  const OptionSelector(this.options, this.onElementSelected, {Key key, this.initialSelection}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) => buildItem(context, index),
  );

  Widget buildItem(BuildContext context, int index) {
    MapEntry<T, String> entry = options.entries.elementAt(index);
    return RadioListTile<T>(
      title: Text(entry.value),
      value: entry.key,
      selected: entry.key == initialSelection,
      onChanged: _onSelectionChanged,
      groupValue: initialSelection,
    );
  }

  void _onSelectionChanged(T value) {
    onElementSelected?.call(value);
    print(value);
  }

}