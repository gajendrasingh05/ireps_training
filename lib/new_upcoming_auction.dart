import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/aapoorti/common/AapoortiConstants.dart';
import 'package:flutter_app/aapoorti/common/AapoortiUtilities.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/aapoorti/home/auction/upcoming/upcomingthirdpage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_app/aapoorti/home/auction/upcoming/Upcoming.dart';

class Userup1 {
  final String? lotid, des;

  const Userup1({this.lotid, this.des});
}

class upcoming2 extends StatefulWidget {
  final Userup? value1;

  upcoming2({Key? key, this.value1}) : super(key: key);

  @override
  _upcoming2State createState() => _upcoming2State();
}

class _upcoming2State extends State<upcoming2> with TickerProviderStateMixin {
  List<dynamic>? jsonResult;
  List<dynamic>? expandedData = [];
  Set<int> expandedItems = {};
  late AnimationController _animationController;

  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    var fetchPost = this.fetchPost();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List data = [];
  Future<void> fetchPost() async {
    var url = AapoortiConstants.webServiceUrl +
        'Auction/CatalogueDesc?CID=${widget.value1!.upid}&CATEGORY=${widget.value1!.category}';
    final response = await http.post(Uri.parse(url));
    jsonResult = json.decode(response.body);

    setState(() {
      data = jsonResult!;
      expandedData = List.filled(jsonResult!.length, null);
    });
  }

  Future<void> fetchDetailedData(int index) async {
    if (expandedData![index] != null) return;

    var url = AapoortiConstants.webServiceUrl +
        'Auction/LotDesc?LOTID=${jsonResult![index]['LOTID']}';
    final response = await http.post(Uri.parse(url));
    var detailedResult = json.decode(response.body);

    setState(() {
      expandedData![index] = detailedResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context, rootNavigator: true).pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue.shade800,
          elevation: 4,
          shadowColor: Colors.blue.withOpacity(0.3),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Icon(Icons.home_rounded, color: Colors.white, size: 26),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/common_screen", (route) => false);
                },
                splashRadius: 24,
              ),
            ),
          ],
          title: Text(
            'Upcoming Auctions Catalogue',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: jsonResult == null
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitFadingCircle(
                  color: Colors.blue.shade700,
                  size: 60.0,
                ),
                SizedBox(height: 16),
                Text(
                  'Loading catalogue...',
                  style: TextStyle(
                    color: Colors.blue.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
              : _myListView(context),
        ),
      ),
    );
  }

  Widget _myListView(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(12), // Changed from 16 to 12
      itemCount: jsonResult != null ? jsonResult!.length : 0,
      itemBuilder: (context, index) {
        bool isExpanded = expandedItems.contains(index);
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: GestureDetector(
            child: Card(
              elevation: isExpanded ? 8 : 4,
              shadowColor: Colors.grey.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isExpanded ? Colors.blue.shade200 : Colors.grey.shade200,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Header with Lot Number and Status
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12), // Changed from 16 to 12
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Lot #${jsonResult![index]['LOTNO'] ?? ''}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3), // Changed from vertical: 6 to 3
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.blue.shade300),
                          ),
                          child: Text(
                            jsonResult![index]['LOT_STATUS'] ?? "",
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main Content
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Changed from vertical: 12 to 8
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Compact Basic Info for unexpanded cards
                        if (!isExpanded) ...[
                          _buildCompactInfoRow("Start Time", jsonResult![index]['LOT_START_DATETIME'] ?? ""),
                          _buildCompactInfoRow("End Time", jsonResult![index]['LOT_END_DATETIME'] ?? ""),

                          Row(
                            children: [
                              Expanded(
                                child: _buildCompactInfoRow("Quantity", jsonResult![index]['LOT_QTY'] ?? ""),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: _buildCompactInfoRow("Min. Increment", "₹${jsonResult![index]['MIN_INCR_AMT'] ?? ""}"),
                              ),
                            ],
                          ),

                          // Description preview (first 2 lines)
                          if (jsonResult![index]['LOTMATDESC'] != 'NA' &&
                              jsonResult![index]['LOTMATDESC'] != null &&
                              jsonResult![index]['LOTMATDESC'].toString().isNotEmpty) ...[
                            SizedBox(height: 8),
                            Text(
                              jsonResult![index]['LOTMATDESC'],
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ] else ...[
                          // Full details for expanded cards
                          _buildSimpleInfoRow("Start Time", jsonResult![index]['LOT_START_DATETIME'] ?? ""),
                          _buildSimpleInfoRow("End Time", jsonResult![index]['LOT_END_DATETIME'] ?? ""),
                          _buildLotQuantityGSTRow(index),
                          _buildSimpleInfoRow("Min. Increment", "₹${jsonResult![index]['MIN_INCR_AMT'] ?? ""}"),

                          SizedBox(height: 16),

                          // Expanded Details
                          if (expandedData![index] == null)
                            Center(
                              child: Padding(
                                padding: EdgeInsets.all(16), // Changed from 20 to 16
                                child: Column(
                                  children: [
                                    SpinKitFadingCircle(
                                      color: Colors.blue.shade700,
                                      size: 30.0,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Loading details...',
                                      style: TextStyle(
                                        color: Colors.blue.shade600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else ...[
                            _buildExpandedDetails(expandedData![index][0]),

                            SizedBox(height: 16),
                            Text(
                              "Description:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              jsonResult![index]['LOTMATDESC'] ?? "",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14,
                                height: 1.4,
                              ),
                              softWrap: true,
                            ),
                          ],
                        ],
                      ],
                    ),
                  ),

                  // Arrow indicator at bottom
                  if (jsonResult![index]['LOTMATDESC'] != 'NA' &&
                      jsonResult![index]['LOTMATDESC'] != null &&
                      jsonResult![index]['LOTMATDESC'].toString().isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 6), // Changed from 8 to 6
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        border: Border(
                          top: BorderSide(color: Colors.grey.shade200, width: 0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: Colors.blue.shade600,
                            size: 20,
                          ),
                          SizedBox(width: 4),
                          Text(
                            isExpanded ? "Show Less" : "Show More",
                            style: TextStyle(
                              color: Colors.blue.shade600,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            onTap: () async {
              if (jsonResult![index]['LOTMATDESC'] != 'NA' &&
                  jsonResult![index]['LOTMATDESC'] != null &&
                  jsonResult![index]['LOTMATDESC'].toString().isNotEmpty) {
                setState(() {
                  if (isExpanded) {
                    expandedItems.remove(index);
                  } else {
                    expandedItems.add(index);
                  }
                });

                if (!isExpanded && expandedData![index] == null) {
                  await fetchDetailedData(index);
                }
              }
            },
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 8), // Changed from 12 to 8
    );
  }

  // New method for compact info display in unexpanded cards
  Widget _buildCompactInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade600,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedDetails(dynamic detailData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),

        if (detailData['ACCNM'] != null && detailData['ACCNM'].toString().isNotEmpty)
          _buildSimpleInfoRow("Account", detailData['ACCNM'].toString()),

        if (detailData['DEPTNM'] != null && detailData['DEPTNM'].toString().isNotEmpty)
          _buildSimpleInfoRow("Department", detailData['DEPTNM'].toString()),

        if (detailData['CATNM'] != null && detailData['CATNM'].toString().isNotEmpty)
          _buildSimpleInfoRow("Category", detailData['CATNM'].toString()),

        if (detailData['PLN'] != null && detailData['PLN'].toString().isNotEmpty)
          _buildSimpleInfoRow("PL Number", detailData['PLN']),

        if (detailData['CUST'] != null && detailData['CUST'].toString().isNotEmpty)
          _buildSimpleInfoRow("Custodian", detailData['CUST']),

        if (detailData['LOC'] != null && detailData['LOC'].toString().isNotEmpty)
          _buildSimpleInfoRow("Location", detailData['LOC']),

        if (detailData['EXCLDITMS'] != null && detailData['EXCLDITMS'].toString().isNotEmpty) ...[
          SizedBox(height: 12),
          Text(
            "Excluded Items:",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.deepOrange.shade600,
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(height: 6),
          Text(
            detailData['EXCLDITMS'],
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
            softWrap: true,
          ),
        ],

        if (detailData['SPCLCOND'] != null && detailData['SPCLCOND'].toString().isNotEmpty) ...[
          SizedBox(height: 12),
          Text(
            "Special Conditions:",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.amber.shade600,
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(height: 6),
          Text(
            detailData['SPCLCOND'],
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
            softWrap: true,
          ),
        ],
      ],
    );
  }

  Widget _buildLotQuantityGSTRow(int index) {
    String lotQty = jsonResult![index]['LOT_QTY'] ?? "";
    String gstInfo = "";

    if (expandedData != null &&
        index < expandedData!.length &&
        expandedData![index] != null &&
        expandedData![index][0]['GST'] != null) {
      gstInfo = " | GST: ${expandedData![index][0]['GST']}%";
    }

    return _buildSimpleInfoRow("Lot Quantity", "$lotQty$gstInfo");
  }
}