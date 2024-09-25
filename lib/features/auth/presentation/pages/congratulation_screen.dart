import 'package:flutter/material.dart';

import '../widgets/auth_widgets.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              ClipRRect(
                child: Image.asset("assets/images/sign_up.png"),
              ),
              const ContainerForCongratulationScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
