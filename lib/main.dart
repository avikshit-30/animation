import 'package:animation/view/cartscreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:animation/models/model.dart';
import 'package:animation/viewmodel/viewModel.dart';
import 'package:animation/view/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ItemsViewModel()),
      ],
      child: MaterialApp(
        title: 'My App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => MyHomePage(),
          '/screen2': (context) => ItemsScreen(),
          '/screen3': (context) => CartScreen(),
        },
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FlyingListTiles(),
//     );
//   }
// }

// class FlyingListTiles extends StatefulWidget {
//   @override
//   _FlyingListTilesState createState() => _FlyingListTilesState();
// }

// class _FlyingListTilesState extends State<FlyingListTiles>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 600),
//     );
//     _animation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     );
//     _animationController.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flying List Tiles'),
//       ),
//       body: ListView.builder(
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return AnimatedBuilder(
//             animation: _animation,
//             builder: (context, child) {
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: AnimatedContainer(
//                   color: Colors.blue,
//                   duration: Duration(milliseconds: 500),
//                   height: _animation.value * 60,
//                   child: ListTile(
//                     title: Text('List Tile $index'),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
// }
