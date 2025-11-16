import 'package:flutter/material.dart';

class AppWrapper<T> extends StatelessWidget {
  const AppWrapper._internal({
    required super.key,
    required this.itemCount,
    required this.children,
    required this.itemBuilder,
    this.itemseparatorBuilder,
  }); //private constructor
  const AppWrapper({Key? key, required List<Widget>? children})
    : this._internal(
        key: key,
        itemCount: null,
        children: children,
        itemBuilder: null,
      ); //normal constructor
  const AppWrapper.builder({
    Key? key,

    required int itemCount,
    required Widget Function(BuildContext context, int index) itemBuilder,
    required Widget Function(BuildContext context, int index)
    itemseparatorBuilder,
    List<Widget>? children,
  }) : this._internal(
         key: key,
         itemCount: itemCount,
         children: children,
         itemBuilder: itemBuilder,
       );
  //named constructor

  final int? itemCount;
  final List<Widget>? children;
  final Widget Function(BuildContext context, int index)? itemBuilder;
  final Widget Function(BuildContext context, int index)? itemseparatorBuilder;

  List<Widget> _getChildren(BuildContext context) {
    if (itemCount != null) {
      List<Widget> returnedChildren = [];
      for (int i = 0; i < itemCount!; i++) {
        returnedChildren.add(itemBuilder!(context, i));
        if (i < itemCount! - 1 && itemseparatorBuilder != null) {
          returnedChildren.add(itemseparatorBuilder!(context, i));
        }
      }
      return returnedChildren;
    } else {
      return children ?? [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _getChildren(context),
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
    );
  }
}
