import 'dart:ui';

import 'package:app_ecommerce/consts/consts.dart';
import 'package:flutter/material.dart';
import 'SecondThrid.dart';
// ignore: unused_import
import 'info.dart';

const Nisitcard = "6421602592";
const email = "Teerapong.tao@ku.th";
const phone = "0659567254"; // not real number :)
const location = "Nakhon Pathom";
const Name = "Teerapong Taosoongnoeng";

class InfoCard extends StatefulWidget {
  final String text;
  final IconData icon;
  final Function onPressed;

  const InfoCard({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Card(
        child: ListTile(
          leading: Icon(widget.icon),
          title: Text(widget.text),
          onTap: widget.onPressed as void Function()?,
        ),
      ),
    );
  }
}

class ProfileScreenSecond extends StatefulWidget {
  @override
  _ProfileScreenSecondState createState() => _ProfileScreenSecondState();
}
class _ProfileScreenSecondState extends State<ProfileScreenSecond> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0), // Apply blur to the image
            child: Image.asset(
              'assets/images/bgp.png', 
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          SafeArea(
            minimum: const EdgeInsets.only(top: 60),
            child: Column(
              children: <Widget>[
                SlideTransition(
                  position: _slideAnimation,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/images/raika.png'),
                  ),
                ),
                50.heightBox,
              InfoCard(text: Name, icon: Icons.person_2_outlined, onPressed: () async {}),
            InfoCard(text: Nisitcard, icon: Icons.credit_score_outlined, onPressed: () async {}),
            InfoCard(text: email, icon: Icons.email, onPressed: () async {}),
            InfoCard(text: location, icon: Icons.location_city, onPressed: () async {}),
            const SizedBox(height: 20,),
      // ... Existing code

      // Add a SlideTransition to the button
      SlideTransition(
        position: _slideAnimation,
        child: SizedBox(
          width: 400,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => ProfileScreenThird(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeOut;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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
              padding: const EdgeInsets.all(15),
              backgroundColor: Colors.greenAccent,
            ),
            child: const Text('Last Member'),
          ),
        ),
      ),
    ]))]));
  }
}

// ... Other existing code
