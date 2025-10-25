import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_pal/providers/items_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(itemsNotifierProvider);

    return Scaffold(
      body: itemsAsync.when(
        data: (items) => Text(items[0].name),
        error: (error, stackTrace) => Text('error'),
        loading: () => Center(child: CircularProgressIndicator())
      ),
    );
  }
}