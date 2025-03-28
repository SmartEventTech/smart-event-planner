import 'package:flutter/material.dart';
import 'package:smart_event_planner/shared/custom_curved/curved_edges_widget.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.3,
        color: Colors.green,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Image.asset(
                'assets/images/login.png',
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Image.asset(
                'assets/images/Opacitylogin.png',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
