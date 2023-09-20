import 'package:flutter/material.dart';

class CutomTextField extends StatelessWidget {
  const CutomTextField(
      {super.key,
      required this.hintText,
      this.obscure = false,
      this.keyboardType,
      required this.onChanged, this.controller});
  final bool obscure;
  final TextInputType? keyboardType;
  final String hintText;
  final void Function(String?) onChanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscure,
      keyboardType: keyboardType,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF1565C0), width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      ),
    );
  }
}
