import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModeSelectWidget extends StatefulWidget {
  final Function(String) _onChanged;
  final List<String> _modes;
  final String _value;

  const ModeSelectWidget(
      {@required Function(String) onChanged,
      @required List<String> modes,
      @required String value,
      Key key})
      : _onChanged = onChanged,
        _modes = modes,
        _value = value,
        super(key: key);

  @override
  _ModeSelectWidgetState createState() => _ModeSelectWidgetState();
}

class _ModeSelectWidgetState extends State<ModeSelectWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        items: _menuItemsFromModes(widget._modes),
        onChanged: (String value) => setState(() {
          widget._onChanged(value);
        }),
        value: widget._value,
      ),
    );
  }

  List<DropdownMenuItem<String>> _menuItemsFromModes(List<String> modes) {
    final List<DropdownMenuItem<String>> result = <DropdownMenuItem<String>>[];
    widget._modes.forEach((String mode) {
      result.add(DropdownMenuItem<String>(
        value: mode,
        child: Text(mode),
      ));
    });
    return result;
  }
}
