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
}

final itemsNotifierProvider = AsyncNotifierProvider<AsyncItemsNotifier, List<Item>>(() => AsyncItemsNotifier());