import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdpativeTextField extends StatelessWidget {
  const AdpativeTextField(
      {super.key,
      required this.controller,
      this.keyboardType,
      required this.onSubmitted,
      required this.label});

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Function(String) onSubmitted;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
              controller: controller,
              keyboardType: keyboardType,
              onSubmitted: onSubmitted,
              placeholder: label,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            ),
          )
        : TextField(
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
