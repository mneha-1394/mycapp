import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final Icon prefixIcon;
  final suffixIcon;
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput({super.key,  required this.textEditingController, this.isPass=false, required this.hintText, required this.textInputType, required this.prefixIcon, required this.suffixIcon});
  
  @override
  Widget build(BuildContext context) {
    final inputBorder=OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText:hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      textInputAction: TextInputAction.next,
      obscureText: isPass,
    );
  }
}