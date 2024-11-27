import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/containers/t_ticket_shape_clipper.dart';

class TTicketShapeWidget extends StatelessWidget {
  const TTicketShapeWidget({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketShapeClipper(),
      child: child,
    );
  }
}
