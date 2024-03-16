import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pro_palestine01/pushnotifs.dart';
import 'main_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCipTPJRnngRK3rjx_Z4U1EyBX2DZN_1oc",
      projectId: 'pro-palestine',
      appId: "1:172475166953:android:a74e19592cc6ecb4f28078",
      messagingSenderId: "172475166953"
    ),
  );
  PushNotifications.init();
  MobileAds.instance.initialize();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          toolbarTextStyle: TextTheme(
            headline6: GoogleFonts.poppins(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ).bodyText2,
          titleTextStyle: TextTheme(
            headline6: GoogleFonts.poppins(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ).headline6,
        ),
      ),
      home: MainScreen(),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'main_screen.dart';
// import 'package:firebase_core/firebase_core.dart';


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey: "AIzaSyCipTPJRnngRK3rjx_Z4U1EyBX2DZN_1oc",
//       projectId: 'pro-palestine',
//       appId: "1:172475166953:android:a74e19592cc6ecb4f28078",
//       messagingSenderId: "172475166953"
//     ),
//   );

//     runApp(MyApp());
// }




// class MyApp extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Colors.black,
//         scaffoldBackgroundColor: Colors.white,
//         appBarTheme: AppBarTheme(
//           color: Colors.black,
//           iconTheme: IconThemeData(color: Colors.white),
//           toolbarTextStyle: TextTheme(
//             headline6: GoogleFonts.poppins(
//               fontSize: 18.0,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ).bodyText2,
//           titleTextStyle: TextTheme(
//             headline6: GoogleFonts.poppins(
//               fontSize: 18.0,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ).headline6,
//         ),
//       ),
//       home: MainScreen(),
//     );
//   }
// }
