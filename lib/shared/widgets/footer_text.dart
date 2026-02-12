import 'package:flutter/material.dart';

/// FooterText: StatelessWidget example for static footer content.
class FooterText extends StatelessWidget {
  final String text;
  const FooterText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }
}
