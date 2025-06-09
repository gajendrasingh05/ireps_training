import 'package:flutter/material.dart';
import 'package:flutter_app/aapoorti/common/AapoortiConstants.dart';
import 'package:flutter_app/aapoorti/common/AapoortiUtilities.dart';
import 'package:flutter_app/aapoorti/common/CommonParamData.dart';
import 'package:flutter_app/aapoorti/common/DatabaseHelper.dart';
import 'package:flutter_app/aapoorti/home/auction/schedules/schedulenextpage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Users {
  final String? sid, category;
  const Users({
    this.sid,
    this.category,
  });
}

class schedule extends StatefulWidget {
  @override
  _scheduleState createState() => _scheduleState();
}

class _scheduleState extends State<schedule> {
  List<dynamic>? jsonResult;
  final dbHelper = DatabaseHelper.instance;
  var rowcount = -1;
  void initState() {
    super.initState();

    fetchPost();
  }

  void fetchPost() async {
    rowcount = (await dbHelper.rowCountSchedule())!;
    if (rowcount <= 0) {
      var v =
          AapoortiConstants.webServiceUrl + 'Auction/AucSchedule?PAGECOUNTER=1';
      final response = await http.post(Uri.parse(v));
      jsonResult = json.decode(response.body);
      for (int index = 0; index < jsonResult!.length; index++) {
        Map<String, dynamic> row = {
          DatabaseHelper.Tblb_Col1_rail: jsonResult![index]['RLYNAME'],
          DatabaseHelper.Tblb_Col2_dept: jsonResult![index]['DEPTNAME'],
          DatabaseHelper.Tblb_Col3_schdlno: jsonResult![index]['SCHDLNO'],
          DatabaseHelper.Tblb_Col4_start: jsonResult![index]['START_DATETIME'],
          DatabaseHelper.Tblb_Col5_end: jsonResult![index]['END_DATETIME'],
          DatabaseHelper.Tblb_Col7_desc: jsonResult![index]['DESCRIPTION'],
          DatabaseHelper.Tblb_Col8_catid: jsonResult![index]['CATID'],
          DatabaseHelper.Tblb_Col12_corr: AapoortiConstants.corr,
        };
        final id1 = dbHelper.insertSchedule(row);
      }
    } else {
      debugPrint("data present in local db");
      rowcount = (await dbHelper.rowCountSchedule())!;
      debugPrint(rowcount.toString());
      debugPrint(AapoortiConstants.common);
      if (AapoortiConstants.common.compareTo(rowcount.toString()) == 0) {
        debugPrint("Equal..fetching from database");
        jsonResult = await dbHelper.fetchSchedule();
        debugPrint(jsonResult.toString());
      } else {
        debugPrint("not equal");
        debugPrint('Fetching from service');
        var v = AapoortiConstants.webServiceUrl +
            'Auction/AucSchedule?PAGECOUNTER=1';
        debugPrint("url===" + v);
        final response = await http.post(Uri.parse(v));
        jsonResult = json.decode(response.body);
        debugPrint("jsonresult===");
        debugPrint(jsonResult.toString());
        await dbHelper.deleteSchedule(1);
        debugPrint("saved function called");
        for (int index = 0; index < jsonResult!.length; index++) {
          Map<String, dynamic> row = {
            DatabaseHelper.Tblb_Col1_rail: jsonResult![index]['RLYNAME'],
            DatabaseHelper.Tblb_Col2_dept: jsonResult![index]['DEPTNAME'],
            DatabaseHelper.Tblb_Col3_schdlno: jsonResult![index]['SCHDLNO'],
            DatabaseHelper.Tblb_Col4_start: jsonResult![index]
                ['START_DATETIME'],
            DatabaseHelper.Tblb_Col5_end: jsonResult![index]['END_DATETIME'],
            DatabaseHelper.Tblb_Col7_desc: jsonResult![index]['DESCRIPTION'],
            DatabaseHelper.Tblb_Col8_catid: jsonResult![index]['CATID'],
            DatabaseHelper.Tblb_Col12_corr: AapoortiConstants.corr,
          };

          final id = dbHelper.insertSchedule(row);
        }
      }
    }

    setState(() {});
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
            backgroundColor: AapoortiConstants.primary,
            title: Text('Auction Schedule (Sale)',
                style: TextStyle(color: Colors.white, fontSize: 18))),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                color: Colors.cyan[50],
                alignment: Alignment.center,
                child: Text(
                  'Total Records',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                  child: jsonResult == null
                      ? SpinKitFadingCircle(
                          color: AapoortiConstants.primary,
                          size: 120.0,
                        )
                      : _myListView(context))
            ],
          ),
        ),
      ),
    );
  }
  Widget _myListView(BuildContext context) {
    SpinKitWave(color: Colors.red, type: SpinKitWaveType.end);

    if (jsonResult!.isEmpty) {
      AapoortiUtilities.showInSnackBar(context, "No Schedule Tender");
    } else {
      return ListView.builder(
        itemCount: jsonResult!.length,
        itemBuilder: (context, index) {
          final item = jsonResult![index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    jsonResult![index]['RLYNAME'] != null
                                        ? (jsonResult![index]['RLYNAME'] +
                                            " / " +
                                            jsonResult![index]['DEPTNAME'])
                                        : "",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.receipt_outlined,
                                      size: 16,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Schedule No : ',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[700],
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        jsonResult![index]['SCHDLNO'] != null
                                            ? jsonResult![index]['SCHDLNO']
                                            : "",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700],
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 4),
                          //   child: Container(
                          //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          //     decoration: BoxDecoration(
                          //       color: Colors.green[50],
                          //       borderRadius: BorderRadius.circular(12),
                          //       border: Border.all(color: Colors.green[200]!),
                          //     ),
                          //     child: Row(
                          //       mainAxisSize: MainAxisSize.min,
                          //       children: [
                          //         Container(
                          //           width: 6,
                          //           height: 6,
                          //           decoration: BoxDecoration(
                          //             color: Colors.green[600],
                          //             shape: BoxShape.circle,
                          //           ),
                          //         ),
                          //         const SizedBox(width: 4),
                          //         Text(
                          //           'LIVE',
                          //           style: TextStyle(
                          //             color: Colors.green[700],
                          //             fontSize: 11,
                          //             fontWeight: FontWeight.w600,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Divider(height: 1),
                      ),
                      // Time information - centered in the card
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Start time with label
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Auction Start',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    jsonResult![index]['START_DATETIME'] != null
                                        ? jsonResult![index]['START_DATETIME']
                                        : "",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  height: 20,
                                  width: 1,
                                  color: Colors.grey[300],
                                ),
                              ),
                              // End time with label
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Auction End',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.red[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    (jsonResult![index]['END_DATETIME'] != null
                                        ? jsonResult![index]['END_DATETIME']
                                        : ""),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Categories section with horizontal scrolling and lighter blue background
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[800]!.withOpacity(0.08),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 8),
                        child: Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 38,
                        child: scheduleListView(
                          context,
                          item['DESCRIPTION'].toString(),
                          item['CATID'].toString(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
    return Container();
  }

  Widget Overlay(BuildContext context, String description, String catid) {
    var sArray = description.split('#');
    var scatid = catid;
    return ListView.separated(
        itemCount: description.isNotEmpty || description.length > 0
            ? sArray.length
            : 0,
        itemBuilder: (context, index) {
          return Container(
              padding: EdgeInsets.all(0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            var route = MaterialPageRoute(
                              builder: (BuildContext context) => schedule2(
                                  value1: Users(
                                sid: scatid,
                                category: sArray[index],
                              )),
                            );
                            Navigator.of(context).push(route);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                sArray[index].toString(),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                            ],
                          ))),
                ],
              ));
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey,
            height: 20,
          );
        });
  }

  Widget scheduleListView(
      BuildContext context, String description, String catid) {
    var sArray = description.split('#');
    var scatid = catid;

    return ListView.builder(
        itemCount: sArray.isNotEmpty || sArray.length > 0 ? sArray.length : 0,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              debugPrint("live url===" + sArray[index]);
              var route = MaterialPageRoute(
                builder: (BuildContext context) => schedule2(
                    value1: Users(
                  sid: scatid,
                  category: sArray[index],
                )),
              );
              Navigator.of(context).push(route);
              debugPrint("catid===" + scatid);
              debugPrint("category===" + sArray[index]);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: Colors.lightBlue[800]!.withOpacity(0.2)),
                ),
                child: Center(
                  child: Text(
                    sArray[index].toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
