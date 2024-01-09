import 'package:app/models/food.dart';
import 'package:app/screens/recipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  const FoodCard({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Print statements to debug and check data
    print('FoodCard name: ${food.name}');
    print('FoodCard price: ${food.price}');
    print('FoodCard rating: ${food.rating}');
    print('FoodCard description: ${food.description}');
    print('FoodCard pictureUrl: ${food.pictureUrl}');

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeScreen(food: food),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: 600,
              // color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(
                            food.pictureUrl), // Assuming 'image' is a URL
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    food.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(
                  //   height: 3,
                  // ),
                  Row(
                    children: [
                      const Icon(
                        Iconsax.dollar_circle,
                        size: 18,
                        color: Colors.grey,
                      ),
                      Text(
                        "Rp. ${food.price}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Iconsax.star5,
                          color: Colors.yellow.shade700, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        "${food.rating}/5",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      // Text(
                      //   "(${food.description} Reviews)",
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     color: Colors.grey.shade400,
                      //   ),
                      // )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: 1,
              right: 1,
              child: IconButton(
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  fixedSize: const Size(30, 30),
                ),
                iconSize: 20,
                icon: food.isLiked!
                    ? const Icon(
                        Iconsax.heart5,
                        color: Colors.red,
                      )
                    : const Icon(Iconsax.heart),
              ),
            )
          ],
        ),
      ),
    );
  }
}
