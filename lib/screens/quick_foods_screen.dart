import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/models/food.dart'; // Make sure to import your Food model
import 'package:app/widgets/food_card.dart';
import 'package:app/widgets/quick_screen_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuickFoodsScreen extends StatefulWidget {
  const QuickFoodsScreen({Key? key});

  @override
  State<QuickFoodsScreen> createState() => _QuickFoodsScreenState();
}
class _QuickFoodsScreenState extends State<QuickFoodsScreen> {
  List<Food> foods = []; // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    fetchFoodsFromFirestore();
  }

  Future<void> fetchFoodsFromFirestore() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> foodSnapshot =
          await FirebaseFirestore.instance.collection('admin').get();

      setState(() {
        foods = foodSnapshot.docs
            .map((doc) => Food.fromMap(doc.data()))
            .toList();
      });
    } catch (error) {
      print('Error fetching data from Firestore: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('This is a regular print statement.');
// stdout.writeln('This should appear in the console.');

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const QuickScreenAppbar(),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    if (foods.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return FoodCard(
                        food: foods[index],
                      );
                    }
                  },
                  itemCount: foods.length,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
