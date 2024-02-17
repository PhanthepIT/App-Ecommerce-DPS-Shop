import 'package:app_ecommerce/views/home_screen/home.dart';
import 'package:app_ecommerce/views/home_screen/home_screen.dart';
// ignore: unused_import
import 'package:app_ecommerce/views/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

class ItemProfile {
  final IconData icon;
  final String label;

  ItemProfile({
    required this.icon,
    required this.label,
  });
}

class ProfileScreenThird extends StatefulWidget {
  @override
  _ProfileScreenThirdState createState() => _ProfileScreenThirdState();
}

class _ProfileScreenThirdState extends State<ProfileScreenThird>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<ItemProfile> items = [
    ItemProfile(icon: Icons.person_2_outlined, label: 'Phianwit tewaaksorn'),
    ItemProfile(icon: Icons.location_on, label: 'Location: Nonthaburi city'),
    ItemProfile(icon: Icons.credit_score_outlined, label: '6421605478'),
    ItemProfile(icon: Icons.email_outlined, label: 'Phianwit.t@ku.th'),
  ];

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
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: const CircleAvatar(
                  radius: 90,
                  backgroundImage: AssetImage('assets/images/fluke.jpg'),
                ),
              ),
              const SizedBox(
                height: 50,
                width: 200,
              ),
              for (var item in items)
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: ListTile(
                    leading: Icon(item.icon),
                    title: Text(item.label),
                  ),
                ),
              const SizedBox(height: 40.0),

              // Add a GestureDetector to handle button tap
              GestureDetector(
                onTap: () {
                  // Navigate to the new page using a MaterialPageRoute
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()), // Replace 'NewPage' with your actual page class
                  );
                },
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: 40, // Set button width
                    height: 40, // Set button height
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.man,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Define your NewPage class here
/*class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Center(
        child: Text('This is the new page content.'),
      ),
    );
  }
}*/
