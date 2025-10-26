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
        IconButton.filled(onPressed: (){}, icon: Icon(Icons.remove)),
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
        IconButton.filled(onPressed: (){}, icon: Icon(Icons.add)),
      ],
    );
  }
}