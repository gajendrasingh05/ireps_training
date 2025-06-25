// *** path ***

// Links >> E-Documents >> Auction >> IREPS Public Documents


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const PublicDocumentsApp());
}

class PublicDocumentsApp extends StatelessWidget {
  const PublicDocumentsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Public Documents',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue.shade800,
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade800,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const PublicDocumentsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PublicDocumentsPage extends StatefulWidget {
  const PublicDocumentsPage({super.key});

  @override
  State<PublicDocumentsPage> createState() => _PublicDocumentsPageState();
}

class _PublicDocumentsPageState extends State<PublicDocumentsPage> {
  final List<DocumentItem> documents = [
    DocumentItem(id: 1, docDesc: 'Guidelines for Encryption Certificate', uploadedDate: '10/02/2015 17:30', fileSizeKB: 268),
    DocumentItem(id: 2, docDesc: 'Bidder Registration Form', uploadedDate: '15/03/2015 14:25', fileSizeKB: 184),
    DocumentItem(id: 3, docDesc: 'Vendor Registration Form', uploadedDate: '22/04/2015 09:15', fileSizeKB: 452),
    DocumentItem(id: 4, docDesc: 'User Manual for Reverse Auction', uploadedDate: '05/05/2015 11:45', fileSizeKB: 329),
    DocumentItem(id: 5, docDesc: 'Important Notice for Vendor Users', uploadedDate: '18/06/2015 16:20', fileSizeKB: 567),
    DocumentItem(id: 6, docDesc: 'Request Form for Railway Users', uploadedDate: '30/07/2015 13:10', fileSizeKB: 215),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Public Documents', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.home), onPressed: () {})],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey.shade100,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Auction >> Document List',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade700),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                return _buildDocumentItem(documents[index], index + 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(DocumentItem document, int serialNumber) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Text(
                '$serialNumber',
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 80,
                      child: Text(
                        'Description :',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        document.docDesc,
                        style: const TextStyle(fontSize: 13, height: 1.4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 80,
                      child: Text(
                        'Uploaded :',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        document.uploadedDate,
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.filePdf,
                size: 20,
                color: Colors.red.shade600,
              ),
              const SizedBox(height: 4),
              Text(
                '${document.fileSizeKB} KB',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DocumentItem {
  final int id;
  final String docDesc;
  final String uploadedDate;
  final int fileSizeKB;

  DocumentItem({
    required this.id,
    required this.docDesc,
    required this.uploadedDate,
    required this.fileSizeKB,
  });
}
