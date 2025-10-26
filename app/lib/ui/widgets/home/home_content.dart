import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fridge_pal/providers/home_screen_providers.dart';
import 'package:fridge_pal/ui/widgets/home/item_cell.dart';
import 'package:fridge_pal/ui/widgets/home/order_by_bottom_sheet.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeContentWidget extends HookConsumerWidget {
  const HomeContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {    
    final tabController = useTabController(initialLength: Filter.values.length);
    final items = ref.watch(filteredItemsProvider);

    useListenable(tabController);
    useEffect(() {
      void tabControllerListener() {
        ref.read(filterProvider.notifier).set(Filter.values[tabController.index]);
      }

      tabController.addListener(tabControllerListener);
      
      return () {
        tabController.removeListener(tabControllerListener);
      };
    }, []);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField()
              ),
              IconButton.filled(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => OrderByBottomSheet(
                    selectedOrder: ref.read(orderProvider),
                    onSelected: (order) => ref.read(orderProvider.notifier).set(order),
                  )
                ),
                icon: Icon(Icons.sort)
              )
            ],
          ),
          TabBar(
            controller: tabController,
            tabs: [for (final tab in Filter.values) Tab(text: tab.label)],
          ),
          Expanded(
            child: ListView.builder(
              itemExtent: 48,
              itemCount: items.length,
              itemBuilder: (context, index) => ItemCell(key: ValueKey(items[index].id), item: items[index])
            )
          )
        ]
      )
    );
  }
}