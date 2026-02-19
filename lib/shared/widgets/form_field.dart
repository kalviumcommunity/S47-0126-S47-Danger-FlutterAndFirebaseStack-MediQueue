import 'package:flutter/material.dart';

/// FormFieldWidget: StatefulWidget example with validation.
class FormFieldWidget extends StatefulWidget {
  final String label;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  const FormFieldWidget(
      {Key? key, required this.label, this.validator, this.onChanged})
      : super(key: key);

  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  final _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validate(String value) {
    setState(() {
      _error = widget.validator?.call(value);
    });
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.label,
        errorText: _error,
      ),
      onChanged: _validate,
    );
  }
}
