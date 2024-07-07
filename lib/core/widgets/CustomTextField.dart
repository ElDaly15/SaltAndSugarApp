import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.mainText,
    required this.onChange,
    required this.obscure,
    required this.textInputType,
  });

  final String mainText;
  final Function(String) onChange;
  final bool obscure;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mainText,
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: 'Gilroy',
            color: Color(0xff808080),
          ),
        ),
        SizedBox(height: 8.0),
        TextFormField(
          obscureText: obscure,
          keyboardType: textInputType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field cannot be empty';
            }
            return null;
          },
          onChanged: onChange,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff808080)),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff808080)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
