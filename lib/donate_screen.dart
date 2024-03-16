import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class DonateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charities'),
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
                 Text( 'All organizations mentioned are actively feeding and sheltering the Palestinian people.' , style: GoogleFonts.poppins(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,),
              ),
               
                SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    // Use ListView instead of Column
                    shrinkWrap: true, // Adjust as needed
                    children: [
                      CharityTile(
                        logo: 'images/alkhidmat.jpg',
                        title: 'Alkhidmat Foundation',
                        details: 'Alkhidmat deals with numerous sectors and is actively providing meals and other necessities through their Gaza Emergency Appeal program.',
                        donateLink: 'https://alkhidmat.org/appeal/emergency-appeal-palestine-save-lives-in-gaza-today',
                      ),
                      CharityTile(
                        logo: 'images/pcrf.jpg',
                        title: 'Palestine Children\'s Relief Fund',
                        details: 'PCRF\'s urgent Gaza relief program focuses on providing water, food, shelter, and much more to the Palestinian, especially children which make a significant percentage of the population.',
                        donateLink: 'https://pcrf1.app.neoncrm.com/forms/gaza-recovery',
                      ),
                      // Add more CharityTiles as needed
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CharityTile extends StatelessWidget {
  final String logo;
  final String title;
  final String details;
  final String donateLink;

  CharityTile({
    required this.logo,
    required this.title,
    required this.details,
    required this.donateLink,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(logo, height: 100, width: 100),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(details),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              _launchURL(donateLink);
            },
            child: Text('Donate'),
          ),
        ],
      ),
    );
  }

  // Function to launch URLs
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
