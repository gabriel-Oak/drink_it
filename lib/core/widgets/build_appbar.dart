import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context,
        {List<Widget>? actions, Widget? leading}) =>
    AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leading: leading,
      shadowColor: Colors.transparent,
      actions: actions,
      title: const Text(
        'Hello Jhon',
        style: TextStyle(color: Colors.black54),
      ),
    );
