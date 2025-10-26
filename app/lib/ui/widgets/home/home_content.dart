import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fridge_pal/providers/home_screen_providers.dart';
import 'package:fridge_pal/ui/screens/manage_item.dart';
import 'package:fridge_pal/ui/widgets/home/item_cell.dart';
import 'package:fridge_pal/ui/widgets/home/order_by_bottom_sheet.dart';
import 'package:fridge_pal/util/debouncer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeContentWidget extends HookConsumerWidget {
  const HomeContentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(filteredItemsProvider);
    final tabController = useTabController(initialLength: Filter.values.length);
    final searchTextController = useTextEditingController();

    final editItem = useCallback((item) =>
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ManageItemScreen(itemToEdit: item)),
      )
    );

    useEffect(() {
      var debouncer = Debouncer(delay: Duration(milliseconds: 200));

      void tabControllerListener() {
        ref.read(filterProvider.notifier).set(Filter.values[tabController.index]);
      }

      void searchTextControllerListener() {
        // let's only search when user's finished typing
        debouncer.debounce(
          () => ref.read(searchTextProvider.notifier).set(searchTextController.text)
        );
      }

      tabController.addListener(tabControllerListener);
      searchTextController.addListener(searchTextControllerListener);
      
      return () {
        tabController.removeListener(tabControllerListener);
        searchTextController.removeListener(searchTextControllerListener);
        debouncer.dispose();
      };
    }, []);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(controller: searchTextController)
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
              itemBuilder: (context, index) => ItemCell(
                key: ValueKey(items[index].id),
                item: items[index],
                onSelectItem: (item) => editItem(item),
              )
            )
          )
        ]
      )
    );
  }
}