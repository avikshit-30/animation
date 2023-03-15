import 'package:animation/view/cartscreen.dart';
import 'package:flutter/material.dart';
import 'package:animation/models/model.dart';
import 'package:animation/viewmodel/viewModel.dart';
import 'package:provider/provider.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, '/screen3');
                },
              ),
            ],
            title: Text("Itemss"),
          ),
          body: Consumer<ItemsViewModel>(builder: (context, viewModell, child) {
            return ListView.builder(
              itemCount: viewModell.items.length,
              itemBuilder: (context, index) {
                final item = viewModell.items[index];
                return Container(
                    color: Colors.black87,
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text("${item.price}"),
                      trailing: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Provider.of(context).addToCart(item);
                        },
                      ),
                    ));
              },
            );
          })),
    );
  }
}
