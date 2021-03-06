import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/core/store.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/models/cart.dart';

class HomeDetailPage extends StatelessWidget {
  final Item item;

  const HomeDetailPage({Key key, @required this.item})
      : assert(item != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    VxState.watch(context, on: [AddMutation, RemoveMutation]);

    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        // centerTitle: true,
        title: "Details".text.color(context.accentColor).make(),
        backgroundColor: Colors.transparent,
        actions: [
          VxBuilder(
                  mutations: {AddMutation, RemoveMutation},
                  builder: (context, _, __) => FloatingActionButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, MyRoutes.cartRoute),
                        backgroundColor: context.theme.buttonColor,
                        child: Icon(
                          CupertinoIcons.cart,
                          color: Colors.white,
                        ),
                      ))
              .badge(
                  color: Vx.gray200,
                  size: 19,
                  count: _cart.items.length,
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ))
              .p(4)
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Hero(
              tag: Key(item.id.toString()),
              child: Image.network(item.image),
            ).h40(context),
            Expanded(
              child: VxArc(
                arcType: VxArcType.CONVEY,
                edge: VxEdge.TOP,
                height: 30.0,
                child: Container(
                  width: context.screenWidth,
                  color: context.cardColor,
                  child: Column(
                    children: [
                      item.name.text.xl3.bold.make(),
                      item.desc.text.textStyle(context.captionStyle).xl.make(),
                    ],
                  ).py(40),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: context.cardColor,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            "\$${item.price}".text.xl3.bold.red900.make(),
            _AddToCart(item: item).wh(120, 45)
          ],
        ).p12(),
      ),
    );
  }
}

class _AddToCart extends StatelessWidget {
  final Item item;
  _AddToCart({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddMutation, RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;
    bool isInCart = _cart.items.contains(item) ?? false;
    return ElevatedButton(
      onPressed: () {
        if (!isInCart) {
          AddMutation(item);
        }
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(context.theme.buttonColor),
          shape: MaterialStateProperty.all(
            StadiumBorder(),
          )),
      child: isInCart ? Icon(Icons.done) : Icon(CupertinoIcons.cart_badge_plus),
    );
  }
}
