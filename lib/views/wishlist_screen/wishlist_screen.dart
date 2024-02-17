import 'package:app_ecommerce/consts/consts.dart';
import 'package:app_ecommerce/services/firestore_services.dart';
import 'package:app_ecommerce/widgets_common/loading_indiacator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestorServices.getWishlists(),
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Center(child: loadingIndiacator(),);
          } else if (snapshot.data!.docs.isEmpty) {
            return "No wishlist yet!".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:data.length ,
                    itemBuilder: (BuildContext context, int index){
                      return ListTile(
                          leading: Image.network(
                            "${data[index]['p_imgs'][0]}",
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          title: "${data[index]['p_name']}"
                          .text
                          .fontFamily(semibold)
                          .size(16)
                          .make(),
                          subtitle: "${data[index]['p_price']}"
                          .numCurrency
                          .text
                          .color(greentree)
                          .fontFamily(semibold)
                          .make(),
                
                          trailing: const Icon(
                            Icons.favorite, 
                            color: greentree,
                            ).onTap(()async {
                              await firestore
                              .collection(productsCollection)
                              .doc(data[index].id)
                              .set({
                                'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
                              }, SetOptions(merge: true));
                            }),
                        );
                    },
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