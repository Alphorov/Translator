import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OutputField extends StatelessWidget {
  const OutputField({
    Key? key,
    required this.outputController,
  }) : super(key: key);

  final TextEditingController outputController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: TextField(
        style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white),
        cursorWidth: 2,
        cursorRadius: const Radius.circular(6),
        cursorHeight: 22,
        cursorColor: Colors.white,
        controller: outputController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(8),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
    );
  }
}
