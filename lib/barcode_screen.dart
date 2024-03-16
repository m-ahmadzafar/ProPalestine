import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:camera/camera.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BarcodeScreen extends StatefulWidget {
  @override
  _BarcodeScreenState createState() => _BarcodeScreenState();
}

class _BarcodeScreenState extends State<BarcodeScreen> {
  bool _isFromIsrael = false;
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }


  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras![0],
        ResolutionPreset.high,
      );
      await _cameraController!.initialize();
      setState(() {});
    }
  }

@override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
  

  void _decodeBarcode() async {
    _showAd();
    try {
      var result = await BarcodeScanner.scan();

      if (result.rawContent.isEmpty) {
        // Handle case where user cancels scanning or encounters an error
        print('Scanning canceled or encountered an error');
        return;
      }

      String countryCode = result.rawContent.substring(0, 3);
      bool isFromIsrael = _checkIsFromIsrael(countryCode);

      setState(() {
        _isFromIsrael = isFromIsrael;
      });
    } catch (e) {
      print('Error scanning barcode: $e');
    }
  }

  bool _checkIsFromIsrael(String countryCode) {
    return countryCode == '729';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
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
                  'Scan a barcode to check if it is from Israel.',
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.0),
                if (_cameras != null && _cameras!.isNotEmpty)
                
                  AspectRatio(
                    aspectRatio: _cameraController!.value.aspectRatio,
                    child: CameraPreview(_cameraController!),
                  ),
                SizedBox(height: 20.0),
                // if (_isFromIsrael != null)
                //   Container(
                //     padding: EdgeInsets.all(16.0),
                //     decoration: BoxDecoration(
                //       color: Colors.black.withOpacity(0.7),
                //       borderRadius: BorderRadius.circular(12.0),
                //     ),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         // Text(
                //         //   _isFromIsrael
                //         //       ? 'This product is from Israel.'
                //         //       : 'This product is not from Israel.',
                //         //   style: TextStyle(
                //         //     fontSize: 24.0,
                //         //     fontWeight: FontWeight.bold,
                //         //     color: Colors.white,
                //         //   ),
                //         // ),
                //       ],
                //     ),
                //   ),
                SizedBox(height: 20.0),
                ElevatedButton(
  onPressed: _decodeBarcode,
  style: ElevatedButton.styleFrom(
    primary: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),
  child: Container(
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.qr_code,
          size: 30.0,
          color: Colors.white,
        ),
        SizedBox(height: 8.0),
        Text(
          'Scan Barcode',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  ),
),

                // ElevatedButton(
                //   onPressed: _decodeBarcode,
                //   child: Text('Scan Barcode'),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
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



