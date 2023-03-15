import 'package:animation/view/cartscreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:animation/models/model.dart';
import 'package:animation/viewmodel/viewModel.dart';

class MyHomePage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _rotationAnimation;
  Animation<double>? _sizeAnimation;

  AnimationController? _controller2;
  Animation<double>? _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _rotationAnimation =
        Tween<double>(begin: 0, end: 59.9).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    ));
    _sizeAnimation = Tween<double>(begin: 50, end: 130).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    ));

    _controller2 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller2!,
      curve: Curves.easeIn,
    ));

    _controller!.forward();
    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller2!.forward();
      }
    });
    Timer(Duration(seconds: 4), () => Navigator.pushNamed(context, '/screen2'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(61, 59, 57, 57),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 4,
            ),
            AnimatedBuilder(
              animation: _controller!,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation!.value,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 450),
                    width: _sizeAnimation!.value,
                    height: _sizeAnimation!.value,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          _sizeAnimation!.value,
                        ),
                        border: Border.all(
                            color: Color.fromARGB(60, 128, 191, 218),
                            width: 3,
                            style: BorderStyle.solid),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue,
                            blurRadius: _sizeAnimation!.value * 5,
                          ),
                        ]),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: _sizeAnimation!.value,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/download.png',
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Spacer(),
            AnimatedBuilder(
              animation: _fadeInAnimation!,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeInAnimation!.value,
                  child: AnimatedContainer(
                      height: 300,
                      duration: Duration(seconds: 1),
                      alignment: Alignment.bottomCenter,
                      width: 300,
                      child: Image(
                        image: AssetImage('assets/download2.png'),
                      )),
                );
              },
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    _controller2!.dispose();
    super.dispose();
  }
}

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Items"),
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          ),
          icon: Icon(Icons.card_travel),
        ),
      ),
      body: Consumer<ItemsViewModel>(
        builder: (context, viewModel, child) => ListView.builder(
          itemCount: viewModel.items.length,
          itemBuilder: (context, index) {
            final item = viewModel.items[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text("${item.price}"),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  viewModel.addToCart(item);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
