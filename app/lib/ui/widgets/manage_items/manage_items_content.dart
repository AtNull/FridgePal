import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fridge_pal/model/item.dart';
import 'package:fridge_pal/providers/items_providers.dart';
import 'package:fridge_pal/ui/widgets/manage_items/quantity_input.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ManageItemsContent extends HookConsumerWidget {
  final Item? itemToEdit;

  const ManageItemsContent({super.key, this.itemToEdit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final purchaseDate = useState<DateTime?>(null);
    final expiryDate = useState<DateTime?>(null);

    final nameTextController = useTextEditingController();
    final purchaseDateTextController = useTextEditingController();
    final expiryTextController = useTextEditingController();
    final quantityTextController = useTextEditingController(text: '1');

    final saving = useState(false);

    Future<void> saveItem() async {
      if (formKey.currentState == null || formKey.currentState?.validate() == false) {
        return;
      }

      try {
        saving.value = true;

        var quantity = int.tryParse(quantityTextController.text) ?? 1;

        quantity = max(1, quantity);

        await ref.read(itemsNotifierProvider.notifier).add(
          nameTextController.text,
          purchaseDate.value ?? DateTime.now(),
          expiryDate.value ?? DateTime.now(),
          quantity,
          ''
        );

        if (context.mounted) {
          Navigator.pop(context);
        }
      } catch (error) {
        if (context.mounted) {
          saving.value = false;

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text('Oops! Something went wrong while connecting. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => saveItem(),
                  child: const Text('Retry'),
                ),
              ],
            ), 
          );
        }
      }
    }

    Future<void> selectDate(TextEditingController textController, ValueNotifier<DateTime?> dateNotifier) async {
      final DateTime? date = await showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030)
      );

      if (date != null) {
        dateNotifier.value = date;
        textController.text = '${date.day}. ${date.month}. ${date.year}';
      }
    }

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.arrow_back)
              ),
              Text('Add item')
            ]
          ),
          Expanded(
            child: SingleChildScrollView(
              child: AbsorbPointer(
                absorbing: saving.value,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameTextController,
                        decoration: const InputDecoration(
                          hintText: 'Name'
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        controller: purchaseDateTextController,
                        decoration: const InputDecoration(
                          hintText: 'Purchase date'
                        ),
                        onTap: () => selectDate(purchaseDateTextController, purchaseDate),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Purchase date is required';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        controller: expiryTextController,
                        decoration: const InputDecoration(
                          hintText: 'Expiry date'
                        ),
                        onTap: () => selectDate(expiryTextController, expiryDate),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Expiry date is required';
                          }

                          return null;
                        },
                      ),
                      QuantityInput(controller: quantityTextController),
                    ]
                  )
                )
              )
            )
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => saveItem(),
              child: Text(saving.value ? 'Saving' : 'Save')
            )
          )
        ]
      )
    );
  }
}