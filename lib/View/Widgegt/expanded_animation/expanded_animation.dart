import 'package:flutter/material.dart';

class ExpandedAnimation extends StatefulWidget {
  final Widget child;
  final bool expand;

  const ExpandedAnimation({
    super.key,
    required this.child,
    this.expand = false,
  });

  @override
  State<ExpandedAnimation> createState() => _ExpandedAnimationState();
}

class _ExpandedAnimationState extends State<ExpandedAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    if (widget.expand) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(ExpandedAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expand) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: widget.child,
    );
  }
}
