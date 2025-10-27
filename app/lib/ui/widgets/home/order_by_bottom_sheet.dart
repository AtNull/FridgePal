import 'package:flutter/material.dart';
import 'package:fridge_pal/providers/home_screen_providers.dart';
import 'package:fridge_pal/util/theme_constants.dart';

class OrderByBottomSheet extends StatelessWidget {
  final Order selectedOrder;
  final Function(Order) onSelected;

  const OrderByBottomSheet({super.key, required this.selectedOrder, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: spacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: cornerRadius),
            for (final order in Order.values)
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: order == selectedOrder ? Theme.of(context).primaryColor : null
                ),
                onPressed: () {
                  onSelected(order);
                  Navigator.pop(context);
                },
                child: Text(order.label)
              )
          ],
        )
      )
    );
  }
}