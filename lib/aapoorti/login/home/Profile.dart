import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/aapoorti/common/AapoortiUtilities.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatelessWidget {
  String? username,
      emailid,
      phoneno,
      usertype,
      workarea,
      firmname,
      lastlogintime;
  String phone_IREPS = 'tel:+91-11-23761525',
      phone_SBIePAY = 'tel:+91-22-27523816',
      phone_SBInetBanking1 = 'tel:+91-11-23761525',
      phone_SBInetBanking2 = 'tel:+91-22-27566067',
      phone_SBInetBanking3 = 'tel:+91-22-27560137',
      phone_SBInetBanking4 = 'tel:+91-22-27566501',
      email_SBIePAY = 'sbipay@sbi.co.in',
      email_SBInetbanking = "inb.cinb@sbi.co.in";
  String phnl = "", url = "";
  _callPhone(phn1) async {
    if (await canLaunch(phn1)) {
      await launch(phn1);
    } else {
      throw 'Could not Call Phone';
    }
  }

  _launchURL(String toMailId) async {
    var url = 'mailto:$toMailId';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal,
        title: Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.teal,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 45,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      username!.isEmpty ? SizedBox(height: 1, width: 1) : Text(username ?? "NA", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "User Details",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                SizedBox(height: 15),
                _buildDetailsContainer([
                  _buildDetailRow(Icons.phone, Colors.green, phoneno!),
                  _buildDetailRow(Icons.email, Colors.red, emailid!),
                  _buildDetailRow(Icons.account_circle, Colors.blue, usertype ?? "NA"),
                  _buildDetailRow(Icons.lock, Colors.orange, workarea ?? "NA"),
                  firmname == null || firmname == "null" ? _buildDetailRow(Icons.apartment, Colors.purple, "NA") : _buildDetailRow(Icons.apartment, Colors.purple, firmname),
                ]),
                SizedBox(height: 40),
                _buildDetailsContainer([
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.teal, size: 24),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Last Login Time",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(lastlogintime!,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade600)),
                        ],
                      ),
                    ],
                  ),
                ]),
              ],
            ),
          ),
        ),
        // child: Stack(
        //   children: [
        //     Positioned(
        //       top: 0,
        //       left: 0,
        //       child: Stack(
        //         alignment: Alignment.center,
        //         children: [
        //           Container(
        //             height: mediaQuery.size.height * 0.50,
        //             width: mediaQuery.size.width,
        //             decoration: BoxDecoration(
        //               image: DecorationImage(
        //                 fit: BoxFit.fitHeight,
        //                 image: AssetImage('assets/welcome.jpg'),
        //               ),
        //             ),
        //           ),
        //           Positioned(
        //             bottom: mediaQuery.size.height * 0.15,
        //             child: FittedBox(
        //               child: Column(
        //                 children: [
        //                   Container(
        //                     child: CircleAvatar(
        //                       radius: 50,
        //                       backgroundColor: Colors.transparent,
        //                       foregroundColor: Colors.black,
        //                       child: Padding(
        //                         padding: const EdgeInsets.all(8.0),
        //                         child: Text(
        //                           nameToInitials,
        //                           style: TextStyle(
        //                             fontSize: 50,
        //                             fontWeight: FontWeight.w300,
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                     decoration: BoxDecoration(
        //                       color: Colors.white60,
        //                       borderRadius: BorderRadius.circular(100),
        //                     ),
        //                   ),
        //                   SizedBox(height: 20),
        //                   Container(
        //                     height: 30,
        //                     // width: mediaQuery.size.width * 0.6,
        //                     width: 250,
        //                     child: FittedBox(
        //                       child: (username!.isEmpty || username == null)
        //                           ? SizedBox(height: 1, width: 1)
        //                           : Text(
        //                         username!,
        //                         style: TextStyle(
        //                           fontWeight: FontWeight.bold,
        //                         ),
        //                       ),
        //                     ),
        //                     decoration: BoxDecoration(
        //                       color: Colors.white60,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     Positioned(
        //       bottom: 0,
        //       child: Container(
        //         height: mediaQuery.size.height * 0.55,
        //         width: mediaQuery.size.width,
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(40),
        //             topRight: Radius.circular(40),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       bottom: 0,
        //       child: Container(
        //         height: mediaQuery.size.height * 0.55,
        //         width: mediaQuery.size.width,
        //         decoration: BoxDecoration(
        //           color: Colors.blue,
        //           borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(40),
        //             topRight: Radius.circular(40),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       bottom: 0,
        //       right: 0,
        //       child: Container(
        //         height: mediaQuery.size.height * 0.55,
        //         width: mediaQuery.size.width,
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(40),
        //             topRight: Radius.circular(40),
        //           ),
        //         ),
        //         child: Padding(
        //           padding:
        //           const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
        //           child: ListView(
        //             children: [
        //               Row(
        //                 children: [
        //                   Icon(Icons.phone, size: 25),
        //                   SizedBox(width: 25),
        //                   Expanded(
        //                     child: Text(
        //                       phoneno!,
        //                       style: TextStyle(
        //                         fontSize: 20,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               SizedBox(height: 20),
        //               Row(
        //                 children: [
        //                   Icon(Icons.email, size: 25),
        //                   SizedBox(width: 25),
        //                   FittedBox(
        //                     alignment: Alignment.topLeft,
        //                     fit: BoxFit.scaleDown,
        //                     child: (emailid == null || emailid!.isEmpty)
        //                         ? SizedBox(width: 1, height: 1)
        //                         : Text(
        //                       emailid!,
        //                       style: TextStyle(
        //                         fontSize: 20,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               SizedBox(height: 20),
        //               Row(
        //                 children: [
        //                   Image.asset(
        //                     'assets/name_profile.png',
        //                     width: 24,
        //                     height: 32,
        //                   ),
        //                   SizedBox(width: 25),
        //                   Expanded(
        //                     child: Text(
        //                       usertype!,
        //                       style: TextStyle(
        //                         fontSize: 20,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               SizedBox(height: 20),
        //               Row(
        //                 children: [
        //                   Image.asset(
        //                     'assets/work_area.png',
        //                     width: 24,
        //                     height: 32,
        //                   ),
        //                   SizedBox(width: 25),
        //                   Expanded(
        //                     child: Text(
        //                       workarea!,
        //                       style: TextStyle(
        //                         fontSize: 20,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               SizedBox(height: 10),
        //               Row(
        //                 children: [
        //                   // Expanded(
        //                   //   child: Divider(),
        //                   // ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Text(
        //                       'Organization Details',
        //                       style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 16,
        //                         color: Colors.blue[900],
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     child: Divider(),
        //                   ),
        //                 ],
        //               ),
        //               SizedBox(height: 10),
        //
        //               Row(
        //                 children: [
        //                   Image.asset(
        //                     'assets/firm_icon.png',
        //                     width: 24,
        //                     height: 32,
        //                   ),
        //                   SizedBox(width: 25),
        //                   Expanded(
        //                     child: Text(
        //                       firmname!,
        //                       style: TextStyle(
        //                         fontSize: 20,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               SizedBox(height: 10),
        //               Row(
        //                 children: [
        //                   // Expanded(
        //                   //   child: Divider(),
        //                   // ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Text(
        //                       'Last Login Time',
        //                       style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 16,
        //                         color: Colors.blue[900],
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     child: Divider(),
        //                   ),
        //                 ],
        //               ),
        //               SizedBox(height: 10),
        //               Row(
        //                 children: [
        //                   Image.asset(
        //                     'assets/login_time.png',
        //                     width: 24,
        //                     height: 32,
        //                   ),
        //                   SizedBox(width: 25),
        //                   Expanded(
        //                     child: Text(
        //                       lastlogintime!,
        //                       style: TextStyle(
        //                         fontSize: 20,
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               SizedBox(height: 20),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
      // body: ListView(
      //   children: <Widget>[
      //     Card(
      //       child: Container(
      //         decoration: BoxDecoration(
      //           image: DecorationImage(
      //             image: ExactAssetImage('assets/welcome.jpg'),
      //             fit: BoxFit.cover,
      //             colorFilter: ColorFilter.mode(
      //                 Colors.white.withOpacity(0.2), BlendMode.dstATop),
      //           ),
      //         ),
      //         height: 200,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: <Widget>[
      //             Center(
      //               child: SizedBox(
      //                 height: 100,
      //                 width: 100,
      //                 child: Icon(
      //                   Icons.account_circle,
      //                   size: 100,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //             ),
      //             Padding(padding: EdgeInsets.only(bottom: 10.0)),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Padding(padding: EdgeInsets.only(top: 10)),
      //     Card(
      //       child: Column(
      //         children: <Widget>[
      //           Padding(padding: EdgeInsets.only(top: 10)),
      //           Text('User Details', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      //           //new Padding(padding: new EdgeInsets.all(15.0)),
      //           Container(
      //             height: 0.5,
      //             padding: EdgeInsets.all(10),
      //             color: Colors.grey,
      //           ),
      //           Column(
      //             children: <Widget>[
      //               Row(
      //                 children: <Widget>[
      //                   Padding(
      //                       padding: EdgeInsets.only(top: 10.0, left: 20.0)),
      //                   Image.asset(
      //                     'assets/name.png',
      //                     width: 30,
      //                     height: 40,
      //                   ),
      //                   Padding(padding: EdgeInsets.only(top: 5.0, left: 15.0)),
      //                   InkWell(
      //                     child: Text(username!,
      //                         style: TextStyle(
      //                           color: Colors.black,
      //                           fontSize: 15,
      //                         )),
      //                     onTap: () {},
      //                   ),
      //                 ],
      //               ),
      //               Padding(padding: EdgeInsets.only(top: 10.0)),
      //               Row(
      //                 children: <Widget>[
      //                   Padding(
      //                       padding: EdgeInsets.only(top: 10.0, left: 20.0)),
      //                   Image.asset(
      //                     'assets/email_profile.png',
      //                     width: 30,
      //                     height: 40,
      //                   ),
      //                   Padding(padding: EdgeInsets.only(top: 5.0, left: 15.0)),
      //                   InkWell(
      //                     child: Text(emailid!,
      //                         style: TextStyle(
      //                           color: Colors.black,
      //                           fontSize: 15,
      //                         )),
      //                     onTap: () {},
      //                   ),
      //                 ],
      //               ),
      //               Padding(padding: EdgeInsets.only(top: 10.0)),
      //               Row(
      //                 children: <Widget>[
      //                   Padding(
      //                       padding: EdgeInsets.only(top: 10.0, left: 20.0)),
      //                   Image.asset(
      //                     'assets/phone_icon.png',
      //                     width: 30,
      //                     height: 40,
      //                   ),
      //                   Padding(padding: EdgeInsets.only(top: 5.0, left: 15.0)),
      //                   InkWell(
      //                     child: Text(phoneno!,
      //                         style: TextStyle(
      //                           color: Colors.black,
      //                           fontSize: 15,
      //                         )),
      //                     onTap: () {},
      //                   ),
      //                 ],
      //               ),
      //               Padding(padding: EdgeInsets.only(top: 10.0)),
      //               Row(
      //                 children: <Widget>[
      //                   Padding(
      //                       padding: EdgeInsets.only(top: 10.0, left: 20.0)),
      //                   Image.asset(
      //                     'assets/name_profile.png',
      //                     width: 30,
      //                     height: 40,
      //                   ),
      //                   Padding(padding: EdgeInsets.only(top: 5.0, left: 15.0)),
      //                   InkWell(
      //                     child: Text(usertype!,
      //                         style: TextStyle(
      //                           color: Colors.black,
      //                           fontSize: 15,
      //                         )),
      //                     onTap: () {},
      //                   ),
      //                 ],
      //               ),
      //               Padding(padding: EdgeInsets.only(top: 10.0)),
      //               Row(
      //                 children: <Widget>[
      //                   Padding(
      //                       padding: EdgeInsets.only(top: 10.0, left: 20.0)),
      //                   Image.asset(
      //                     'assets/work_area.png',
      //                     width: 30,
      //                     height: 40,
      //                   ),
      //                   Padding(padding: EdgeInsets.only(top: 5.0, left: 15.0)),
      //                   InkWell(
      //                     child: Text(workarea ?? "NA",
      //                         style: TextStyle(
      //                           color: Colors.black,
      //                           fontSize: 15,
      //                         )),
      //                     onTap: () {},
      //                   ),
      //                 ],
      //               ),
      //               Padding(padding: EdgeInsets.only(top: 10.0)),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //     Padding(padding: EdgeInsets.only(top: 10)),
      //     Card(
      //       child: Column(
      //         children: <Widget>[
      //           Padding(padding: EdgeInsets.only(top: 10)),
      //           Text('Firm Details', style: TextStyle(
      //                 color: Colors.black,
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 15.0),
      //           ),
      //           Container(
      //             child: Row(
      //               children: <Widget>[
      //                 Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0)),
      //                 Image.asset(
      //                   'assets/firm_icon.png',
      //                   width: 30,
      //                   height: 40,
      //                 ),
      //                 Padding(padding: EdgeInsets.only(top: 5.0, left: 15.0)),
      //                 InkWell(
      //                   child: Text(firmname ?? "NA",
      //                       style: TextStyle(
      //                         color: Colors.black,
      //                         fontSize: 15,
      //                       )),
      //                   onTap: () {},
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     Padding(padding: EdgeInsets.only(top: 10)),
      //     Card(
      //       child: Column(
      //         children: <Widget>[
      //           Padding(padding: EdgeInsets.only(top: 10)),
      //           Text('Last Login Time', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0)),
      //           Container(
      //             child: Row(
      //               children: <Widget>[
      //                 Padding(padding: EdgeInsets.only(top: 10.0, left: 20.0)),
      //                 Image.asset(
      //                   'assets/login_time.png',
      //                   width: 30,
      //                   height: 40,
      //                 ),
      //                 Padding(padding: EdgeInsets.only(top: 5.0, left: 15.0)),
      //                 InkWell(
      //                   child: Text(lastlogintime!,
      //                       style: TextStyle(
      //                         color: Colors.black,
      //                         fontSize: 15,
      //                       )),
      //                   onTap: () {},
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Profile() {
    username = AapoortiUtilities.user!.USER_NAME;

    usertype = AapoortiUtilities.user!.U_VALUE;
    emailid = AapoortiUtilities.user!.EMAIL_ID;
    phoneno = AapoortiUtilities.user!.MOBILE;
    if (AapoortiUtilities.user!.USER_TYPE == "0") {
      workarea = "HelpDesk";
    } else if (AapoortiUtilities.user!.USER_TYPE == "8" ||
        AapoortiUtilities.user!.USER_TYPE == "9")
      workarea = "Auction User";
    else if (AapoortiUtilities.user!.CUSTOM_WK_AREA == "PT") {
      workarea = "Goods and Services";
    } else if (AapoortiUtilities.user!.CUSTOM_WK_AREA == "WT") {
      workarea = "Works";
    } else if (AapoortiUtilities.user!.CUSTOM_WK_AREA == "LT") {
      workarea = "Earning/Leasing";
    }
    firmname = AapoortiUtilities.user!.FIRM_NAME;
    lastlogintime = AapoortiUtilities.user!.LAST_LOG_TIME;
  }

  Widget _buildDetailsContainer(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.4), spreadRadius: 3, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: children
            .map((child) => Column(children: [child, Divider(height: 20, thickness: 1.5)]))
            .expand((widget) => widget.children)
            .toList()
          ..removeLast(),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, Color color, String? text) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(width: 12),
        Text(text ?? "NA", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
