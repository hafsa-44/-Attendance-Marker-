import 'package:flutter/material.dart';
class Event {
  final String title;
  Event(this.title);
}

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  AddStudentPageState createState() => AddStudentPageState();
}

class  AddStudentPageState  extends State<AddStudentPage> with SingleTickerProviderStateMixin {


  String title = 'Student Info'; // Default title
  String subtitle = 'Attendance '; // Default subtitle

  final Map<DateTime, List<Event>> _events = {};
  late TabController _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Cast arguments as Map<String, String?>? to handle nullable values
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, String?>?;
    
    // Use null-aware operator to assign values with fallbacks
    title = arguments?['title'] ?? 'Default Title';
    subtitle = arguments?['subtitle'] ?? 'Default Subtitle';
  }

  // List to hold the tile data
  List<Map<String, String>> tiles = [ ];
List<String> titles = ["Introduction to Programming", "Mathematics", "English", "Automata"];
  // Function to show the dialog box to input tile data
  void showInputDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController subtitleController = TextEditingController();
    final TextEditingController digitController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title input field
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: " Student Name:"),
              ),
              const SizedBox(height: 10),
              // Subtitle input field
            TextField(
                controller: subtitleController,
                decoration: const InputDecoration(hintText: " Roll No "),
              ),
              const SizedBox(height: 10),
              // Digit input field
              TextField(
                controller: digitController,
                decoration: const InputDecoration(hintText: "Enter Something :"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            // Cancel button
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without adding tile
              },
              child: const Text('Cancel'),
            ),
            // Add tile button
            TextButton(
              onPressed: () {
                if (titleController.text.isEmpty ||
                   subtitleController.text.isEmpty ||
                    digitController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields")));
                  return;
                }

                setState(() {
                  // Add the new tile data to the list
                  tiles.add({
                    'title': titleController.text,
                   'subtitle': subtitleController.text,
                    'digit': digitController.text,
                  });
                });

                // Close the dialog after adding the tile
                Navigator.pop(context);
              },
              child: const Text('Add and close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 67, 157, 160),
       // AppBar height
        ),

      body: SingleChildScrollView(
        child: Container(
          height: 800,
          width: 480,
          color: Colors.pink.shade50,
          child: Column(
            children: [
              const SizedBox(height: 20),
              // ListView to display the tiles
              Expanded(
                
                child: ListView.builder(
                  itemCount: tiles.length,
                  itemBuilder: (context, index) {
                    var tileData = tiles[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the TileDetailPage using named route
                        Navigator.pushNamed(
                          context,
                          '/home',
                          arguments: titles[index],// Passing data as arguments
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tileData['title']!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                             Text(
                                tileData['subtitle']!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                tileData['digit']!,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green, // Green color for the trailing digit
                                ),
                              ),
                              const Text(
                                'Attendance',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    

  floatingActionButton: Stack(
  children: [
    // Centering the button using Stack
    Positioned(
      bottom: 60, // Adjust as needed to position at the center
      left: MediaQuery.of(context).size.width / 2 - 90, // Center horizontally
       child: Container(
        width: 200, // Set width for the button
        height: 50,
      child: FloatingActionButton(
        onPressed: showInputDialog, // Show input dialog when the button is pressed
        child: Text(
          "ADD STUDENT",  // Replace the icon with text
          style: TextStyle(
            color: Colors.white,
            fontSize: 16, // Adjust text size
            fontWeight: FontWeight.bold,
            letterSpacing: 0.1, // Adjust the letter spacing
            height: 1.7, // Adjust the line height (if needed)
            decoration: TextDecoration.none, // Remove text decoration
          ),
        ),
        backgroundColor: Colors.red.shade400,
        // Increase the width and height of the FAB
        elevation: 70,
        
        splashColor: Colors.orangeAccent,
      ),
    ),
    ),
  ],
)   
    );
  }
}

    
  