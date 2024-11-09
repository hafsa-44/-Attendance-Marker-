import 'package:flutter/material.dart';
import 'screen2.dart';
import 'pp.dart';
import 'pry.dart';
import'screen3.dart';
import'history.dart';  
      // Assuming you have a CalendarPage widget defined in calender.dart

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' :(context)=> const  General(),
      '/home': (context)=> CalendarPage(),
        '/2':   (context)=>  const Page3(),
        '/students': (context) => const AddStudentPage (), 
         '/history': (context) =>  const HistoryPage(),
      },
      );
  }
  }
      class General extends StatelessWidget{
         const General ({ super.key});
      @override
      Widget build (BuildContext context)
      {
        return Scaffold(
             
              body : Center(
                child :Padding(
                  padding: EdgeInsets.only(top : 30),
                 child :IconButton(
                         icon: Image.asset(
                         "assets/image/checked.png",
                          width: 100.0, // Adjust width here to change the size
                           height: 100.0, 
                    

                  ),
              
                  onPressed: () {
                    // Navigate to the CalendarPage when the image is clicked
                   Navigator.pushNamed(context, '/2');
                  },
                ),

                    
                ),
                )
      );
  }
}

