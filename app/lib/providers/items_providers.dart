import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_pal/model/item.dart';
import 'package:fridge_pal/providers/api_provider.dart';

class AsyncItemsNotifier extends AsyncNotifier<List<Item>> {
  @override
  FutureOr<List<Item>> build() async {
    final repo = ref.read(itemRepositoryProvider);

    return repo.getItems();
  }

  Future<void> add(String name, DateTime purchaseDate, DateTime expiryDate, int quantity, String imageUrl) async {
    final repo = ref.read(itemRepositoryProvider);

    final addedItem = await repo.addItem(name, purchaseDate, expiryDate, quantity, imageUrl);

    final currentItems = state.value ?? [];

    state = AsyncValue.data([...currentItems, addedItem]);
  }
}

final itemsNotifierProvider = AsyncNotifierProvider<AsyncItemsNotifier, List<Item>>(() => AsyncItemsNotifier());