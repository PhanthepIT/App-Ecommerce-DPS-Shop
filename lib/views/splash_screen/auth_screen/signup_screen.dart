import 'package:app_ecommerce/consts/consts.dart';
import 'package:app_ecommerce/controllers/auth_controller.dart';
import 'package:app_ecommerce/views/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets_common/applogo_widget.dart';
import '../../../widgets_common/bg_widget.dart';
import '../../../widgets_common/custom_textfield.dart';
import '../../../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();
 @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Join the $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,

              Obx(
                ()=>Column(
                  children: [
                    customTextField(hint: nameHint, title: name, controller: nameController,isPass: false),
                    customTextField(hint: emailHint, title: email,controller: emailController,isPass: false),
                    customTextField(hint: passwordHint, title: password,controller: passwordController,isPass: true),
                    customTextField(hint: passwordHint, title: retypePassword,controller: passwordRetypeController,isPass: true),
                    /*Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){}, child: forgetPass.text.make())),*/
                      Row(
                        children: [
                          Checkbox(
                            activeColor: greentree,
                            checkColor: whiteColor,
                            value: isCheck, 
                            onChanged: (newValue){
                              setState(() {
                                  isCheck = newValue;
                              });
                            },
                        ),
                        5.widthBox,
                        Expanded(
                          child: RichText(text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "I agree to the ",
                                style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              )),
                              TextSpan(
                                text: termAndCond,
                                style: TextStyle(
                                fontFamily: regular,
                                color: greentree,
                              )),
                              TextSpan(
                                text: " & ",
                                style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              )),
                              TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                fontFamily: regular,
                                color: greentree,
                              )),
                            ]
                          )),
                        )
                        ],
                      ),
                      5.heightBox,
                      controller.isloading.value? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(ku),
                      ) : ourButton(
                        color: isCheck == true? greentree: lightGrey, 
                        title: signup, 
                        textColor: whiteColor, 
                        onPress: ()async{
                          if(isCheck !=false){
                            controller.isloading(true);
                            try{
                              await controller.signupMethod(context: context,email: emailController.text,password: passwordController.text).then((value){
                                return controller.storeUserData(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name:  nameController.text
                                );
                              }).then((value){
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(()=> const Home());
                              });
              
                            }catch (e){
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                              controller.isloading(false);
                            }
                          }
                      },
                       ).box.width(context.screenWidth - 50).make(),
                      10.heightBox,
                      RichText(text: const TextSpan(
                        children: [
                          TextSpan(
                            text: alreadyHaveAccount,
                            style: TextStyle(fontFamily: bold, color: fontGrey),
                          ),
                          TextSpan(
                            text: login,
                            style: TextStyle(fontFamily: bold, color: ku),
                          ),
                        ]
                      ),
                      ).onTap(() { 
                        Get.back();
                      }),
                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth-70).shadowSm.make(),
              ),
            ],
          ),
        ),

    ));
  }
}