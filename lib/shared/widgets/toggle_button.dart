import 'package:flutter/material.dart';

/// ToggleButton: StatefulWidget example for switching between views.
class ToggleButton extends StatefulWidget {
  final List<String> options;
  final ValueChanged<int> onChanged;
  const ToggleButton({Key? key, required this.options, required this.onChanged}) : super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.options.length, (i) {
        final selected = i == _selected;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ChoiceChip(
            label: Text(widget.options[i]),
            selected: selected,
            onSelected: (v) {
              setState(() => _selected = i);
              widget.onChanged(i);
            },
          ),
        );
      }),
    );
  }
}
