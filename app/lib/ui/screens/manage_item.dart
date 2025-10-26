import 'package:flutter/material.dart';
import 'package:fridge_pal/ui/widgets/manage_items/manage_items_content.dart';

class ManageItemScreen extends StatelessWidget {
  const ManageItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ManageItemsContent()
    );
  }
}