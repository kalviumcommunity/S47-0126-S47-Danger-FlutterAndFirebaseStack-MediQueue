import 'package:flutter/material.dart';

/// LifecycleDemoWidget: Logs all StatefulWidget lifecycle methods.
class LifecycleDemoWidget extends StatefulWidget {
  final String label;
  const LifecycleDemoWidget({Key? key, required this.label}) : super(key: key);

  @override
  State<LifecycleDemoWidget> createState() => _LifecycleDemoWidgetState();
}

class _LifecycleDemoWidgetState extends State<LifecycleDemoWidget> {
  @override
  void initState() {
    super.initState();
    _log('initState()');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _log('didChangeDependencies()');
  }

  @override
  void didUpdateWidget(covariant LifecycleDemoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _log('didUpdateWidget()');
  }

  @override
  void dispose() {
    _log('dispose()');
    super.dispose();
  }

  void _log(String method) {
    // ignore: avoid_print
    print('[${DateTime.now().toIso8601String()}] ${widget.label}: $method');
  }

  @override
  Widget build(BuildContext context) {
    _log('build()');
    return Card(
      color: Colors.orange[50],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text('LifecycleDemoWidget: ${widget.label}'),
      ),
    );
  }
}
