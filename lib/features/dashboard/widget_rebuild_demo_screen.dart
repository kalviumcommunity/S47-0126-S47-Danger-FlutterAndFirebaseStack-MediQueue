import 'package:flutter/material.dart';
import 'rebuild_flash.dart';

/// Demo screen to visualize Flutter's reactive UI and widget rebuilds.
class WidgetRebuildDemoScreen extends StatefulWidget {
  const WidgetRebuildDemoScreen({Key? key}) : super(key: key);

  @override
  State<WidgetRebuildDemoScreen> createState() =>
      _WidgetRebuildDemoScreenState();
}

class _WidgetRebuildDemoScreenState extends State<WidgetRebuildDemoScreen> {
  int _counter = 0;
  Color _bgColor = Colors.white;
  String _input = '';
  bool _toggleA = false;
  bool _toggleB = false;

  int _counterRebuilds = 0;
  int _colorRebuilds = 0;
  int _inputRebuilds = 0;
  int _toggleRebuilds = 0;

  void _log(String msg) {
    // ignore: avoid_print
    print('[${DateTime.now().toIso8601String()}] $msg');
  }

  @override
  Widget build(BuildContext context) {
    _log('WidgetRebuildDemoScreen build() called');
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Rebuild Demo')),
      backgroundColor: _bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RebuildFlash(
              label: 'Counter',
              rebuildCount: ++_counterRebuilds,
              onRebuild: () => _log('Counter widget rebuilt'),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => setState(() => _counter--),
                  ),
                  Text(
                    '$_counter',
                    style: TextStyle(
                      fontSize: 32,
                      color: _counter % 2 == 0 ? Colors.blue : Colors.red,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => _counter++),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            RebuildFlash(
              label: 'Color Picker',
              rebuildCount: ++_colorRebuilds,
              onRebuild: () => _log('Color picker rebuilt'),
              child: Row(
                children: [
                  const Text('Background:'),
                  const SizedBox(width: 8),
                  _ColorDot(
                    color: Colors.white,
                    selected: _bgColor == Colors.white,
                    onTap: () => setState(() => _bgColor = Colors.white),
                  ),
                  _ColorDot(
                    color: Colors.yellow[100]!,
                    selected: _bgColor == Colors.yellow[100],
                    onTap: () => setState(() => _bgColor = Colors.yellow[100]!),
                  ),
                  _ColorDot(
                    color: Colors.blue[50]!,
                    selected: _bgColor == Colors.blue[50],
                    onTap: () => setState(() => _bgColor = Colors.blue[50]!),
                  ),
                  _ColorDot(
                    color: Colors.green[50]!,
                    selected: _bgColor == Colors.green[50],
                    onTap: () => setState(() => _bgColor = Colors.green[50]!),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            RebuildFlash(
              label: 'Text Input',
              rebuildCount: ++_inputRebuilds,
              onRebuild: () => _log('Text input rebuilt'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Live Preview:'),
                  TextField(
                    onChanged: (v) => setState(() => _input = v),
                    decoration: const InputDecoration(hintText: 'Type here...'),
                  ),
                  Text(
                    _input,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            RebuildFlash(
              label: 'Toggles',
              rebuildCount: ++_toggleRebuilds,
              onRebuild: () => _log('Toggles rebuilt'),
              child: Row(
                children: [
                  Switch(
                    value: _toggleA,
                    onChanged: (v) => setState(() => _toggleA = v),
                  ),
                  const Text('Toggle A'),
                  const SizedBox(width: 16),
                  Switch(
                    value: _toggleB,
                    onChanged: (v) => setState(() => _toggleB = v),
                  ),
                  const Text('Toggle B'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const Text(
              'Performance Tips:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text('- Use const constructors where possible.'),
            const Text('- Split widgets to minimize rebuilds.'),
            const Text('- Avoid unnecessary setState calls.'),
            const Text('- Use Flutter DevTools to inspect widget tree.'),
          ],
        ),
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  final Color color;
  final bool selected;
  final VoidCallback onTap;
  const _ColorDot(
      {required this.color, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? Colors.black : Colors.grey,
            width: selected ? 2 : 1,
          ),
        ),
      ),
    );
  }
}
