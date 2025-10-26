import 'package:flutter/material.dart';
import 'package:fridge_pal/model/item.dart';
import 'package:fridge_pal/ui/widgets/manage_items/manage_items_content.dart';

class ManageItemScreen extends StatelessWidget {
  final Item? itemToEdit;
  
  const ManageItemScreen({super.key, this.itemToEdit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ManageItemsContent(itemToEdit: itemToEdit)
    );
  }
}