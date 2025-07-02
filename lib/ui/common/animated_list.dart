import 'dart:async';
import 'package:flutter/material.dart';
import 'measure_size.dart';

class AnimatedInitList extends StatefulWidget {
  final List<Widget> children;
  final bool isVisible;
  final Axis direction;
  final Animation<double>? rotationValue;
  final Animation<Offset>? slidePosition;

  const AnimatedInitList({
    super.key,
    required this.children,
    this.isVisible = true,
    this.direction = Axis.vertical,
    this.rotationValue,
    this.slidePosition,
  });

  @override
  State<AnimatedInitList> createState() => _AnimatedInitListState();
}

class _AnimatedInitListState extends State<AnimatedInitList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  List<Widget> _animatedItems = [];
  double? _itemHeight;
  double? _itemWeight;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _playForward();
  }

  @override
  void didUpdateWidget(covariant AnimatedInitList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isVisible != widget.isVisible) {
      if (widget.isVisible) {
        _playForward();
      } else {
        _playReverse();
      }
    }
    if (oldWidget.children != widget.children) {
      _animatedItems = [...widget.children];
    }
  }

  Future<void> _playForward() async {
    if (_isPlaying) return;
    _isPlaying = true;
    _animatedItems.clear();

    for (int i = 0; i < widget.children.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      _animatedItems.add(widget.children[i]);
      _listKey.currentState?.insertItem(i);
    }

    _isPlaying = false;
  }

  Future<void> _playReverse() async {
    if (_isPlaying) return;
    _isPlaying = true;
    _animatedItems = [...widget.children];
    for (int i = _animatedItems.length - 1; i >= 0; i--) {
      await Future.delayed(const Duration(milliseconds: 100));
      final removedItem = _animatedItems.removeAt(i);
      _listKey.currentState?.removeItem(
        i,
        (context, animation) => _AnimatedItem(
          item: removedItem,
          animation: animation,
          direction: widget.direction,
          position: widget.slidePosition,
          turns: widget.rotationValue,
        ),
        duration: const Duration(milliseconds: 300),
      );
    }

    _isPlaying = false;
  }

  @override
  Widget build(BuildContext context) {
    final listWidget = AnimatedList(
      key: _listKey,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: widget.direction,
      initialItemCount: _animatedItems.length,
      itemBuilder: (context, index, animation) {
        Widget item = _animatedItems[index];

        if (index == 0 &&
            widget.direction == Axis.horizontal &&
            _itemHeight == null) {
          item = MeasureSize(
            onChange: (size) => setState(() => _itemHeight = size.height),
            child: item,
          );
        }

        if (index == 0 &&
            widget.direction == Axis.vertical &&
            _itemWeight == null) {
          item = MeasureSize(
            onChange: (size) => setState(() => _itemWeight = size.width),
            child: item,
          );
        }

        return _AnimatedItem(
          item: item,
          animation: animation,
          direction: widget.direction,
          position: widget.slidePosition,
          turns: widget.rotationValue,
        );
      },
    );

    if (widget.direction == Axis.horizontal && _itemHeight != null) {
      return SizedBox(height: _itemHeight, child: listWidget);
    }
    if (widget.direction == Axis.vertical && _itemWeight != null) {
      return SizedBox(width: _itemWeight, child: listWidget);
    }

    return listWidget;
  }
}

class _AnimatedItem extends StatelessWidget {
  final Widget item;
  final Animation<double> animation;
  final Axis direction;
  final Animation<double>? turns;
  final Animation<Offset>? position;

  const _AnimatedItem({
    required this.item,
    required this.animation,
    required this.direction,
    this.turns,
    this.position,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        axis: direction,
        child: SlideTransition(
          position:
              position ??
              Tween<Offset>(
                begin:
                    direction == Axis.horizontal
                        ? const Offset(-2, 0)
                        : const Offset(0, -2),
                end: Offset.zero,
              ).animate(animation),
          child: RotationTransition(
            turns:
                turns ?? Tween<double>(begin: 0.3, end: 1.0).animate(animation),
            child: item,
          ),
        ),
      ),
    );
  }
}
