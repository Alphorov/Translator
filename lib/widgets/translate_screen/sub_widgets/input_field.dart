import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.inputController,
  }) : super(key: key);

  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white),
      autofocus: false,
      cursorWidth: 2,
      cursorRadius: const Radius.circular(6),
      cursorHeight: 22,
      cursorColor: Colors.white,
      controller: inputController,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(12),
        hintText: 'Введите текст',
        hintStyle: TextStyle(color: Color(0xffC9CACC)),
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.multiline,
      maxLines: null,
    );
  }
}
