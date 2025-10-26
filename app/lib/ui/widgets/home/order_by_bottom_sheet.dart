import 'package:flutter/material.dart';
import 'package:fridge_pal/providers/home_screen_providers.dart';

class OrderByBottomSheet extends StatelessWidget {
  final Order selectedOrder;
  final Function(Order) onSelected;

  const OrderByBottomSheet({super.key, required this.selectedOrder, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          for (final order in Order.values)
            TextButton(
              onPressed: () {
                onSelected(order);
                Navigator.pop(context);
              },
              child: Text(order.label)
            )
        ],
      )
    );
  }
}