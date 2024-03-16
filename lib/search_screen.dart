import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brands Checker'),
      ),
      body: Stack(
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
                SizedBox(height: 20.0),
                Text(
                  'Proper way to use the search option: Enter the brand name in the text field below and tap the search button.',
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Enter Brand Name',
                    labelStyle: TextStyle(color: Colors.white),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: _search,
                    ),
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                _buildSearchResults(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Text('No results found.'),
      );
    }

    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _searchResults.map((brandData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${brandData['name']}', style: TextStyle(color: Colors.white)),
                SizedBox(height: 8.0),
                Text('Country: ${brandData['country']}', style: TextStyle(color: Colors.white)),
                SizedBox(height: 8.0),
                Text('Status: ${brandData['status']}', style: TextStyle(color: Colors.white)),
                SizedBox(height: 8.0),
                Text('Alternative: ${brandData['alternative']}', style: TextStyle(color: Colors.white)),
                SizedBox(height: 8.0),
                if (brandData['logoUrl'] != null)
                  Image.network(
                    brandData['logoUrl'],
                    width: 300.0,
                    height: 300.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      print('Error loading image: $error');
                      return Text('Couldn\'t load image');
                    },
                  ),
                SizedBox(height: 16.0),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _search() async {
    _showAd();

    String searchTerm = _searchController.text.trim().toLowerCase().replaceAll(' ', '');

    if (searchTerm.isEmpty) {
      return;
    }

    print('Searching for: $searchTerm');

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('brands')
          .where('name_lc', isEqualTo: searchTerm)
          .get();

      print('Query snapshot: ${querySnapshot.docs}');

      setState(() {
        _searchResults = querySnapshot.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();
      });
    } catch (e) {
      print('Error searching: $e');
    }
  }
 void _showAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712", // Replace with your actual AdMob Interstitial Ad Unit ID
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.show();
        },
        onAdFailedToLoad: (error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }


}



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SearchScreen extends StatefulWidget {
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Map<String, dynamic>> _searchResults = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Brands Scanner'),
//       ),
//       body: 
//       Stack(
//        children: [
//           Positioned.fill(
//             child: Image.asset(
//               'images/pink.jpg',
//               fit: BoxFit.cover,
//             ),
//           ),
        
      
//       Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // ElevatedButton(
//             //   onPressed: _navigateToBarcodeScreen,
//             //   child: Text('Scan Barcode'),
//             // ),
//             SizedBox(height: 20.0),
//             Text('Proper way to use the search option: Enter the brand name in the text field below and tap the search button.', style: GoogleFonts.poppins(
//               fontSize: 20.0,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,),),
//             SizedBox(height: 20.0),
//             TextField(
//   controller: _searchController,
//   style: TextStyle(color: Colors.white), // Set text color
//   decoration: InputDecoration(
//     labelText: 'Enter Brand Name',
//     labelStyle: TextStyle(color: Colors.white), // Set label color
//     suffixIcon: IconButton(
//       icon: Icon(Icons.search, color: Colors.white), // Set search icon color
//       onPressed: _search,
//     ),
//     filled: true, // Enable filling background color
//     fillColor: Colors.black, // Set background color
//     border: OutlineInputBorder( // Set border style
//       borderRadius: BorderRadius.circular(12.0),
//       borderSide: BorderSide(color: Colors.white),
//     ),
//   ),
// ),

//             SizedBox(height: 20.0),
//             _buildSearchResults(),
//           ],
//         ),
//       ),
//        ]),
//     );
//   }

//   Widget _buildSearchResults() {
//   if (_searchResults.isEmpty) {
//     return Center(
//       child: Text('No results found.'),
//     );
//   }

//   return Center(
//     child: Container(
//       padding: EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(0.7), // Semi-transparent black color
//         borderRadius: BorderRadius.circular(12.0), // Rounded corners
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: _searchResults.map((brandData) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Name: ${brandData['name']}', style: TextStyle(color: Colors.white)),
//               SizedBox(height: 8.0),
//               Text('Country: ${brandData['country']}', style: TextStyle(color: Colors.white)),
//               SizedBox(height: 8.0),
//               Text('Status: ${brandData['status']}', style: TextStyle(color: Colors.white)),
//               SizedBox(height: 8.0),
//               if (brandData['logoUrl'] != null)
//                 Image.network(
//                   brandData['logoUrl'],
//                   width: 300.0,
//                   height: 300.0,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     print('Error loading image: $error');
//                     return Text('Couldn\'t load image');
//                   },
//                 ),
//               SizedBox(height: 16.0),
//             ],
//           );
//         }).toList(),
//       ),
//     ),
//   );
// }

//   Future<void> _search() async {
//     String searchTerm = _searchController.text.trim();

//     if (searchTerm.isEmpty) {
//       return;
//     }

//     print('Searching for: $searchTerm');

//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('brands')
//           .where('name', isEqualTo: searchTerm)
//           .get();

//       print('Query snapshot: ${querySnapshot.docs}');

//       setState(() {
//         _searchResults = querySnapshot.docs.map((doc) {
//           return doc.data() as Map<String, dynamic>;
//         }).toList();
//       });
//     } catch (e) {
//       print('Error searching: $e');
//     }
//   }

  
// }




