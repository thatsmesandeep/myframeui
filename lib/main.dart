import 'package:flutter/material.dart';
import 'package:projectnext_ui/service/http_service.dart';
import 'shop_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShopListWidget(),
      // home: ShopListWidget(),
    );
  }
}