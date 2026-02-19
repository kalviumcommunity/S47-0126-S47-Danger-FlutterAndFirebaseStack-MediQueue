import 'package:flutter/material.dart';

/// LogoWidget: StatelessWidget example for app branding.
class LogoWidget extends StatelessWidget {
  final double size;
  const LogoWidget({Key? key, this.size = 48}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo/app_logo.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) =>
          Icon(Icons.local_hospital, size: size, color: Colors.blue),
    );
  }
}
