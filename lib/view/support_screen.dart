import 'package:flutter/material.dart';

class FaultRouteScreen extends StatelessWidget {
  const FaultRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.support_agent_sharp,
              size: 80,
              color: Colors.grey.shade500,
            ),
            SizedBox(height: 30),
            Text(
              'Call for support',
              style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
