import 'package:flutter/material.dart';
import '../widgets/header_bar.dart';
import '../widgets/sidebar_menu.dart';
import '../widgets/product_card.dart';
import '../widgets/checkout_bar.dart';
import '../data/sample_products.dart';
import '../theme/kiosk_theme.dart';

class KioskHomeScreen extends StatelessWidget {

  const KioskHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: KioskTheme.background,

      body: Column(
        children: [

          const HeaderBar(),

          Expanded(
            child: Stack(
              children: [

                Row(
                  children: [

                    /// FULL HEIGHT SIDEBAR
                    const SidebarMenu(),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20,20,20,140),
                        child: GridView.builder(
                          itemCount: sampleProducts.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: .8,
                          ),
                          itemBuilder: (_,i){
                            return ProductCard(product: sampleProducts[i]);
                          },
                        ),
                      ),
                    )

                  ],
                ),

                /// CHECKOUT BAR
                const Positioned(
                  left: 130,
                  right: 0,
                  bottom: 0,
                  child: CheckoutBar(),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}