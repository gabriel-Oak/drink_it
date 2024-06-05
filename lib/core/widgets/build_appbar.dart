import 'package:flutter/material.dart';

AppBar buildAppBar(
  BuildContext context, {
  List<Widget>? actions,
  Widget? leading,
  String? title = 'Drink.it',
}) =>
    AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leading: leading,
      shadowColor: Colors.transparent,
      actions: actions,
      title: Text(
        title!,
        style: const TextStyle(color: Colors.black54),
      ),
    );
