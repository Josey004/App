import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final dynamic data;

  const EditPage({Key? key, required this.data}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.data.title;
    // Initialize other controllers if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            // Add more form fields as needed
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement the logic to save the edited data
          String updatedTitle = titleController.text;
          // Update other fields as needed
          Navigator.pop(context); // Pop to go back to the previous screen
        },
        child: const Icon(Icons.save),
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }
}
