
import 'package:flutter/material.dart';

class DraggableRotatableWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double initialDx;
  final double initialDy;
  final void Function(double dx, double dy) onPositionChanged; // 👈

  const DraggableRotatableWidget({
    super.key,
    required this.child,
    required this.onTap,
    required this.onPositionChanged, // 👈
    this.initialDx = 0,
    this.initialDy = 0,
  });

  @override
  State<DraggableRotatableWidget> createState() => _DraggableRotatableWidgetState();
}
class _DraggableRotatableWidgetState extends State<DraggableRotatableWidget> {
  late double _dx; // 👈 torna nello State per il rendering
  late double _dy;
  double _angle = 0;
  double _baseAngle = 0;
  double _scale = 1.0;
  double _baseScale = 1.0;
  double _baseDx = 0;
  double _baseDy = 0;
  Offset _baseFocal = Offset.zero;

  @override
  void initState() {
    super.initState();
    _dx = widget.initialDx; // 👈 inizializza dal notifier
    _dy = widget.initialDy;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(       // 👈 torna dentro il widget
      left: _dx,
      top: _dy,
      child: GestureDetector(
        onTap: widget.onTap,
        onScaleStart: (details) {
          _baseAngle = _angle;
          _baseScale = _scale;
          _baseDx = _dx;
          _baseDy = _dy;
          _baseFocal = details.focalPoint;
        },
        onScaleUpdate: (details) {
          setState(() {
            if (details.pointerCount >= 2) {
              _scale = (_baseScale * details.scale).clamp(0.5, 3.0);
              _angle = _baseAngle + details.rotation;
            } else {
              _dx = _baseDx + details.focalPoint.dx - _baseFocal.dx;
              _dy = _baseDy + details.focalPoint.dy - _baseFocal.dy;
              widget.onPositionChanged(_dx, _dy); // 👈 aggiorna notifier silenziosamente
            }
          });
        },
        child: Transform.scale(
          scale: _scale,
          child: Transform.rotate(
            angle: _angle,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}