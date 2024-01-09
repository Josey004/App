import 'package:app/models/food.dart';
import 'package:app/screens/adminn/home_admin.dart';
import 'package:app/screens/quick_foods_screen.dart';
import 'package:app/screens/recipe_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class QuickAndFastListAdmin extends StatefulWidget {
  final List<Food> foods;
  const QuickAndFastListAdmin({Key? key, required this.foods})
      : super(key: key);

  @override
  _QuickAndFastListAdminState createState() => _QuickAndFastListAdminState();
}

class _QuickAndFastListAdminState extends State<QuickAndFastListAdmin>
    with TickerProviderStateMixin {
  // List<TabBarModel> placesData = [];
  List<Food> foods = [];

  @override
  void initState() {
    tabController = TabController(length: 0, vsync: this);
    fetchFoodsFromFirestore(); // Call the method to fetch data
    super.initState();
  }

  late final TabController tabController;
  final EdgeInsetsGeometry padding =
      const EdgeInsets.symmetric(horizontal: 10.0);

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  // Add a list to store the recommended places

  // void initState() {
  //   fetchFoodsFromFirestore();
  //   super.initState();
  // }
  // List<Map<String, dynamic>> recommendedPlaces = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recommend Food",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuickFoodsScreen(),
                ),
              ),
              child: const Text("View all"),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              widget.foods.length,
              (index) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeScreen(
                      food: widget.foods[index],
                    ),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 200,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(
                                  widget.foods[index].pictureUrl,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.foods[index].name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Iconsax.dollar_circle,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Text(
                                "${widget.foods[index].price}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Positioned(
                        top: 1,
                        right: 1,
                        child: IconButton(
                          onPressed: () {
                            _showDeleteConfirmationDialog(
                                context, widget.foods[index]);
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                            fixedSize: const Size(30, 30),
                          ),
                          iconSize: 20,
                          icon: const Icon(Iconsax.trash),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Food food) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text('Are you sure you want to delete ${food.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _deletePlace(context, food);
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    )); // Close the dialog
                setState(() {}); // Reload the data after deletion
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deletePlace(BuildContext context, Food food) async {
    // Delete from Firestore
    try {
      print(food.documentId);
      await FirebaseFirestore.instance
          .collection('admin')
          .doc(food.documentId)
          .delete();
    } catch (error) {
      print('Error deleting place: $error');
    }
  }

// Add this method to fetch data from Firestore
  Future<void> fetchFoodsFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('admin').get();

      print("Print snapshot");

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          foods.add(Food(
              isLiked: false,
              description: data["description"],
              documentId: documentSnapshot.id,
              price: double.parse(data["price"].toString()),
              location: data["location"],
              pictureUrl: data["pictureUrl"],
              name: data["destinationName"],
              rating: double.parse(data["rating"].toString())));
        });

        print(data["description"].runtimeType);
        print(documentSnapshot.id.runtimeType);
        print(data["price"].runtimeType);
        print(data["location"].runtimeType);
        print(data["pictureUrl"].runtimeType);
        print(data["destinationName"].runtimeType);
        print(data["rating"].runtimeType);

        // Add more fields as needed
        print('------');
      }
    } catch (error) {
      print('Error fetching data from Firestore: $error');
    }
  }
}
  // Future<List<Map<String, dynamic>>> _getRecommendedPlacesData() async {
  //   try {
  //     QuerySnapshot querySnapshot =
  //         await FirebaseFirestore.instance.collection('admin').get();

  //     // List<Map<String, dynamic>> recommendedPlaces = [];

  //     for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
  //       Map<String, dynamic> data =
  //           documentSnapshot.data() as Map<String, dynamic>;

  //       recommendedPlaces.add({
  //         'documentId': documentSnapshot.id,
  //         'image': data['pictureUrl'],
  //         'destinationName': data['destinationName'],
  //         'location': data['location'],
  //         'rating': data['rating'],
  //       });
  //     }

  //     return recommendedPlaces;
  //   } catch (error) {
  //     print('Error getting recommended places data: $error');
  //     return [];
  //   }
  // }
