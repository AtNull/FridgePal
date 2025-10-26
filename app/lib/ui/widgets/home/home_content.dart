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

enum Order {
  dateOfPurchaseAsc,
  dateOfPurchaseDesc,
  expiryDateAsc,
  expiryDateDesc,
  quantityAsc,
  quantityDesc,
  nameAsc,
  nameDesc
}

class FilterNotifier extends Notifier<Filter> {
  @override
  Filter build() => Filter.all;

  void set(value) => state = value;
}

final filterProvider = NotifierProvider<FilterNotifier, Filter>(FilterNotifier.new);

class OrderNotifier extends Notifier<Order> {
  @override
  Order build() => Order.nameAsc;

  void set(value) => state = value;
}

final orderProvider = NotifierProvider<OrderNotifier, Order>(OrderNotifier.new);

final _itemsNotifierProvider = AsyncNotifierProvider<AsyncItemsNotifier, List<Item>>(AsyncItemsNotifier.new);

final filteredItemsProvider = Provider.autoDispose<List<Item>>((ref) {
  final filter = ref.watch(filterProvider);
  final order = ref.watch(orderProvider);
  final itemsAsync = ref.watch(_itemsNotifierProvider);

  var items = itemsAsync.value ?? [];

  items = switch(filter) {
    Filter.all => items,
    Filter.expired => items.where((item) => isItemExpiring(item)).toList(),
    Filter.expiring => items.where((item) => isItemExpired(item)).toList(),
  };

  switch(order) {
    case Order.dateOfPurchaseAsc: items.sort((a,b) => a.purchaseDate.compareTo(b.purchaseDate));
    case Order.dateOfPurchaseDesc: items.sort((a,b) => b.purchaseDate.compareTo(a.purchaseDate));
    case Order.expiryDateAsc: items.sort((a,b) => a.expiryDate.compareTo(b.expiryDate));
    case Order.expiryDateDesc: items.sort((a,b) => b.expiryDate.compareTo(a.expiryDate));
    case Order.quantityAsc: items.sort((a,b) => a.quantity.compareTo(b.quantity));
    case Order.quantityDesc: items.sort((a,b) => b.quantity.compareTo(a.quantity));
    case Order.nameAsc: items.sort((a,b) => a.name.compareTo(b.name));
    case Order.nameDesc: items.sort((a,b) => b.name.compareTo(a.name));
  }

  return items;
});

bool isItemExpiring(Item item) {
  final now = DateTime.now();
  final beginningOfToday = DateTime(now.year, now.month, now.day);
  final nextWeek = beginningOfToday.add(Duration(days: 7));

  return item.expiryDate.isAfter(now) && item.expiryDate.isBefore(nextWeek);
}

bool isItemExpired(Item item) {
  final now = DateTime.now();

  return item.expiryDate.isBefore(now);
}

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