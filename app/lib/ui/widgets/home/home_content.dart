import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fridge_pal/model/item.dart';
import 'package:fridge_pal/providers/items_providers.dart';
import 'package:fridge_pal/ui/widgets/home/item_cell.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum Filter {
  all('All'),
  expired('Expired'),
  expiring('Expiring');

  final String label;

  const Filter(this.label);
}

final filteredItemsProvider = Provider.autoDispose.family<List<Item>, Filter>((ref, filter) {
  final items = ref.watch(itemsNotifierProvider);

  return switch (filter) {
    Filter.all => items.value ?? [],
    Filter.expired => [],
    Filter.expiring => []
  };
});

class HomeContentWidget extends HookConsumerWidget {
  const HomeContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {    
    final tabController = useTabController(initialLength: Filter.values.length);
    final items = ref.watch(filteredItemsProvider(Filter.values[tabController.index]));

    useListenable(tabController);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child:
                TextField()
              ),
              IconButton.filled(onPressed: (){}, icon: Icon(Icons.sort))
            ],
          ),
          TabBar(
            controller: tabController,
            tabs: [for (final tab in Filter.values) Tab(text: tab.label)],
          ),
          Expanded(child:
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => ItemCell(item: items[index])
          ))
        ]
      )
    );
  }
}