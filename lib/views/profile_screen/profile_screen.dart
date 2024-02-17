
// ignore_for_file: unused_local_variable

import 'package:app_ecommerce/consts/consts.dart';
import 'package:app_ecommerce/consts/lists.dart';
import 'package:app_ecommerce/controllers/auth_controller.dart';
import 'package:app_ecommerce/controllers/profile_controller.dart';
import 'package:app_ecommerce/profileFirst.dart';
import 'package:app_ecommerce/services/firestore_services.dart';
import 'package:app_ecommerce/views/chat_screen/messaging_screen.dart';
import 'package:app_ecommerce/views/orders_screen/orders_screen.dart';
import 'package:app_ecommerce/views/profile_screen/components/details_card.dart';
import 'package:app_ecommerce/views/profile_screen/edit_profile_screen.dart';
import 'package:app_ecommerce/views/splash_screen/auth_screen/login_screen.dart';
import 'package:app_ecommerce/views/wishlist_screen/wishlist_screen.dart';
import 'package:app_ecommerce/widgets_common/bg_widget.dart';
import 'package:app_ecommerce/widgets_common/loading_indiacator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestorServices.getUser(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {
            if (!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(ku),
                ),
              );
            }
            else{
              var data = snapshot.data!.docs[0];
              return SafeArea(
          child: Column(
            children: [
            //edit profile button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Align(alignment: Alignment.topRight,child: Icon(Icons.edit_note_outlined, color: whiteColor)).onTap((){
                    controller.nameController.text = data['name'];
                    
                Get.to(()=> EditProfileScreen(data: data));
              }),
            ),

              //users details section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    data['imageUrl'] == ''?
                    Image.asset(imgProfile2, width: 100,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                    :
                    Image.network(data['imageUrl'], width: 100,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make(),
                    10.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "${data['name']}".text.fontFamily(semibold).white.make(),
                        "${data['email']}".text.fontFamily(semibold).white.make(),
                      ],
                    )),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: whiteColor,
                        )
                      ),
                      onPressed: ()async{
                        //await Get.put(AuthController()).signoutMethod(context);
                        //Get.offAll(() => const LoginScreen());
                        //Get.offAll(()=> const LoginScreen());
                        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()));
                      }, 
                      child: logout.text.fontFamily(semibold).white.make(),
                    )
                  ],
                ),
              ),

              3.heightBox,

              FutureBuilder(
                 future: FirestorServices.getCounts(),
                 builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(!snapshot.hasData){
                    return Center(child: loadingIndiacator());
                  } else {
                    var countData = snapshot.data;
                     return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  detailsCard(count: countData[0].toString(),title: "Cart", width: context.screenWidth / 3.4),
                  detailsCard(count: countData[1].toString(),title: "Wishlist", width: context.screenWidth / 3.4),
                  detailsCard(count: countData[2].toString(),title: "Orders", width: context.screenWidth / 3.4),
                ],
              );
            }
          },
         ),





              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  detailsCard(count: data['cart_count'],title: "in your cart", width: context.screenWidth / 3.4),
                  detailsCard(count: data['wishlist_count'],title: "in your wishlist", width: context.screenWidth / 3.4),
                  detailsCard(count: data['order_count'],title: "your orders", width: context.screenWidth / 3.4),
                ],
              ),*/


              //buttons section

              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const Divider(color: lightGrey);
                },
                itemCount: profileButtonsList.length,
                itemBuilder: (BuildContext context,int index){
                  return ListTile(
                    onTap: (){
                      switch (index){
                        case 0:
                        Get.to(()=>OrdersScreen());
                        break;
                        case 1:
                        Get.to(()=> WishlistScreen());
                        break;
                        case 2 :
                        Get.to(()=> MessagesScreen());
                        break;
                      }
                    },
                    leading: Image.asset(profileButtonsIcon[index],
                    width: 22,
                    ),
                    title: profileButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                  );
                }
                ).box.white.rounded.margin(const EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal:16 )).shadowSm.make().box.color(ku).make(),
                20.heightBox,
               ElevatedButton(
  onPressed: () {
    // Navigate to the second screen with a slide animation
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1000),
        pageBuilder: (_, __, ___) => ProfileFirst(),
        transitionsBuilder: (_, animation, __, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  },
  style: ElevatedButton.styleFrom(
    //elevation: 0, // Remove elevation
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0), 
    ),
  ),
  child: Container(
    //color: Colors.green,
    padding: EdgeInsets.all(12.0),
    child: Text(
      'Developer Member',
      style: TextStyle(color: Colors.white),
    ),
  ),
),

            ],
          ));
            }
          }
        )
      ),
    );
  }
}