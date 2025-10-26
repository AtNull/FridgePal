import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fridge_pal/model/item.dart';
import 'package:fridge_pal/ui/widgets/manage_items/quantity_input.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ManageItemsContent extends HookConsumerWidget {
  final Item? itemToEdit;

  const ManageItemsContent({super.key, this.itemToEdit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final nameTextController = useTextEditingController();
    final purchaseDateTextController = useTextEditingController();
    final expiryTextController = useTextEditingController();
    final quantityTextController = useTextEditingController(text: '1');

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
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameTextController,
                      decoration: const InputDecoration(
                        hintText: 'Name'
                      ),
                    ),
                    TextFormField(
                      controller: purchaseDateTextController,
                      decoration: const InputDecoration(
                        hintText: 'Purchase date'
                      ),
                      onTap: () => showDatePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030)
                      )
                    ),
                    TextFormField(
                      controller: expiryTextController,
                      decoration: const InputDecoration(
                        hintText: 'Expiry date'
                      ),
                      onTap: () => showDatePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030)
                      )
                    ),
                    QuantityInput(controller: quantityTextController),
                  ]
                )
              )
            )
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: (){
                
              },
              child: Text('Save')
            )
          )
        ]
      )
    );
  }
}