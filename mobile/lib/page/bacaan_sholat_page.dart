// import 'dart:convert';
// import 'package:bacaanshalat/model/model_bacaan.dart';
// import 'package:flutter/material.dart';
// // ignore: library_prefixes
// import 'package:flutter/services.dart' as rootBundle;
//
// class BacaanSholat extends StatefulWidget {
//   const BacaanSholat({Key? key}) : super(key: key);
//   @override
//   // ignore: library_private_types_in_public_api
//   _BacaanSholatState createState() => _BacaanSholatState();
// }
//
// class _BacaanSholatState extends State<BacaanSholat> {
//   // ignore: non_constant_identifier_names
//   Future<List<ModelBacaan>> ReadJsonData() async {
//     final jsondata =
//         await rootBundle.rootBundle.loadString('assets/data/bacaanshalat.json');
//     final list = json.decode(jsondata) as List<dynamic>;
//     return list.map((e) => ModelBacaan.fromJson(e)).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(179, 117, 1, 1),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Stack(
//               children: [
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: IconButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     icon: const Icon(Icons.arrow_back,
//                         color: Color.fromARGB(255, 248, 243, 243)),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Container(
//                     margin: const EdgeInsets.only(top: 80),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         color: Color.fromARGB(255, 255, 255, 255)),
//                     height: 200,
//                     width: MediaQuery.of(context).size.width,
//                     child: Container(
//                         margin: const EdgeInsets.only(top: 120, left: 20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             Text(
//                               "Bacaan Sholat",
//                               style: TextStyle(
//                                   color: Color.fromARGB(255, 0, 0, 0),
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               "Bacaan sholat dari doa Iftitah sampai Salam",
//                               style: TextStyle(
//                                   color: Color.fromARGB(255, 0, 0, 0),
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         )),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       bottomLeft: Radius.circular(30),
//                       bottomRight: Radius.circular(30),
//                     ),
//                     child: Image.asset(
//                       "assets/images/bg_sholat.gif",
//                       width: 140,
//                       height: 300,
//                       fit: BoxFit.fitWidth,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: FutureBuilder(
//                 future: ReadJsonData(),
//                 builder: (context, data) {
//                   if (data.hasError) {
//                     return Center(child: Text("${data.error}"));
//                   } else if (data.hasData) {
//                     var items = data.data as List<ModelBacaan>;
//                     return ListView.builder(
//                         // ignore: unnecessary_null_comparison
//                         itemCount: items == null ? 0 : items.length,
//                         itemBuilder: (context, index) {
//                           return Card(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10)),
//                             elevation: 5,
//                             margin: const EdgeInsets.all(15),
//                             child: Theme(
//                               data: Theme.of(context)
//                                   .copyWith(dividerColor: Colors.transparent),
//                               child: ExpansionTile(
//                                 title: Text(
//                                   items[index].name.toString(),
//                                   style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.all(8),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Expanded(
//                                             child: Container(
//                                           padding:
//                                               const EdgeInsets.only(bottom: 8),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8, right: 8),
//                                                 child: Text(
//                                                   items[index]
//                                                       .arabic
//                                                       .toString(),
//                                                   style: const TextStyle(
//                                                       fontSize: 16,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8, right: 8),
//                                                 child: Text(
//                                                   items[index].latin.toString(),
//                                                   style: const TextStyle(
//                                                       fontSize: 14,
//                                                       fontStyle:
//                                                           FontStyle.italic),
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8, right: 8, top: 5),
//                                                 child: Text(
//                                                     items[index]
//                                                         .terjemahan
//                                                         .toString(),
//                                                     style: const TextStyle(
//                                                       fontSize: 12,
//                                                     )),
//                                               )
//                                             ],
//                                           ),
//                                         ))
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         });
//                   } else {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
