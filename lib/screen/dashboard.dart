import 'package:change_notifier_demo/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, int index) {
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
                      TextButton(onPressed: () {
                        setState(() {
                          item.isAdded = !item.isAdded;
                        });
                      },
                        child: Text(item.isAdded ? 'Remove from cart' : 'Add to cart'),
                      )
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
