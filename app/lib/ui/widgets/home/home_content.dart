import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fridge_pal/providers/home_screen_providers.dart';
import 'package:fridge_pal/providers/items_providers.dart';
import 'package:fridge_pal/ui/screens/manage_item.dart';
import 'package:fridge_pal/ui/widgets/home/item_cell.dart';
import 'package:fridge_pal/ui/widgets/home/order_by_bottom_sheet.dart';
import 'package:fridge_pal/util/debouncer.dart';
import 'package:fridge_pal/util/theme_constants.dart';
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

    final deleteItem = useCallback((item) =>
      ref.read(itemsNotifierProvider.notifier).delete(item.id)
    );

    useEffect(() {
      var debouncer = Debouncer(delay: const Duration(milliseconds: 200));

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
      child: Padding(padding: const EdgeInsetsGeometry.only(top: spacing),
        child: Column(
          spacing: spacing,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: spacing),
              child: Row(
                spacing: spacing,
                children: [
                  Expanded(
                    child: SizedBox(
                    height: mediumWidgetHeight,
                      child: TextField(
                        controller: searchTextController,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search)
                        ),
                      )
                    )
                  ),
                  IconButton.filled(
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => OrderByBottomSheet(
                        selectedOrder: ref.read(orderProvider),
                        onSelected: (order) => ref.read(orderProvider.notifier).set(order),
                      )
                    ),
                    icon: const Icon(Icons.sort)
                  )
                ],
              )
            ),
            TabBar(
              padding: const EdgeInsets.symmetric(horizontal: spacing),
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              controller: tabController,
              tabs: [for (final tab in Filter.values) Tab(text: tab.label)],
            ),
            Expanded(
              child: ListView.builder(
                itemExtent: mediumWidgetHeight + spacing,
                itemCount: items.length,
                itemBuilder: (context, index) => ItemCell(
                  key: ValueKey(items[index].id),
                  item: items[index],
                  onSelectItem: (item) => editItem(item),
                  onDismissItem: (item) => deleteItem(item),
                )
              )
            )
          ]
        )
      )
    );
  }
}