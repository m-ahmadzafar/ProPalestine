import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'images/pink.jpg', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          
          // Questions in the Front
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                FAQItem(question: 'What data does the app use? ', answer: 'Our app uses its own database that has been built from the ground up.'),
                FAQItem(question: 'How does the app verify brands?', answer: 'Our database is based on information gathered from trusted sources and pro-palestine movements like the BDS Movement.'),
                 FAQItem(question: 'Are only Israeli brands on this app?', answer: 'No, there are brands from numerous countries and the country is shown in the search result.'),
                FAQItem(question: 'Why are there ads on this app?', answer: '100% of the profit goes to Palestine.'),
                FAQItem(question: 'Why are some brands missing?', answer: 'As we have a self-managed database, some brands may be missing. We are always adding new brands and users are notified about it.'),
                FAQItem(question: 'Who developed this app?', answer: 'This app was developed by KyojinDevs.'),

                // Add more FAQ items as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(widget.question),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.answer),
          ),
        ],
      ),
    );
  }
}
