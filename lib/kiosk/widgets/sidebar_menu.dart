import 'package:flutter/material.dart';
import '../theme/kiosk_theme.dart';

class SidebarMenu extends StatelessWidget {

  const SidebarMenu({super.key});
  Widget item(IconData icon, String title, bool active) {
    return Column(
      children: [

        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: active ? 110 : double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: active ? KioskTheme.sidebarActive : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: active
                    ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
                    : [],
              ),
              child: Column(
                children: [
                  Icon(
                    icon,
                    size: 30,
                    color: active ? Colors.white : const Color(0xFF6B3D32),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: active ? Colors.white : const Color(0xFF6B3D32),
                    ),
                  )
                ],
              ),
            ),

            /// RIGHT ARROW CUT
            if (active)
              Positioned(
                right: -14,
                top: 43,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: KioskTheme.sidebarInactive, // sidebar background
                  ),
                  transform: Matrix4.rotationZ(0.785),
                ),
              ),
          ],
        ),

        /// DIVIDER BETWEEN ITEMS
        if (!active)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: Colors.brown.withOpacity(.2),
              thickness: 1,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 130,
      padding: const EdgeInsets.symmetric(vertical: 20),
      /*decoration: const BoxDecoration(
        color: Color(0xFFF3E3DA),
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(30),
        ),
      ),*/
      decoration: const BoxDecoration(
        color: Color(0xFFF3E3DA),
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(30),
        ),
        border: Border(
          right: BorderSide(
            color: Color(0xFFE5CFC3), // thin margin line color
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [

          item(Icons.icecream,"Sundaes",true),
          item(Icons.coffee,"Cones",false),
          item(Icons.local_drink,"Milkshakes",false),
          item(Icons.star,"Specials",false),
          item(Icons.eco,"Vegan",false),

          const Spacer(),

          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: KioskTheme.primary,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              "20% OFF\non all\nsundaes",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}