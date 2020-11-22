import 'dart:convert';

import 'package:http/http.dart';
import 'package:projectnext_ui/models/product.dart';

class HttpService {
  final String postsURL = "http://192.168.1.95:8081/products";

  Future<List<Product>> getPosts() async {
    print('Callign the Service SANDEEP');
    Response res = await get(postsURL, headers: {'tenantId':'test'});

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Product> products = body.map((dynamic item) => Product.fromJson(item))
          .toList();

      return products;
    } else {
      throw "Can't get posts.";
    }
  }
}