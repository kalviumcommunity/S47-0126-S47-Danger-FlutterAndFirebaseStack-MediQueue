import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData? icon;
  final Color? color;
  const InfoCard(
      {Key? key,
      required this.title,
      required this.content,
      this.icon,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color?.withOpacity(0.1),
      child: ListTile(
        leading: icon != null ? Icon(icon, color: color) : null,
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(content),
      ),
    );
  }
}
