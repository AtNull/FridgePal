import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_pal/providers/items_providers.dart';
import 'package:fridge_pal/ui/screens/manage_item.dart';
import 'package:fridge_pal/ui/widgets/home/home_content.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsProvider = ref.watch(itemsNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: itemsProvider.when(
        data: (items) => HomeContentWidget(),
        error: (error, stackTrace) => Center(child: Text('$error')),
        loading: () => Center(child: CircularProgressIndicator())
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ManageItemScreen())
        )
      ),
    );
  }
}