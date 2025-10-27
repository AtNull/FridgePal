import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fridge_pal/model/item.dart';
import 'package:fridge_pal/util/theme_constants.dart';
import 'package:transparent_image/transparent_image.dart';

enum Expiry {
  normal(Colors.black),
  expiring(Color(0xFFFF8800)),
  expired(Color(0xFFB00020));

  final Color color;

  const Expiry(this.color);

  static Expiry fromDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    if (difference < 0) {
      return Expiry.expired;
    } else if (difference <= 7) {
      return Expiry.expiring;
    } else {
      return Expiry.normal;
    }
  }
}

class ItemCell extends StatelessWidget {
  final Item item;
  final Function(Item) onSelectItem;
  final Function(Item) onDismissItem;

  const ItemCell({super.key, required this.item, required this.onSelectItem, required this.onDismissItem});

  String formatDate(DateTime date) {
    final now = DateTime.now();

    if (date.isBefore(now)) {
      return 'Expired';
    }

    final difference = date.difference(now).inDays;

    if (difference <= 30) {
      if (difference == 0) {
        return 'Expires today';
      } else if (difference == 1) {
        return 'Expires tommorow';
      } else {
        return 'Expires in $difference days';
      }
    } else {
      return 'Expires ${date.day}. ${date.month}. ${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final purchaseDateText = 'Bought ${item.purchaseDate.day}. ${item.purchaseDate.month}.';
    final expiry = Expiry.fromDate(item.expiryDate);
    final expiryDateText = formatDate(item.expiryDate);

    return Dismissible(
      key: ValueKey('dismissable_${item.id}'),
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: spacing),
        color: Theme.of(context).colorScheme.error,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.delete, color: Colors.white),
            Icon(Icons.delete, color: Colors.white)
          ],
        )
      ),
      onDismissed: (direction) => onDismissItem(item),
      child: GestureDetector(
        onTap: () => onSelectItem(item),
        child: Row(
          children: [
            const SizedBox(width: spacing),
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(cornerRadius),
              child: CachedNetworkImage(
                width: mediumWidgetHeight,
                height: mediumWidgetHeight,
                imageUrl: item.imageUrl,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Image.memory(kTransparentImage),
              )
            ),
            const SizedBox(width: spacing),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      Text(
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                        item.name
                      ),
                      const Text('•'),
                      Expanded(
                        child: Text('${item.quantity} ${item.quantity > 1 ? 'pcs' : 'pc'}')
                      )
                    ]
                  ),
                  Row(
                    children: [
                      const Icon(
                        size: 12,
                        Icons.calendar_month
                      ),
                      const SizedBox(width: 2),
                      Text(overflow: TextOverflow.ellipsis, purchaseDateText),
                      const SizedBox(width: 4),
                      Icon(
                        size: 12,
                        color: expiry.color,
                        Icons.alarm
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          style: TextStyle(
                            color: expiry.color,
                            fontWeight: FontWeight.w600
                          ),
                          overflow: TextOverflow.ellipsis,
                          expiryDateText
                        )
                      )
                    ]
                  )
                ]
              )
            )
          ],
        )
      )
    );
  }
}