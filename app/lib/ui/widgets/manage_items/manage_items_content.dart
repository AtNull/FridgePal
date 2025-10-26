import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fridge_pal/model/item.dart';
import 'package:fridge_pal/providers/items_providers.dart';
import 'package:fridge_pal/ui/widgets/home/common/dialog.dart';
import 'package:fridge_pal/ui/widgets/manage_items/quantity_input.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ManageItemsContent extends HookConsumerWidget {
  final Item? itemToEdit;

  const ManageItemsContent({super.key, this.itemToEdit});

  String formatDate(DateTime date) {
    return '${date.day}. ${date.month}. ${date.year}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final purchaseDate = useState<DateTime?>(itemToEdit?.purchaseDate);
    final expiryDate = useState<DateTime?>(itemToEdit?.expiryDate);

    final nameTextController = useTextEditingController(text: itemToEdit?.name);
    final purchaseDateTextController = useTextEditingController(
      text: itemToEdit != null ? formatDate(itemToEdit!.purchaseDate) : null
    );
    final expiryTextController = useTextEditingController(
      text: itemToEdit != null ? formatDate(itemToEdit!.expiryDate) : null
    );
    final quantityTextController = useTextEditingController(text: itemToEdit?.quantity.toString() ?? '1');

    final saving = useState(false);

    Future<void> saveItem() async {
      if (formKey.currentState == null || formKey.currentState?.validate() == false) {
        return;
      }

      try {
        saving.value = true;

        var quantity = int.tryParse(quantityTextController.text) ?? 1;

        quantity = max(1, quantity);

        if (itemToEdit == null) {
          await ref.read(itemsNotifierProvider.notifier).add(
            nameTextController.text,
            purchaseDate.value ?? DateTime.now(),
            expiryDate.value ?? DateTime.now(),
            quantity,
            ''
          );
        } else {
          await ref.read(itemsNotifierProvider.notifier).edit(
            itemToEdit!.id,
            nameTextController.text,
            purchaseDate.value ?? DateTime.now(),
            expiryDate.value ?? DateTime.now(),
            quantity,
            itemToEdit?.imageUrl ?? ''
          );
        }

        if (context.mounted) {
          Navigator.pop(context);
        }
      } catch (error) {
        if (context.mounted) {
          saving.value = false;

          showAlert(
            context,
            'Oops! Something went wrong while connecting. Please try again.',
            'Retry',
            () => Navigator.pop(context),
            () {
              Navigator.pop(context);
              saveItem();
            }
          );
        }
      }
    }

    Future<void> deleteItem () async {
      try {
        saving.value = true;

        await ref.read(itemsNotifierProvider.notifier).delete(
          itemToEdit!.id
        );

        if (context.mounted) {
          Navigator.pop(context);
        }
      } catch (error) {
        if (context.mounted) {
          saving.value = true;

          showAlert(
            context,
            'Oops! Something went wrong while connecting. Please try again.',
            'Retry',
            () => Navigator.pop(context),
            () {
              Navigator.pop(context);
              deleteItem();
            }
          );
        }
      }
    }

    final confirmDeletion = useCallback(() {
      final id = itemToEdit?.id;

      if (id != null) {
        showAlert(
          context,
          'Are you sure? This cannot be undone.',
          'Delete',
          () => Navigator.pop(context),
          () {
            Navigator.pop(context);
            deleteItem();
          }
        );
      }
    });

    Future<void> selectDate(TextEditingController textController, ValueNotifier<DateTime?> dateNotifier) async {
      final DateTime? date = await showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030)
      );

      if (date != null) {
        dateNotifier.value = date;
        textController.text = formatDate(date);
      }
    }

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back)
              ),
              Text(itemToEdit == null ? 'Add item' : 'Edit item'),
              Spacer(),
              if (itemToEdit != null)
                IconButton(
                  onPressed: () => confirmDeletion(),
                  icon: Icon(Icons.delete)
                )
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
                        readOnly: true,
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
                        readOnly: true,
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