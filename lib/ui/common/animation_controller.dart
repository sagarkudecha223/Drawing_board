import 'package:flutter/material.dart';

class AnimateControllers extends StatefulWidget {
  final Tween<Offset> offset;
  final Widget child;
  final bool isChange;

  const AnimateControllers(
      {super.key,
        required this.offset,
        required this.child,
        required this.isChange});

  @override
  State<AnimateControllers> createState() => _AnimateControllersState();
}

class _AnimateControllersState extends State<AnimateControllers>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _slideAnimation = widget.offset.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(covariant AnimateControllers oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isChange) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }
}
