import 'package:flutter/material.dart';

class RegistrationField extends StatelessWidget {
  const RegistrationField({super.key, required this.controller, required this.hintText, required this.onChanged});

  final TextEditingController controller;
  final String hintText;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}
