import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/aapoorti/common/AapoortiConstants.dart';
import 'package:flutter_app/aapoorti/common/AapoortiUtilities.dart';
import 'package:flutter_app/aapoorti/common/CommonParamData.dart';
import 'package:flutter_app/aapoorti/common/DatabaseHelper.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:flutter_app/aapoorti/home/auction/schedules/schedule.dart';
import 'package:flutter_app/aapoorti/home/auction/schedules/schedulethirdpage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Users1 {
  final String? lotid, des;

  const Users1({this.lotid, this.des});
}

class schedule2 extends StatefulWidget {
  get path => null;
  final Users? value1;

  schedule2({Key? key, this.value1}) : super(key: key);

  @override
  _schedule2State createState() => _schedule2State();
}

class _schedule2State extends State<schedule2> with TickerProviderStateMixin {
  List<dynamic>? jsonResult, jsonResult1, jsonResult2;
  final dbHelper = DatabaseHelper.instance;
  ProgressDialog? pr;
  String? _mySelection;
  String? _mySelection1;
  String? _mySelection2;

  // New variables for expandable functionality
  List<dynamic>? expandedData = [];
  Set<int> expandedItems = {};
  late AnimationController _animationController;

  var rowCount = -1;
  String? pgno;
  int? lotid, id;
  int? total_records, no_pages;
  int flag = 0;
  int? initialValRange;
  int? initalValueRange;
  int recordsPerPageCounter = 0;
  int final_value = 0;
  int? calculated_value;

  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    fetchPost();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List data = [];
  void fetchPost() async {
    var url = AapoortiConstants.webServiceUrl + 'Auction/CatalogueDesc?CID=${widget.value1!.sid}&CATEGORY=${widget.value1!.category}';
    final response = await http.post(Uri.parse(url));
    setState(() {
      jsonResult = json.decode(response.body);
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
        resizeToAvoidBottomInset: false,
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
                  Navigator.of(context, rootNavigator: true).pop();
                },
                splashRadius: 24,
              ),
            ),
          ],
          title: Text(
            'Auction Schedule',
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
                  'Loading schedule...',
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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (jsonResult![index]['LOT_STATUS']?.toString().toLowerCase().contains('live') == true) ...[
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green.withOpacity(0.6),
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 6),
                              ],
                              Text(
                                jsonResult![index]['LOT_STATUS'] ?? "",
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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
                          _buildCompactInfoRow("Quantity", jsonResult![index]['LOT_QTY'] ?? ""),
                          _buildCompactInfoRow("Min. Increment", "₹${jsonResult![index]['MIN_INCR_AMT'] ?? ""}"),
                          _buildCompactInfoRow("Start Time", jsonResult![index]['LOT_START_DATETIME'] ?? ""),
                          _buildCompactInfoRow("End Time", jsonResult![index]['LOT_END_DATETIME'] ?? ""),

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
                          ],
                        ],
                      ],
                    ),
                  ),

                  // Arrow indicator at bottom for expandable cards
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

  // Method for compact info display in unexpanded cards
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

        // Account/Department combined
        if (detailData['ACCNM'] != null && detailData['DEPTNM'] != null &&
            detailData['ACCNM'].toString().isNotEmpty && detailData['DEPTNM'].toString().isNotEmpty)
          _buildCompactDetailInfoRow("Account/Department", "${detailData['ACCNM']}/${detailData['DEPTNM']}"),

        // Category/Part
        if (detailData['CATNM'] != null && detailData['CATNM'].toString().isNotEmpty)
          _buildCompactDetailInfoRow("Category/Part", detailData['CATNM'].toString()),

        // PL Number
        if (detailData['PLN'] != null && detailData['PLN'].toString().isNotEmpty)
          _buildCompactDetailInfoRow("PL Number", detailData['PLN']),

        // Custodian
        if (detailData['CUST'] != null && detailData['CUST'].toString().isNotEmpty)
          _buildCompactDetailInfoRow("Custodian", detailData['CUST']),

        // Location
        if (detailData['LOC'] != null && detailData['LOC'].toString().isNotEmpty)
          _buildCompactDetailInfoRow("Location", detailData['LOC']),

        // Excluded Items (moved above description)
        if (detailData['EXCLDITMS'] != null && detailData['EXCLDITMS'].toString().isNotEmpty)
          _buildCompactDetailInfoRow("Excluded Items", detailData['EXCLDITMS']),

        // Description - Special section
        if (detailData['LOTMATDESC'] != null && detailData['LOTMATDESC'].toString().isNotEmpty) ...[
          SizedBox(height: 12),
          Text(
            "Description:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.blue.shade800,
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(height: 8),
          Text(
            detailData['LOTMATDESC'],
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
            softWrap: true,
          ),
          SizedBox(height: 12), // Changed from Divider to SizedBox
        ],

        // Special Conditions - Special section
        if (detailData['SPCLCOND'] != null && detailData['SPCLCOND'].toString().isNotEmpty) ...[
          Text(
            "Special Conditions:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.amber.shade600,
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(height: 8),
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

  // New method for detailed info rows with dividers like schedule3
  Widget _buildDetailInfoRow(String label, String value) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 140,
                child: Text(
                  "$label:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue.shade700,
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
        ),
        Divider(color: Colors.grey.shade300),
      ],
    );
  }

  // New compact method for details without dividers
  Widget _buildCompactDetailInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.blue.shade700,
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

  Widget _buildLotQuantityGSTRow(int index) {
    String lotQty = jsonResult![index]['LOT_QTY'] ?? "";
    String gstInfo = "";

    if (expandedData != null &&
        index < expandedData!.length &&
        expandedData![index] != null &&
        expandedData![index][0]['GST'] != null) {
      gstInfo = " / GST: ${expandedData![index][0]['GST']}%";
    }

    return _buildSimpleInfoRow("Lot Quantity", "$lotQty$gstInfo");
  }

  Widget livelotid(BuildContext context, String Description, String livelotid) {
    var lotid = livelotid;
    var des = Description;

    var route = MaterialPageRoute(
      builder: (BuildContext context) => schedule3(
          value3: Users1(
            lotid: lotid,
            des: des,
          )),
    );
    Navigator.of(context).push(route);
    return SizedBox();
  }
}