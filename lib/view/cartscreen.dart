import 'package:flutter/material.dart';
import 'package:animation/models/model.dart';
import 'package:animation/viewmodel/viewModel.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Shopping Cart",
          style: TextStyle(color: Color.fromARGB(255, 228, 93, 9)),
        ),
      ),
      body: Consumer<ItemsViewModel>(
        builder: (context, viewModel, child) {
          final cartItems = viewModel.cartItems;
          if (cartItems.isEmpty) {
            return Center(
              child: Text(
                "No items in cart",
                style: TextStyle(color: Color.fromARGB(255, 228, 93, 9)),
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                              child: AnimatedContainer(
                                color: Colors.black87,
                                duration: Duration(milliseconds: 500),
                                height: _animation.value * 60,
                                child: ListTile(
                                  title: Text(
                                    cartItem.item.name,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 228, 93, 9),
                                        fontSize: 18),
                                  ),
                                  subtitle: Text(
                                    "${cartItem.item.price} x ${cartItem.quantity}",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 223, 158, 28)),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      color: Color.fromARGB(255, 228, 9, 9),
                                    ),
                                    onPressed: () {
                                      Provider.of<ItemsViewModel>(context,
                                              listen: false)
                                          .removeFromCart(cartItem);
                                    },
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          "Total: ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 214, 61, 9),
                              fontSize: 16),
                        ),
                        Text(
                          " ${viewModel.totalPrice}",
                          style: TextStyle(
                            color: Color.fromARGB(255, 223, 158, 28),
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(width: 40),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor:
                                      Color.fromARGB(255, 196, 115, 8),
                                  title: Text(" Rs. ${viewModel.totalPrice}"),
                                  content: Text("Total Amount to be paid"),
                                  actions: [
                                    ElevatedButton(
                                      child: Text("Pay"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(60, 60)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 228, 93, 9)),
                          ),
                          child: Text('Checkout'),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
