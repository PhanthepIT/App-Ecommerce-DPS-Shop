import 'package:app_ecommerce/consts/consts.dart';
import 'package:app_ecommerce/controllers/chats_controller.dart';
import 'package:app_ecommerce/services/firestore_services.dart';
import 'package:app_ecommerce/views/chat_screen/components/sender_bubble.dart';
import 'package:app_ecommerce/widgets_common/loading_indiacator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              ()=> 
              controller.isLoading.value ? Center(
                        child: loadingIndiacator(),
                      ) :
              Expanded(
                child: StreamBuilder(
                  stream: FirestorServices.getChatMessages(controller.chatDocId.toString()),
            
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(!snapshot.hasData){
                      return Center(
                        child: loadingIndiacator(),
                      );
                    }
                    else if(snapshot.data!.docs.isEmpty){
                      return Center(
                        child: "Send a message...".text.color(darkFontGrey).make(),
                      );
                    } else {
                      return ListView(
                        children: snapshot.data!.docs.mapIndexed((currentValue, index){
                          var data = snapshot.data!.docs[index];
                          return Align(
                            alignment: data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                            
                            child: senderBubble(data));
                        }).toList(),
                      );
                    }
                   
                  },
                ),
                ),
            ),
            10.heightBox,
            Row(
              children: [
                 Expanded(
                  child: TextFormField(
                    controller: controller.msgController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfieldGrey,
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfieldGrey,
                      )
                    ),
                    hintText: "Type a message...",
                  ),
                )),
                IconButton(onPressed: (){
                  controller.sendMsg(controller.msgController.text);
                  controller.msgController.clear();
                }, icon: Icon(Icons.send, color: greentree)
                ),
              ],
            ).box.height(80).padding(const EdgeInsets.all(12)).margin(EdgeInsets.only(bottom: 8)).make(),
          ],
        ),
      ),
    );
  }
}