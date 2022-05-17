import 'package:change_notifier_demo/model/cart_model.dart';
import 'package:change_notifier_demo/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../widget/badge_icon.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<ItemModel> list = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 10; i++) {
      list.add(ItemModel(
          'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-13-pro-max-green-select?wid=940&hei=1112&fmt=png-alpha&.v=1644969385495',
          'iPhone $i',
          10000,
          4.5,
          false));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, widget) {
              return IconButton(
                icon: BadgeIcon(
                    icon: const Icon(Icons.shopping_cart),
                    badgeCount: cart.itemCount),
                onPressed: () {
                  // do something
                },
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, index) {
          var item = list[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                item.image,
                height: 200,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(item.name),
                  RatingBar.builder(
                    initialRating: item.rating,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 25,
                    ignoreGestures: true,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  Row(
                    children: [
                      Text('\u{20B9}${item.price}'),
                      _AddRemoveButton(item: item)
                    ],
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

class _AddRemoveButton extends StatelessWidget {
  final ItemModel item;

  const _AddRemoveButton({required this.item});

  @override
  Widget build(BuildContext context) {
    // The context.select() method will let you listen to changes to
    // a *part* of a model. You define a function that "selects" (i.e. returns)
    // the part you're interested in, and the provider package will not rebuild
    // this widget unless that particular part of the model changes.
    //
    // This can lead to significant performance improvements.
    var isInCart = context.select<CartModel, bool>(
      // Here, we are only interested whether [item] is inside the cart.
      (cart) => cart.items.contains(item),
    );

    var cart = context.read<CartModel>();
    return TextButton(
      onPressed: isInCart ? () => cart.remove(item) : () => cart.add(item),
      child: isInCart ? const Icon(Icons.check) : const Icon(Icons.add),
    );
  }
}
