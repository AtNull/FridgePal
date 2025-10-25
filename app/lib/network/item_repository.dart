import 'package:fridge_pal/model/item.dart';
import 'package:fridge_pal/network/api_service.dart';

class ItemRespository {
  final ApiService apiService;

  ItemRespository({required this.apiService});

  Future<List<Item>> getItems() async {
    final response = await apiService.get('items');

    return (response.data as List).map((item) => Item.fromJson(item)).toList();
  }
}