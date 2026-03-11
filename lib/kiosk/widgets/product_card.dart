import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../theme/kiosk_theme.dart';

class ProductCard extends StatefulWidget {

  final Product product;

  const ProductCard({super.key,required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  bool active=false;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: KioskTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 8,
            offset: const Offset(0,4),
          )
        ],
      ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// FLEXIBLE IMAGE
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        widget.product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: const BoxDecoration(
                        color: KioskTheme.primary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Text(
                        "${widget.product.discount}% OFF",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),

            /// TITLE
            Text(
              widget.product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 2),

            /// SUBTITLE
            Text(
              widget.product.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 4),

            /// PRICE + BUTTON
            Row(
              children: [

                Expanded(
                  child: Text(
                    "\$${widget.product.price}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                SizedBox(
                  width: 90,
                  height: 28,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => active = !active);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      active ? KioskTheme.primary : KioskTheme.secondary,
                      foregroundColor: Colors.white, // FIXED TEXT COLOR
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minimumSize: const Size(0, 28),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Add",
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}