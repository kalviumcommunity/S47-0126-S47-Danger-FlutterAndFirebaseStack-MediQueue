import 'package:flutter/material.dart';

/// ResponsiveBuilder: Widget that builds different layouts for phone/tablet/desktop.
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, bool isTablet) builder;
  const ResponsiveBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    return builder(context, isTablet);
  }
}
