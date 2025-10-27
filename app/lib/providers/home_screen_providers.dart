import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_pal/model/item.dart';
import 'package:fridge_pal/providers/items_providers.dart';

enum Filter {
  all('All'),
  expired('Expired'),
  expiring('Expiring');

  final String label;

  const Filter(this.label);
}

enum Order {
  dateOfPurchaseAsc('Date of Purchase ↑ (Oldest first)'),
  dateOfPurchaseDesc('Date of Purchase ↓ (Newest first)'),
  expiryDateAsc('Expiry Date ↑ (Soonest first)'),
  expiryDateDesc('Expiry Date ↓ (Latest first)'),
  quantityAsc('Quantity ↑ (Lowest first)'),
  quantityDesc('Quantity ↓ (Highest first)'),
  nameAsc('Name A-Z'),
  nameDesc('Name Z-A');

  final String label;

  const Order(this.label);
}

class FilterNotifier extends Notifier<Filter> {
  @override
  Filter build() => Filter.all;

  void set(value) => state = value;
}

final filterProvider = NotifierProvider<FilterNotifier, Filter>(FilterNotifier.new, isAutoDispose: true);

class OrderNotifier extends Notifier<Order> {
  @override
  Order build() => Order.nameAsc;

  void set(value) => state = value;
}

final orderProvider = NotifierProvider<OrderNotifier, Order>(OrderNotifier.new, isAutoDispose: true);

class SearchTextNotifier extends Notifier<String> {
  @override
  String build() => '';

  void set(value) => state = value;
}

final searchTextProvider = NotifierProvider<SearchTextNotifier, String>(SearchTextNotifier.new, isAutoDispose: true);

final filteredItemsProvider = Provider.autoDispose<List<Item>>((ref) {
  final filter = ref.watch(filterProvider);
  final order = ref.watch(orderProvider);
  final searchText = ref.watch(searchTextProvider);
  final itemsAsync = ref.watch(itemsNotifierProvider);

  var items = itemsAsync.value ?? [];

  items = switch(filter) {
    Filter.all => items,
    Filter.expired => items.where((item) => _isItemExpiring(item)).toList(),
    Filter.expiring => items.where((item) => _isItemExpired(item)).toList(),
  };

  final normalizedSearchText = searchText.trim().toLowerCase();

  items = items.where(
    (item) => item.name.toLowerCase().contains(normalizedSearchText)
  ).toList();

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

bool _isItemExpiring(Item item) {
  final now = DateTime.now();
  final beginningOfToday = DateTime(now.year, now.month, now.day);
  final nextWeek = beginningOfToday.add(const Duration(days: 7));

  return item.expiryDate.isAfter(now) && item.expiryDate.isBefore(nextWeek);
}

bool _isItemExpired(Item item) {
  final now = DateTime.now();

  return item.expiryDate.isBefore(now);
}