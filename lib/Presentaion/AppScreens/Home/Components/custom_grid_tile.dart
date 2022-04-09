import 'package:flutter/material.dart';
import 'package:test/Data/Model/home_model.dart';

class CustomGridTile extends StatelessWidget {
  final Products? product;
  final Color color;
  final Function()? onPressed;
  const CustomGridTile({
    Key? key,
    required this.product,
    required this.color,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: [
            Image(
              image: NetworkImage(product?.image ?? ""),
              fit: BoxFit.contain,
            ),
            if (product?.discount != 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                color: Colors.red,
                child: const Text(
                  'discount',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
      footer: Container(
        color: Colors.black.withOpacity(0.5),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                product?.name ?? "basel",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      product?.price?.toString() ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (product?.discount != 0)
                      Text(
                        product?.oldPrice?.toString() ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: onPressed,
                  icon:  Icon(
                    Icons.favorite,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
