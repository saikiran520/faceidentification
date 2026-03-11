import 'package:flutter/material.dart';
import '../theme/kiosk_theme.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            KioskTheme.headerGradientStart,
            KioskTheme.headerGradientEnd
          ],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [

          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person,color: Colors.white),
          ),

          const SizedBox(width: 15),

          const Text(
            "Welcome back,\nSarah!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white38),
            ),
            child: const Icon(Icons.sports_esports,color: Colors.white),
          ),

          const SizedBox(width: 40),

          const Text(
            "Loyalty Points:\n450",
            style: TextStyle(color: Colors.white),
          ),

          const SizedBox(width: 20),

          Stack(
            children: [
              const Icon(Icons.shopping_cart,color: Colors.white,size: 32),
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle),
                  child: const Text("3",
                      style: TextStyle(fontSize: 10,color: Colors.white)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}