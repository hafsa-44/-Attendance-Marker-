import 'package:flutter/material.dart';
import 'pry.dart';
class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  Page3State createState() => Page3State();
}

class Page3State extends State<Page3> {
  List<Map<String, String>> tiles = [];
  DateTime? lastTapTime;

  // Function to show the dialog box for creating or editing a tile
  void showInputDialog({int? index}) {
    final titleController = TextEditingController(
      text: index != null ? tiles[index]['title'] : '',
    );
    final subtitleController = TextEditingController(
      text: index != null ? tiles[index]['subtitle'] : '',
    );
    final digitController = TextEditingController(
      text: index != null ? tiles[index]['digit'] : '',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index != null ? 'Edit Tile' : 'Enter Tile Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Enter Subject:"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: subtitleController,
                decoration: const InputDecoration(hintText: "Enter Section"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: digitController,
                decoration: const InputDecoration(hintText: "Enter Attendance Requirement"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isEmpty ||
                    subtitleController.text.isEmpty ||
                    digitController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill all fields")),
                  );
                  return;
                }

                setState(() {
                  if (index != null) {
                    // Edit existing tile data
                    tiles[index] = {
                      'title': titleController.text,
                      'subtitle': subtitleController.text,
                      'digit': digitController.text,
                    };
                  } else {
                    // Add new tile data
                    tiles.add({
                      'title': titleController.text,
                      'subtitle': subtitleController.text,
                      'digit': digitController.text,
                    });
                  }
                });

                Navigator.pop(context);
              },
              child: Text(index != null ? 'Save' : 'Add'),
            ),
          ],
        );
      },
    );
  }

  // Function to handle single and double tap for each tile
  void handleTap(int index) {
    final currentTime = DateTime.now();

    // Check if the last tap was within 500ms (double-tap)
    if (lastTapTime == null ||
        currentTime.difference(lastTapTime!) > const Duration(milliseconds: 500)) {
      // Single tap: Navigate to the detail page
      Navigator.pushNamed(
        context,
        '/home',
        arguments: {
          'title': tiles[index]['title'],
          'subtitle': tiles[index]['subtitle'],
        },
      );
    } else {
      // Double tap: Show input dialog for editing
      showInputDialog(index: index);
    }

    // Update the last tap time
    lastTapTime = currentTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          margin: const EdgeInsets.only(top: 22),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 67, 157, 160),
            title: const Text('Attendance Manager'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 800,
          width: 480,
          color: Colors.pink.shade50,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: tiles.length,
                  itemBuilder: (context, index) {
                    var tileData = tiles[index];
                    return GestureDetector(
                      onTap: () => handleTap(index),
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
                              offset: const Offset(0, 2),
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
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => showInputDialog(index: index),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    tiles.removeAt(index);
                                  });
                                },
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    tileData['digit']!,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const Text(
                                    'Classes',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: showInputDialog,
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.red.shade400,
      ),
    );
  }
}


/*class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  Page2State createState() => Page2State();
}

class Page2State extends State<Page2> {
  // List to hold the tile data
  List<Map<String, String>> tiles = [ ];

///List<String> titles = ["Introduction to Programming", "Mathematics", "English", "Automata"];
  // Function to show the dialog box to input tile data
  void showInputDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController subtitleController = TextEditingController();
    final TextEditingController digitController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Tile Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title input field
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Enter Subject:"),
              ),
              const SizedBox(height: 10),
              // Subtitle input field
              TextField(
                controller: subtitleController,
                decoration: const InputDecoration(hintText: "Enter Section "),
              ),
              const SizedBox(height: 10),
              // Digit input field
              TextField(
                controller: digitController,
                decoration: const InputDecoration(hintText: "Enter Attendance Requirement"),
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
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // AppBar height
        child: Container(
          margin: const EdgeInsets.only(top: 22),
          child: AppBar(
              automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 67, 157, 160),
            title: const Text('Attendance Manager'),
          ),
        ),
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
                          arguments:  {  
                             'title': tileData['title'], // Pass the title
                              'subtitle': tileData['subtitle'],// Pass the title
                          },// Passing data as arguments
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
                                'Classes',
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
      floatingActionButton: FloatingActionButton(
        onPressed: showInputDialog, // Show input dialog when the button is pressed
        child: const Icon(Icons.add ,color: Colors.white, ), 
        backgroundColor: Colors.red.shade400 ,
  

        
      ),
    );
  }
} */
