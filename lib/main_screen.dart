import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'search_screen.dart';
import 'barcode_screen.dart';
import 'faq_screen.dart';
import 'donate_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<MenuItem> menuItems = [
    MenuItem('Brands Checker', Icons.search, SearchScreen()),
    MenuItem('Barcode Checker', Icons.qr_code, BarcodeScreen()),
    MenuItem('Charities', Icons.attach_money, DonateScreen()),
    MenuItem('FAQ', Icons.question_answer, FAQScreen()),
  ];

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pro Palestine'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('brands').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Handle errors
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Process data and show your UI
          return buildMainScreenUI();
        },
      ),
    );
  }

  Widget buildMainScreenUI() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'images/pink.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 1,
                child: Image.asset(
                  'images/mylogo.png',
                  width: 150.0,
                  height: 150.0,
                ),
              ),
              Text(
                'Helping You Make The Right Choices.',
                style: GoogleFonts.poppins(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12.0),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                menuItems[index].destination,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              menuItems[index].icon,
                              size: 30.0,
                              color: Colors.white,
                            ),
                            Text(
                              menuItems[index].title,
                              style: GoogleFonts.poppins(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}

class MenuItem {
  final String title;
  final IconData icon;
  final Widget destination;

  MenuItem(this.title, this.icon, this.destination);
}


// notif not working only code
//import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'search_screen.dart';
// import 'barcode_screen.dart';
// import 'faq_screen.dart';
// import 'donate_screen.dart';


// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   final List<MenuItem> menuItems = [
//     MenuItem('Brands Checker', Icons.search, SearchScreen()),
//     MenuItem('Barcode Checker', Icons.qr_code, BarcodeScreen()),
//     MenuItem('Charities', Icons.attach_money, DonateScreen()),
//     MenuItem('FAQ', Icons.question_answer, FAQScreen()),
//   ];

//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   @override
//   void initState() {
//     super.initState();
//     initializeNotifications();
//     listenForNewBrand();
//   }

//   Future<void> initializeNotifications() async {
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('app_icon');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: androidInitializationSettings,
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   void listenForNewBrand() {
//     FirebaseFirestore.instance.collection('brands').snapshots().listen((event) {
//       for (var change in event.docChanges) {
//         if (change.type == DocumentChangeType.added) {
//           final brand = change.doc;
//           final brandName = brand['name'] as String;
//           final brandStatus = brand['status'] as String;
//           showNotification(context, brandName, brandStatus);
//         }
//       }
//     });
//   }

//   Future<void> showNotification(
//       BuildContext context, String brandName, String brandStatus) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'Brand Add Notifications', // Change this to a unique channel ID
//       'New Brand Added', // Change this to a unique channel name
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.show(
//       0, // Notification ID
//       'New Brand Added', // Title
//       'Name: $brandName\nStatus: $brandStatus', // Body
//       platformChannelSpecifics,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pro Palestine'),
//       ),
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               'images/pink.jpg',
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 SizedBox(
//                   width: 1,
//                   child: Image.asset(
//                     'images/garden.jpg',
//                     width: 120.0,
//                     height: 120.0,
//                   ),
//                 ),
//                 Text(
//                   'Helping You Make The Right Choices.',
//                   style: GoogleFonts.poppins(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(height: 12.0),
//                 Expanded(
//                   child: GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 16.0,
//                       mainAxisSpacing: 16.0,
//                     ),
//                     itemCount: menuItems.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => menuItems[index].destination,
//                             ),
//                           );
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.black,
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                             vertical: 12.0,
//                             horizontal: 16.0,
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 menuItems[index].icon,
//                                 size: 30.0,
//                                 color: Colors.white,
//                               ),
//                               Text(
//                                 menuItems[index].title,
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 18.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MenuItem {
//   final String title;
//   final IconData icon;
//   final Widget destination;

//   MenuItem(this.title, this.icon, this.destination);
// }




// -----------------ACTUAL MAIN SCREEN-------------
// import 'package:flutter/material.dart';
// import 'search_screen.dart';
// import 'barcode_screen.dart';
// import 'faq_screen.dart';
// import 'donate_screen.dart';
// import 'package:google_fonts/google_fonts.dart';

// class MainScreen extends StatelessWidget {
//   final List<MenuItem> menuItems = [
//     MenuItem('Brands Checker', Icons.search, SearchScreen()),
//     MenuItem('Barcode Checker', Icons.qr_code, BarcodeScreen()),
//     MenuItem('Charities', Icons.attach_money, DonateScreen()),
//     MenuItem('FAQ', Icons.question_answer, FAQScreen()),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pro Palestine'),
//       ),
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               'images/pink.jpg',
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 SizedBox(
//                   width: 1,
//                   child: Image.asset(
//                     'images/garden.jpg',
//                     width: 120.0, // Adjust the width of the logo
//                     height: 120.0, // Adjust the height of the logo
//                   ),
//                 ),
//                 // SizedBox(height: 12,),
//                 // SizedBox(height: 20.0),
//                 Text(
//                   'Helping You Make The Right Choices.',
//                   style: GoogleFonts.poppins(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(height: 12.0),
                
//                 Expanded(
//                   child: GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 16.0,
//                       mainAxisSpacing: 16.0,
//                     ),
//                     itemCount: menuItems.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => menuItems[index].destination,
//                             ),
//                           );
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.black,
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           // constraints: BoxConstraints(
//                           // maxWidth: 100.0,
//                           // maxHeight: 100, // Set the maximum width for the box
//                           // ),
//                           //padding: EdgeInsets.all(20.0),
//                           padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 menuItems[index].icon,
//                                 size: 30.0,
//                                 //size: 40.0,
//                                 color: Colors.white,
//                               ),
//                               //SizedBox(height: 12.0),
//                               Text(
//                                 menuItems[index].title,
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 18.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MenuItem {
//   final String title;
//   final IconData icon;
//   final Widget destination;

//   MenuItem(this.title, this.icon, this.destination);
// }

















