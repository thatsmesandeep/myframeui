import 'package:flutter/material.dart';
import 'package:projectnext_ui/service/http_service.dart';
import 'cart_list.dart';
import 'models/product.dart';
import 'models/shopping_cart.dart';

class ShopListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    final ss = _ShopListState();
    return _ShopListState();
  }
}

class _ShopListState extends State<ShopListWidget> {
  ShoppingCart cart = ShoppingCart();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Product> products;
  bool built = false;

  _ShopListState() {
    print("Creating another state lis");
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final columnCount =
    MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4;

    final width = MediaQuery.of(context).size.width / columnCount;
    const height = 400;

    print('scaffold body rebuilt');

    List<Widget> items = [];
    if (products != null) {
      for (var x = 0; x < products.length; x++) {
        bool isSideLine;
        if (columnCount == 2) {
          isSideLine = x % 2 == 0;
        } else {
          isSideLine = x % 4 != 3;
        }
        final product = products[x];

        items.add(_ShopListItem(
          product: product,
          isInCart: cart.exists(product),
          isSideLine: isSideLine,
          onTap: (product) {
            cart.add(product);
            this.setState(() {});
          },
        ));
      }
    }

    final scaffold =  Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Apple Store"),
        ),
        body: GridView.count(
          childAspectRatio: width / height,
          scrollDirection: Axis.vertical,
          crossAxisCount: columnCount,
          children: items,
        ),
        floatingActionButton: cart.isEmpty
            ? null
            : FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CartListWidget(
                  cart: this.cart,
                )));
          },
          icon: Icon(Icons.shopping_cart),
          label: Text("${cart.numOfItems}"),
        ));
      built = true;
      return scaffold;
  }

  void getProducts() async {
    this.products = await new HttpService().getPosts();
    if(built)
      setState(() {});
  }
}

class _ShopListItem extends StatelessWidget {
  final Product product;
  final bool isInCart;
  final bool isSideLine;
  dynamic onTap;

  _ShopListItem({this.product, this.isInCart, this.isSideLine, this.onTap});

  @override
  Widget build(BuildContext context) {
    Border border;
    if (isSideLine) {
      border = Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
          right: BorderSide(color: Colors.grey, width: 0.5));
    } else {
      border = Border(bottom: BorderSide(color: Colors.grey, width: 0.5));
    }

    return InkWell(
        onTap: () => this.onTap(product),
        child: Container(
            decoration: BoxDecoration(border: border),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Container(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(product.imageUrl),
                  ),
                  height: 250,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Text(product.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .apply(fontSizeFactor: 0.8)),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Text(product.price.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .apply(fontSizeFactor: 0.8)),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Text(this.isInCart ? "In Cart" : "Available",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption.apply(
                        fontSizeFactor: 0.8,
                        color:
                            isInCart ? Colors.blue : Colors.blue)),
              ],
            )));
  }
}