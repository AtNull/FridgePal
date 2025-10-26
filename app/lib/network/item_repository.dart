import 'package:fridge_pal/model/item.dart';
import 'package:fridge_pal/network/api_service.dart';

class ItemRespository {
  final ApiService apiService;

  ItemRespository({required this.apiService});

  Future<List<Item>> getItems() async {
    final response = await apiService.get('items');

    return (response.data as List).map((item) => Item.fromJson(item)).toList();
  }

  Future<Item> addItem(String name, DateTime purchaseDate, DateTime expiryDate, int quantity, String imageUrl) async {
    final body = {
      'name': name,
      'purchaseDate': purchaseDate.toUtc().toIso8601String(),
      'expiryDate': expiryDate.toUtc().toIso8601String(),
      'quantity': quantity,
      'imageUrl': imageUrl
    };
    
    final response = await apiService.post('item', data: body);

    return Item.fromJson(response.data);
  }
}