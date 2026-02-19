import 'package:flutter/material.dart';

/// AppHeader: StatelessWidget example for displaying a title and optional subtitle.
class AppHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  const AppHeader({Key? key, required this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headline5),
        if (subtitle != null)
          Text(subtitle!, style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}
