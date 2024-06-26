import 'package:flutter/material.dart';

import '../commons/commons.dart';

class RegistrationButton extends StatelessWidget {
  const RegistrationButton({super.key, required this.buttonText, required this.onClick});

  final String buttonText;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: circularBorder24,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
        child: Text(
          buttonText,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}


