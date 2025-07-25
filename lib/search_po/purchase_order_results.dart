import 'package:flutter/material.dart';

class PurchaseOrderResultsPage extends StatefulWidget {
  const PurchaseOrderResultsPage({Key? key}) : super(key: key);

  @override
  State<PurchaseOrderResultsPage> createState() => _PurchaseOrderResultsPageState();
}

class _PurchaseOrderResultsPageState extends State<PurchaseOrderResultsPage> {
  String searchKeyword = '';
  String sortOption = 'Supplier A–Z';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> purchaseOrders = [
    {
      "supplier": "M/s.ORIENTAL RAIL INFRASTRUCTURE LIMITED-MUMBAI",
      "items": [
        {
          "poSI": "1.0",
          "desc": "1698NS01: 3 SEATER COMPLETE FOR DEMU AS PER DRG.NO. DMU/DPC/JK-2-6-1-202 ALT,NIL (DRG.ATTACHED)",
          "consignee": "SSE/Loco/Budgam",
          "poValue": "3022792",
          "qty": "55",
          "tur": "30818.83",
          "date": "26-MAY-2017"
        },
        {
          "poSI": "2.0",
          "desc": "1698NS02: 2 Seater Complete for DEMU as per Drg.No.DMU/DPC/JK-2-6-1 -203 Alt, Nil(DRG ATTACHED)",
          "consignee": "SSE/Loco/Budgam",
          "poValue": "3022792",
          "qty": "55",
          "tur": "24141.03",
          "date": "26-MAY-2017"
        }
      ]
    },
    {
      "supplier": "M/s.SHARD DHAAN SALES PVT. LTD.-KOLKATA",
      "items": [
        {
          "poSI": "1.0",
          "desc": "31356679: 1/2 INCH SAFETY VALVE TYPE T-2 SET AT 110 PSI TO W.S.F PART NO. J 70929/18 OR ESCORT PART NO. 3EP 5551/1. FIRM'S OFFER: 1/2 INCH SAFETY VALVE TYPE 12 SET 8 Kg/cm2 TO WSF PART NO: J70929/18.",
          "consignee": "EMU/GZB",
          "poValue": "206386.95",
          "qty": "107",
          "tur": "1928.85",
          "date": "30-NOV-2017"
        }
      ]
    },
    {
      "supplier": "M/s.CONTRANSYS PRIVATE LIMITED-KOLKATA",
      "items": [
        {
          "poSI": "1.0",
          "desc": "23880399: LONGITUDINAL TUBE ASSEMBLY FOR IR03H PANTOGRAPH CCPL DRG. C0H1410 CONFIRMING TO SPEC. CLW/ES/P-5 ALT.F FIRM'S OFFER: LONGITUDINAL TUBE ASSEMBLY TO CONTRANSYS PART NO. C0H1400",
          "consignee": "ETD/GZB",
          "poValue": "66990",
          "qty": "11",
          "tur": "6090.00",
          "date": "13-FEB-2017"
        }
      ]
    },
    {
      "supplier": "M/s.AUTO SERVICE EQUIPMENT-NEW DELHI",
      "items": [
        {
          "poSI": "1.0",
          "desc": "H.P. PISTON ASSMBLY AS PER ELGI PART NO. HP-101",
          "consignee": "DLW/VARANASI",
          "poValue": "50250",
          "qty": "5",
          "tur": "10050.00",
          "date": "15-DEC-2017"
        }
      ]
    },
    {
      "supplier": "M/s.ESCORTS KUBOTA LIMITED-FARIDABAD",
      "items": [
        {
          "poSI": "1.0",
          "desc": "EMERGENCY APPLICATION VALVE FOR EP BRAKE SYSTEM",
          "consignee": "CRWS/BPL",
          "poValue": "87000",
          "qty": "10",
          "tur": "8700.00",
          "date": "01-JAN-2018"
        }
      ]
    },
    {
      "supplier": "M/s.S.K.ENGINEERING ENTERPRISE-HOWRAH",
      "items": [
        {
          "poSI": "1.0",
          "desc": "METALLIC CAPSULES SINTERED BRONZE",
          "consignee": "ERD/KGP",
          "poValue": "32000",
          "qty": "50",
          "tur": "640.00",
          "date": "20-DEC-2017"
        }
      ]
    }
  ];

  List<Map<String, dynamic>> _getFilteredSortedList() {
    List<Map<String, dynamic>> list = purchaseOrders.where((po) {
      final keyword = searchKeyword.toLowerCase();
      final supplierMatch = po['supplier'].toString().toLowerCase().contains(keyword);
      final itemsMatch = (po['items'] as List).any((item) =>
      item['desc'].toString().toLowerCase().contains(keyword) ||
          item['consignee'].toString().toLowerCase().contains(keyword));
      return searchKeyword.isEmpty || supplierMatch || itemsMatch;
    }).toList();

    switch (sortOption) {
      case 'Supplier A–Z':
        list.sort((a, b) => a['supplier'].compareTo(b['supplier']));
        break;
      case 'Location':
        list.sort((a, b) =>
            a['supplier'].toString().split('-').last.compareTo(b['supplier'].toString().split('-').last));
        break;
      case 'Recent':
        list.sort((a, b) =>
            (b['items'][0]['date'] as String).compareTo(a['items'][0]['date'] as String));
        break;
    }

    return list;
  }

  Widget _buildHighlightedText(String text) {
    if (searchKeyword.isEmpty || !text.toLowerCase().contains(searchKeyword.toLowerCase())) {
      return Text(text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14, color: Colors.grey[800]));
    }

    final keyword = searchKeyword.toLowerCase();
    final escapedKeyword = RegExp.escape(keyword);

    try {
      final segments = text.split(RegExp("(?i)($escapedKeyword)"));
      return RichText(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          children: segments.map((seg) {
            final isMatch = seg.toLowerCase() == keyword;
            return TextSpan(
              text: seg,
              style: isMatch
                  ? const TextStyle(backgroundColor: Colors.yellow, color: Colors.black)
                  : null,
            );
          }).toList(),
        ),
      );
    } catch (e) {
      return Text(text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14, color: Colors.grey[800]));
    }
  }

  void _showBottomSheet(BuildContext context, Map<String, dynamic> po) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final List<dynamic> items = po['items'];
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                po['supplier'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("PO SI: ${item['poSI']}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                        const SizedBox(height: 4),
                        const Text("Item Description:", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        Text(item['desc'], style: const TextStyle(fontSize: 14)),
                        Text("Consignee: ${item['consignee']}", style: const TextStyle(color: Colors.black54)),
                        Text("PO Value: ₹${item['poValue']}", style: const TextStyle(color: Colors.black54)),
                        Text("Qty/Unit: ${item['qty']}", style: const TextStyle(color: Colors.black54)),
                        Text("T.U.R: ₹${item['tur']}", style: const TextStyle(color: Colors.black54)),
                        Text("Dely Date: ${item['date']}", style: const TextStyle(color: Colors.black54)),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _getFilteredSortedList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Purchase Order Search"),
        backgroundColor: Colors.blue.shade900,
        leading: const BackButton(),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.teal,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Center(
              child: Text("List of Purchase Orders", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search supplier/item...",
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchKeyword = value.trim();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    value: sortOption,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Supplier A–Z', child: Text("Supplier A–Z")),
                      DropdownMenuItem(value: 'Location', child: Text("Location")),
                      DropdownMenuItem(value: 'Recent', child: Text("Recent")),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          sortOption = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: filteredList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final po = filteredList[index];
                final items = po['items'] as List<dynamic>;
                final firstDesc = items.first['desc'];
                final extraItems = items.length > 1 ? "\n+ ${items.length - 1} more item(s)" : "";

                return GestureDetector(
                  onTap: () => _showBottomSheet(context, po),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.blue.shade100,
                          child: Text("${index + 1}", style: const TextStyle(fontSize: 14, color: Colors.blue)),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(po['supplier'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.indigo)),
                              const SizedBox(height: 4),
                              _buildHighlightedText("Item Desc: $firstDesc$extraItems"),
                            ],
                          ),
                        ),
                      ],
                    ),
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
