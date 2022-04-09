import 'package:flutter/material.dart';
import 'package:test/Data/Model/favorite_model.dart';

class CustomFavoriteGridTile extends StatelessWidget {
  final Products? model;
  final Color color;
  final Function()? onPressed;
  const CustomFavoriteGridTile({
    Key? key,
    required this.model,
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
              image: NetworkImage(model?.product?.image ?? ""),
              fit: BoxFit.contain,
            ),
            if (model?.product?.discount != 0)
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
                model?.product?.name ?? "basel",
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
                      model?.product?.price?.toString() ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (model?.product?.discount != 0)
                      Text(
                        model?.product?.oldPrice?.toString() ?? "",
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
