import 'package:flutter/material.dart';

/// AnimatedButton: StatefulWidget example with loading state.
class AnimatedButton extends StatefulWidget {
  final String label;
  final Future<void> Function() onPressed;
  const AnimatedButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _loading = false;

  Future<void> _handlePress() async {
    setState(() => _loading = true);
    await widget.onPressed();
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _loading ? null : _handlePress,
      child: _loading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2))
          : Text(widget.label),
    );
  }
}
