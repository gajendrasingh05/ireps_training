import 'package:flutter/material.dart';

class Lotspage extends StatefulWidget {
  @override
  _LotspageState createState() => _LotspageState();
}

class _LotspageState extends State<Lotspage> {
  List<bool> isExpanded = [
    false,
    false
  ]; // To track expansion state of each card

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.lightBlue[800],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context); // Go back to the previous screen
              },
            ),
            Text(
              'Lot Search(Sale)',
              style: TextStyle(color: Colors.white),
            ),
            Spacer(), // Pushes the home button to the right
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/common_screen", (route) => false);
              },
            ),
          ],

        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 25,
            color: Colors.white,
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              "Lot details(Sold out)",
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.lightBlue.shade800,
                backgroundColor: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Add space after container
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 2, // For demo purposes, assuming 2 cards
              itemBuilder: (context, index) {
                return buildCard(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded[index] = !isExpanded[index];
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        color: Colors.white, // Change the background color of the card
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the serial number and title
              Text(
                '${index + 1}. CENTRAL RLY / HAJI BUNDER', // Adding serial number
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.lightBlue[800]),
              ),
              Divider(),
              buildRow('Lot Number:', '45223102021'),
              Divider(),
              buildRow('Custodian:', 'AMM HBHR'),
              Divider(),
              buildRow('PL No./Category:', '-1 / Rolling Stock'),
              Divider(),
              buildRow('Qty/Sold Rate:', '1 / 674000'),
              if (isExpanded[index]) ...[
                Divider(),
                buildRow('GST:', '18%'),
                Divider(),
                buildRow('Bidder Name:', 'N H STEELS-MUMBAI'),
                Divider(),
                buildRow('Excluded Items:', 'N/A'),
                Divider(),
                buildRow('Location:', 'AS PER DESCRIPTION'),
                Divider(),
                Text(
                  'Special Condition:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.blue[400]),
                ),
                SizedBox(height: 5),
                Text(
                  'Lot is sold on number basis only and Purchaser should personally visit the site to see the lot, loading point before bidding. No claim will be entertained after sale.',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Divider(),
                Text(
                  'Description:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.blue[400]),
                ),
                SizedBox(height: 5),
                Text(
                  'Cond. ICF Coaches with Iron, Steel, Wooden Scrap and other Non-Ferrous. 1. CR 77223 WGSCN. RESTRICTED ITEMS: 1. Wheel Set with Axle...',
                  style: TextStyle(fontSize: 14,color: Colors.grey[600]),
                ),
              ],
              // Add the down or up arrow based on the expansion state
              Center(
                child: Icon(
                  isExpanded[index]
                      ? Icons.arrow_drop_up// Up arrow when expanded
                      : Icons.arrow_drop_down, // Down arrow when not expanded
                  size: 30, // Adjust the size as needed
                  color: isExpanded[index] ? Colors.red : Colors.green[700], // Red for up, Green for down
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }




  Widget buildRow(String title, String value, {bool isFullWidth = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isFullWidth)
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            )
          else
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[400],
                ),
              ),
            ),
          if (!isFullWidth)
            Expanded(
              flex: 3,
              child: Text(
                value,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            )
          else
            Flexible(
              child: Text(
                value,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                softWrap: true,
              ),
            ),
        ],
      ),
    );
  }
}
