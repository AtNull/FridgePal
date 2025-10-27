import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fridge_pal/util/theme_constants.dart';

class QuantityInput extends StatelessWidget {
  final TextEditingController controller;

  const QuantityInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: spacing,
      children: [
        const Text(style: TextStyle(fontSize: 16), 'Quantity'),
        IconButton.filled(
          onPressed: () {
            var quantity = int.tryParse(controller.text) ?? 1;

            quantity = max(1, quantity - 1); // can't have 0 of something

            controller.text = (quantity).toString();
          },
          icon: const Icon(Icons.remove)
        ),
        SizedBox(
          width: 70,
          child: TextFormField(
            decoration: const InputDecoration(contentPadding: EdgeInsets.all(0)),
            textAlign: TextAlign.center,
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
          icon: const Icon(Icons.add)
        ),
      ],
    );
  }
}