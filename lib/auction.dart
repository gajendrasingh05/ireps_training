import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Public Documents',
      theme: ThemeData(
        primaryColor: Colors.blue[800],
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue[800]!,
        ),
      ),
      home: const PublicDocumentsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DocumentSection {
  final String title;
  final IconData icon;
  final List<String> subItems;

  DocumentSection({
    required this.title,
    required this.icon,
    required this.subItems,
  });
}

class PublicDocumentsPage extends StatelessWidget {
  const PublicDocumentsPage({super.key});

  List<DocumentSection> get sections => [
    DocumentSection(
      title: 'Zonal Railways',
      icon: Icons.train,
      subItems: [
        'Central Railways',
        'East Coast Railways',
        'East Central Railways',
        'Eastern Railways',
        'Kolkata Metro',
        'North Central Railways',
        'North Eastern Railways',
        'Northern Railways',
        'North Frontier Railways',
        'North Western Railways',
        'South Central Railways',
        'South Eastern Railways',
        'South East Central Railways',
        'Southern Railways',
        'South Western Railways',
        'West Central Railways',
        'Western Railways',
      ],
    ),
    DocumentSection(
      title: 'Production Units',
      icon: Icons.factory,
      subItems: [
        'Chittaranjan Locomotive Works',
        'Diesel Locomotive Works',
        'Integral Coach Factory',
        'Rail Coach Factory',
        'Modern Coach Factory',
      ],
    ),
    DocumentSection(
      title: 'Railway Board and Other Units',
      icon: Icons.business,
      subItems: [
        'Railway Board',
        'Research Design & Standards Organization',
        'Railway Staff College',
        'Indian Railways Institute of Civil Engineering',
      ],
    ),
    DocumentSection(
      title: 'IREPS Public Documents',
      icon: Icons.description,
      subItems: [
        'Tender Documents',
        'Auction Documents',
        'General Documents',
        'Policy Documents',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Public Documents',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue[800],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back navigation
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // Handle home navigation
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.blueAccent,
            width: double.infinity,
            child: const Text(
              'Auction',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sections.length,
              itemBuilder: (context, index) {
                final section = sections[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.blue[100]!, width: 1),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(section.icon, color: Colors.blue[800]),
                    ),
                    title: Text(
                      section.title,
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right, color: Colors.blue[300]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SectionDetailPage(section: section),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SectionDetailPage extends StatelessWidget {
  final DocumentSection section;

  const SectionDetailPage({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          section.title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue[800],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: section.subItems.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              leading: Text(
                '${index + 1}.',
                style: TextStyle(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              title: Text(
                section.subItems[index],
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Handle sub-item tap
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected: ${section.subItems[index]}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}