import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_pal/network/api_service.dart';
import 'package:fridge_pal/network/item_repository.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final itemRepositoryProvider = Provider<ItemRespository>((ref) {
  final apiService = ref.read(apiServiceProvider);

  return ItemRespository(apiService: apiService);
});