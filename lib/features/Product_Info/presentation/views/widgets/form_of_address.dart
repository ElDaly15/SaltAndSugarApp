import 'package:flutter/material.dart';
import 'package:saltandsugar/core/widgets/CustomTextField.dart';

class FormOfAddress extends StatelessWidget {
  const FormOfAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          textInputType: TextInputType.name,
          obscure: false,
          mainText: 'Another Address',
          onChange: (value) {
            AnotherAddress = value;
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            minimumSize: Size(50, 40),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  'Another Address Added Successfuly',
                  style: TextStyle(fontFamily: 'Gilroy'),
                ),
              ),
            );
            Navigator.pop(context);
          },
          child: Text(
            'Confirm',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Gilroy-Bold',
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

String? AnotherAddress;
