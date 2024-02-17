import 'package:app_ecommerce/consts/consts.dart';
import 'package:app_ecommerce/controllers/cart_controller.dart';
import 'package:app_ecommerce/services/firestore_services.dart';
import 'package:app_ecommerce/views/cart_screen/shipping_screen.dart';
import 'package:app_ecommerce/widgets_common/loading_indiacator.dart';
import 'package:app_ecommerce/widgets_common/our_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          color: ku,
          onPress: (){
            Get.to(()=> const ShippingDetails());
          },
          textColor: whiteColor,
          title: "Proceed to shipping",
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping cart"
        .text
        .color(darkFontGrey)
        .fontFamily(semibold)
        .make(),
      ),

      body: StreamBuilder(
        stream: FirestorServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndiacator(),
            );
          } else if(snapshot.data!.docs.isEmpty){
            return Center(
              child: "Cart is empty".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;
            return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.network(
                      "${data[index]['img']}",
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    title: "${data[index]['title']}  (x${data[index]['qty']})"
                    .text
                    .fontFamily(semibold)
                    .size(16)
                    .make(),
                    subtitle: "${data[index]['tprice']}"
                    .numCurrency
                    .text
                    .color(ku)
                    .fontFamily(semibold)
                    .make(),

                    trailing: const Icon(
                      Icons.delete, 
                      color: ku,
                      ).onTap(() {
                        FirestorServices.deleteDocument(data[index].id);
                       }),
                  );
                }
                ),
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Total price"
                .text
                .fontFamily(semibold)
                .color(darkFontGrey)
                .make(),
                Obx(
                  ()=>"${controller.totalP.value}"
                  .numCurrency
                  .text
                  .fontFamily(semibold)
                  .color(ku)
                  .make(),
                ),
              ],
            ).box
            .padding(const EdgeInsets.all(12))
            .color(lightGolden)
            .width(context.screenWidth - 60)
            .roundedSM
            .make(),
            10.heightBox,
              
          ],
        ),
      );

          }
        },
      ),


    );
  }
}