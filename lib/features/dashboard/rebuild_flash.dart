import 'package:flutter/material.dart';
import 'dart:async';

class RebuildFlash extends StatefulWidget {
  final Widget child;
  final String label;
  final void Function()? onRebuild;
  final int rebuildCount;

  const RebuildFlash({
    Key? key,
    required this.child,
    required this.label,
    this.onRebuild,
    required this.rebuildCount,
  }) : super(key: key);

  @override
  State<RebuildFlash> createState() => _RebuildFlashState();
}

class _RebuildFlashState extends State<RebuildFlash> {
  Color _flashColor = Colors.transparent;
  Timer? _timer;

  @override
  void didUpdateWidget(covariant RebuildFlash oldWidget) {
    super.didUpdateWidget(oldWidget);
    _flash();
    widget.onRebuild?.call();
  }

  void _flash() {
    setState(() => _flashColor = Colors.yellow.withOpacity(0.5));
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => _flashColor = Colors.transparent);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: _flashColor,
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          widget.child,
          Positioned(
            right: 4,
            top: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Rebuilds: ${widget.rebuildCount}',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
