import 'package:app_ecommerce/consts/consts.dart';
import 'package:app_ecommerce/views/home_screen/home.dart';
import 'package:app_ecommerce/views/splash_screen/auth_screen/login_screen.dart';
import 'package:app_ecommerce/widgets_common/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


 changeScreen(){
  Future.delayed(const Duration(seconds: 3),(){
    //Get.to(() => LoginScreen());
    auth.authStateChanges().listen((User? user) { 
      if (user == null && mounted) {
        Get.to(()=>const LoginScreen());
      } else {
        Get.to(()=> const Home());
      }
    });
  });
 }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ku,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment:Alignment.topCenter,
              child:Image.asset(icSplashBg, width: 300)),
              10.heightBox,
              applogoWidget(),
              10.heightBox,
              appname.text.fontFamily(bold).size(22).white.make(),
              5.heightBox,
              appversion.text.white.make(),
              const Spacer(),
              credits.text.white.fontFamily(semibold).make(),
              30.heightBox,
          ],
        ) 
        ),
    );
  }
}