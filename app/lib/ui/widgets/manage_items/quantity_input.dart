import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuantityInput extends StatelessWidget {
  final TextEditingController controller;

  const QuantityInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Quantity'),
        IconButton.filled(
          onPressed: () {
            var quantity = int.tryParse(controller.text) ?? 1;

            quantity = max(1, quantity - 1); // can't have 0 of something

            controller.text = (quantity).toString();
          },
          icon: Icon(Icons.remove)
        ),
        SizedBox(
          width: 100,
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: controller,
            onTap: () => controller.text = ''
          )
        ),
        IconButton.filled(
          onPressed: () {
            final quantity = int.tryParse(controller.text) ?? 1;

            controller.text = (quantity + 1).toString();
          },
          icon: Icon(Icons.add)
        ),
      ],
    );
  }
}