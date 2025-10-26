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

  Future<void> edit(String id, String name, DateTime purchaseDate, DateTime expiryDate, int quantity, String imageUrl) async {
    final repo = ref.read(itemRepositoryProvider);

    await repo.editItem(id, name, purchaseDate, expiryDate, quantity, imageUrl);

    final currentItems = state.value ?? [];

    final updatedItems = currentItems.map((item) =>
      item.id == id ?
        item.copyWith(
          name: name,
          purchaseDate: purchaseDate,
          expiryDate: expiryDate,
          quantity: quantity,
          imageUrl: imageUrl,
        )
      :
      item
    ).toList();

    state = AsyncValue.data(updatedItems);
  }
}

final itemsNotifierProvider = AsyncNotifierProvider<AsyncItemsNotifier, List<Item>>(() => AsyncItemsNotifier());