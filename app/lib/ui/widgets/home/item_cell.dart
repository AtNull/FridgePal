import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:fridge_pal/model/item.dart';

class ItemCell extends StatelessWidget {
  final Item item;

  const ItemCell({super.key, required this.item});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          CachedNetworkImage(
            width: 48,
            height: 48,
            imageUrl: item.imageUrl
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(overflow: TextOverflow.ellipsis, item.name),
                    Expanded(
                      child: Text('${item.quantity}')
                    )
                  ]
                ),
                Row(
                  children: [
                    Text(overflow: TextOverflow.ellipsis, 'Bought ${item.purchaseDate}'),
                    Expanded(
                      child: Text(overflow: TextOverflow.ellipsis, 'Expires ${item.expiryDate}')
                    )
                  ]
                )
              ]
            )
          )
        ],
      )
    );
  }
}