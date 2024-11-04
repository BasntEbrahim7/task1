import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final bool readOnly;
  final TextDirection textDirection;
  final KeyboardType;

  const InputFieldWidget({
    Key? key,
    required this.label,
    this.controller,
    this.hintText,
    this.readOnly = false,
    this.textDirection = TextDirection.ltr, this.KeyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        TextField(
          keyboardType:KeyboardType ,
          controller: controller,
          readOnly: readOnly,
          textDirection: textDirection,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
      ],
    );
  }
}
