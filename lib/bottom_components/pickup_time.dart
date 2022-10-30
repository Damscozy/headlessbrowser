// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ekcab/config/app_theme.dart';
// import 'package:ekcab/controller/request_controller.dart';

// class PickupTime extends StatelessWidget {
//   final RequestController controller = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Pickup Time",
//               style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Column(
//               children: [
//                 MyRaisedButton(
//                   onPress: () {
//                     Get.to(() => PreviewRequest());
//                   },
//                   text: "Now",
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 // MyRaisedButton(
//                 //   onPress: () {},
//                 //   text: "Schedule Pick-up",
//                 //   textStyle: TextStyle(
//                 //     color: AppTheme.btnColor,
//                 //   ),
//                 //   color: Colors.white,
//                 // ),
//                 // SizedBox(
//                 //   height: 10,
//                 // ),
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () => controller.bottomSheetIndex--,
//                       child: Text(
//                         "Back",
//                         style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                               color: AppTheme.btnColor,
//                             ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
