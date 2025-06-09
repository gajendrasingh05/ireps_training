import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warranty Rejection Register',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: WarrantyRejectionRegister(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WarrantyRejectionRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: Text(
          'Warranty Rejection Register',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Summary of Warranty Claim From: 11-12-2024 To: 09-06-2025',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Total Warranty Claim Amount\n(Original)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Rs. 5526106',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Total Warranty Claim Amount\n(Current)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Rs. 4345779',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // List Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                WarrantyClaimCard(
                  index: 1,
                  consigneeDepot: 'IREPS-36640-SSE-I/PS/NDLS',
                  claimDetails: '36640-24-00147 dt. 22-12-24',
                  claimDetailsLink: '36640-23-00460 dt. 02-12-23',
                  vendorName: 'TEST BIDDER 1.-KANPUR',
                  contractNo: '3445423222 dt. 01-02-23',
                  challanNo: 'CH/21/122/091 dt. 21-12-23',
                  itemCode: '10120385',
                  itemDescription: 'Guide air and exhaust valve STD, DLW drg.No. 23C71071-2, Alt-k to DLW part No.10120385, 5% supply will be...',
                  quantityRejected: '5 Nos.',
                  quantityWithdrawn: '1 Nos.',
                  balanceAvailable: '2 Nos.',
                  quantityReInspected: '1 Nos.',
                  quantityAccepted: '4 Nos.',
                  quantityReturned: '1 Nos.',
                  quantityReplaced: '0 Nos.',
                  originalRecovery: '710',
                  recoveryAmount: '0',
                  balanceRecovery: '0',
                  originalRejectedQty: '710',
                  balanceRejectedQty: '284',
                  rejectionReason: 'dggbdfgb',
                  rejectedMaterialLocation: 'cgbfgf',
                ),
                SizedBox(height: 16),
                WarrantyClaimCard(
                  index: 2,
                  consigneeDepot: 'IREPS-36640-SSE-I/PS/NDLS',
                  claimDetails: '36640-24-00153 dt. 22-12-24',
                  claimDetailsLink: 'UDM: rkb-dr-drill-22-12-24 dt. 22-12-2024',
                  vendorName: 'TEST BIDDER 1.-KANPUR',
                  contractNo: '12332552354234 dt. 06-12-23',
                  challanNo: 'NA dt. NA',
                  itemCode: '56345892',
                  itemDescription: 'vertical damper (Product/Component Rejected: vertical damper - PL No.457896412)',
                  quantityRejected: '10 Nos.',
                  quantityWithdrawn: '1 Nos.',
                  balanceAvailable: '6 Nos.',
                  quantityReInspected: '1 Nos.',
                  quantityAccepted: '6 Nos.',
                  quantityReturned: '0 Nos.',
                  quantityReplaced: '2 Nos.',
                  originalRecovery: '458790',
                  recoveryAmount: '0',
                  balanceRecovery: '45879',
                  originalRejectedQty: '458790',
                  balanceRejectedQty: '275274',
                  rejectionReason: 'breakage',
                  rejectedMaterialLocation: 'dfgggssdf',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WarrantyClaimCard extends StatelessWidget {
  final int index;
  final String consigneeDepot;
  final String claimDetails;
  final String claimDetailsLink;
  final String vendorName;
  final String contractNo;
  final String challanNo;
  final String itemCode;
  final String itemDescription;
  final String quantityRejected;
  final String quantityWithdrawn;
  final String balanceAvailable;
  final String quantityReInspected;
  final String quantityAccepted;
  final String quantityReturned;
  final String quantityReplaced;
  final String originalRecovery;
  final String recoveryAmount;
  final String balanceRecovery;
  final String originalRejectedQty;
  final String balanceRejectedQty;
  final String rejectionReason;
  final String rejectedMaterialLocation;

  const WarrantyClaimCard({
    Key? key,
    required this.index,
    required this.consigneeDepot,
    required this.claimDetails,
    required this.claimDetailsLink,
    required this.vendorName,
    required this.contractNo,
    required this.challanNo,
    required this.itemCode,
    required this.itemDescription,
    required this.quantityRejected,
    required this.quantityWithdrawn,
    required this.balanceAvailable,
    required this.quantityReInspected,
    required this.quantityAccepted,
    required this.quantityReturned,
    required this.quantityReplaced,
    required this.originalRecovery,
    required this.recoveryAmount,
    required this.balanceRecovery,
    required this.originalRejectedQty,
    required this.balanceRejectedQty,
    required this.rejectionReason,
    required this.rejectedMaterialLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Index Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      '$index',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Consignee Depot', consigneeDepot),
                SizedBox(height: 12),

                _buildSectionTitle('Warranty Claim & Receipt/Rejection Details'),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        claimDetails,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ),
                    Text(' / ', style: TextStyle(color: Colors.grey[500])),
                    Expanded(
                      child: Text(
                        claimDetailsLink,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                _buildInfoRow('Vendor Name', vendorName, valueColor: Colors.blue[600]),
                SizedBox(height: 16),

                _buildSectionTitle('PO-Contract No. & Date/Challan No. & Date'),
                SizedBox(height: 8),
                Text(
                  '$contractNo / $challanNo',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 16),

                _buildSectionTitle('Item Description'),
                SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$itemCode : ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      TextSpan(
                        text: itemDescription,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                _buildQuantityRow('Quantity Rejected/Claim Withdrawn/Bal.Rej.Avail',
                    quantityRejected, quantityWithdrawn, balanceAvailable),
                SizedBox(height: 12),

                _buildQuantityRow('Quantity Re-Insp./Accept.(Re-Insp.)/Returned/Replaced',
                    quantityReInspected, quantityAccepted, quantityReturned, quantityReplaced),
                SizedBox(height: 12),

                _buildQuantityRow('Orig.Recovery/Recov.Amt./Bal.Recovery',
                    originalRecovery, recoveryAmount, balanceRecovery),
                SizedBox(height: 12),

                _buildQuantityRow('Value Orig.Rej.Qty./Bal.Rej.Qty./Acct. Unit',
                    originalRejectedQty, balanceRejectedQty, ''),
                SizedBox(height: 16),

                _buildInfoRow('Rejection Reason/Rejected Material Location',
                    '$rejectionReason/$rejectedMaterialLocation'),
                SizedBox(height: 20),

                // View Warranty Claim Button
                Container(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.visibility,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text(
                      'View Warranty Claim',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: valueColor ?? Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityRow(String label, String value1, String value2, String value3, [String? value4]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            _buildQuantityValue(value1, Colors.blue[600]),
            Text(' / ', style: TextStyle(color: Colors.grey[500])),
            _buildQuantityValue(value2, Colors.blue[600]),
            Text(' / ', style: TextStyle(color: Colors.grey[500])),
            _buildQuantityValue(value3, Colors.blue[600]),
            if (value4 != null && value4.isNotEmpty) ...[
              Text(' / ', style: TextStyle(color: Colors.grey[500])),
              _buildQuantityValue(value4, Colors.blue[600]),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityValue(String value, Color? color) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 14,
        color: color ?? Colors.grey[700],
        fontWeight: FontWeight.w500,
      ),
    );
  }
}