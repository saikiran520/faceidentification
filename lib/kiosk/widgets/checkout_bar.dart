import 'package:flutter/material.dart';
import '../theme/kiosk_theme.dart';

class CheckoutBar extends StatelessWidget {
  const CheckoutBar({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 130,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            KioskTheme.headerGradientStart,
            KioskTheme.headerGradientEnd
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(
            color: Color(0xFFB98B7A),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [

              Text(
                "3 Items  |  Total: \$17.56",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 4),

              Text(
                "ADD-ONS: Chocolate Chips + Caramel Sauce",
                style: TextStyle(
                  color: Color(0xFFFFD9C8),
                  fontSize: 14,
                ),
              ),
            ],
          ),

          Center(
            child: SizedBox(
              height: 44,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: KioskTheme.primary,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  "Proceed to Checkout",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}