import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/state/products.dart';

import 'whis_list_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //instantiate our Products class using Get.put()
  final Products _p = Get.put(Products());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Getx State')),
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),

        //this button also shows you how many items in the wish list
        //it lets you goto the WishListScreen
        InkWell(
          child: Container(
            width: 300, height: 80,
            color: Colors.purple,
            alignment: Alignment.center,
            //use obx(() => to update Text() whenever _wishList.items.length is changed)
            child: Obx(
              () => Text(
                'Wish List : ${_p.wishListItems.length}',
                style: const TextStyle(fontSize: 28, color: Colors.white),
              ),
            ),
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WishListScreen()),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          //Display all produts in home screen
          child: ListView.builder(
              itemCount: _p.items.length,
              itemBuilder: (context, index) {
                final product = _p.items[index];
                return Card(
                  key: ValueKey(product.id),
                  margin: EdgeInsets.all(5),
                  color: Colors.purple[200],
                  child: ListTile(
                    title: Text(
                      product.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                    trailing: Obx(() => IconButton(
                          onPressed: () {
                            if (product.inWishList.value == false) {
                              _p.addItem(product.id);
                            } else {
                              _p.removeItem(product.id);
                            }
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: product.inWishList.value == false
                                ? Colors.white
                                : Colors.orange,
                          ),
                        )),
                  ),
                );
              }),
        )
      ]),
    );
  }
}
