import 'package:app_ecommerce/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:app_ecommerce/profileSecond.dart';

class ProfileFirst extends StatelessWidget {
  const ProfileFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgp.png'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/pao.jpg'),
              ),
              35.heightBox,
              const SizedBox(height: 20),
              itemProfile('Name', 'Phanthep supaveerasatien', Icons.person),
              const SizedBox(height: 10),
              itemProfile('Id Nisit', '6421600379', Icons.credit_score_outlined),
              const SizedBox(height: 10),
              itemProfile('Address', 'Nontaburi', Icons.location_on),
              const SizedBox(height: 10),
              itemProfile('Email', 'phanthep.s@ku.th', Icons.mail),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => ProfileScreenSecond(),
                        transitionsBuilder: (_, animation, __, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.greenAccent,
                    shadowColor: Colors.lightGreen,
                  ),
                  child: const Text('Next Member'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.green.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          )
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        tileColor: Colors.white,
      ),
    );
  }
}
