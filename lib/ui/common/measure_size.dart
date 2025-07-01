import 'package:flutter/widgets.dart';

typedef OnWidgetSizeChange = void Function(Size size);

class MeasureSize extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    super.key,
    required this.onChange,
    required this.child,
  });

  @override
  State<MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  final _key = GlobalKey();
  Size? _oldSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
  }

  @override
  void didUpdateWidget(MeasureSize oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
  }

  void _notifySize() {
    final context = _key.currentContext;
    if (context == null) return;
    final newSize = context.size;
    if (_oldSize == newSize || newSize == null) return;

    _oldSize = newSize;
    widget.onChange(newSize);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: widget.child,
    );
  }
}
