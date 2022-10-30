// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:ekcab/config/app_theme.dart';
// import 'package:ekcab/controller/request_controller.dart';

// class LoadDetails extends StatelessWidget {
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
//               "Load Details",
//               style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//             const SizedBox(height: 20),
//             Column(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Get.dialog(
//                       Dialog(
//                         child: SearchablePopup(
//                           onSelect: (String value) {
//                             controller.selectedLoadType(value);
//                             Get.back();
//                           },
//                           onSearch: (String value) =>
//                               controller.searchLoadType(value),
//                           items: controller.loadTypes,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Obx(() => TextView(
//                         text: controller.selectedLoadType.value,
//                         icon: Icons.keyboard_arrow_down,
//                       )),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           Get.dialog(
//                             Dialog(
//                               child: SearchablePopup(
//                                 onSelect: (String value) {
//                                   controller.selectedContainerType(value);
//                                   Get.back();
//                                 },
//                                 onSearch: (String value) =>
//                                     controller.searchContainerTypes(value),
//                                 items: controller.containerTypes,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           height: 60,
//                           decoration: const BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(10),
//                               topLeft: Radius.circular(10),
//                             ),
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey,
//                                 blurRadius: 2,
//                                 offset: Offset(1, 2),
//                               ),
//                             ],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(20.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Obx(() => Expanded(
//                                       child: Text(
//                                         "${controller.selectedContainerType}",
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .subtitle2,
//                                         maxLines: 1,
//                                       ),
//                                     )),
//                                 const Icon(
//                                   Icons.keyboard_arrow_down,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 60,
//                       width: Get.width / 3,
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           bottomRight: Radius.circular(10),
//                           topRight: Radius.circular(10),
//                         ),
//                         color: AppTheme.containerlightColor,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey,
//                             blurRadius: 2,
//                             offset: Offset(1, 2),
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Center(
//                           child: TextFormField(
//                             controller: controller.quantityController,
//                             decoration: const InputDecoration(
//                               border: InputBorder.none,
//                               hintText: 'Quantity',
//                               fillColor: AppTheme.containerlightColor,
//                               filled: true,
//                             ),
//                             keyboardType: TextInputType.number,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return "Please enter quantity";
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         alignment: Alignment.center,
//                         height: 60,
//                         decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(10),
//                             topLeft: Radius.circular(10),
//                           ),
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey,
//                               blurRadius: 2,
//                               offset: Offset(1, 2),
//                             ),
//                           ],
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                           child: TextFormField(
//                             controller: controller.weightController,
//                             decoration: const InputDecoration(
//                               border: InputBorder.none,
//                               hintText: 'Weight',
//                             ),
//                             keyboardType: TextInputType.number,
//                             validator: (value) {
//                               if (value!.isEmpty) return "Please enter weight";
//                               return null;
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 60,
//                       width: Get.width / 3,
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           bottomRight: Radius.circular(10),
//                           topRight: Radius.circular(10),
//                         ),
//                         color: AppTheme.containerlightColor,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey,
//                             blurRadius: 2,
//                             offset: Offset(1, 2),
//                           ),
//                         ],
//                       ),
//                       child: GestureDetector(
//                         onTap: () {
//                           Get.dialog(
//                             Dialog(
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: controller.weightTypes.length,
//                                 itemBuilder: (context, index) =>
//                                     GestureDetector(
//                                   onTap: () {
//                                     controller.selectedWeightType(
//                                         controller.weightTypes[index]);
//                                     Get.back();
//                                   },
//                                   child: Container(
//                                     alignment: Alignment.centerLeft,
//                                     height: 40,
//                                     padding: const EdgeInsets.only(left: 10),
//                                     decoration: BoxDecoration(
//                                       color: index.isEven
//                                           ? Colors.white
//                                           : AppTheme.containerlightColor,
//                                     ),
//                                     child: Text(controller.weightTypes[index]),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Obx(() => Text(
//                                     "${controller.selectedWeightType}",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .subtitle2!
//                                         .copyWith(),
//                                   )),
//                               const Icon(
//                                 Icons.keyboard_arrow_down,
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 // Text("+ Add another package"),
//                 // SizedBox(
//                 //   height: 20,
//                 // ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
//                     GestureDetector(
//                       onTap: () => controller.bottomSheetIndex++,
//                       child: Text(
//                         "Next",
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

// class SearchablePopup extends StatelessWidget {
//   const SearchablePopup({
//     Key? key,
//     this.items,
//     this.onSelect,
//     this.onSearch,
//   }) : super(key: key);

//   final List<String>? items;
//   final Function(String)? onSelect;
//   final Function(String)? onSearch;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Card(
//             elevation: 5.0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(0),
//             ),
//             child: TextFormField(
//               decoration: const InputDecoration(
//                 hintText: 'Search Type',
//                 border: InputBorder.none,
//                 prefixIcon: Icon(Icons.search),
//               ),
//               onChanged: (value) => onSearch!(value),
//             ),
//           ),
//           Obx(() => ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: items!.length,
//                 itemBuilder: (context, index) => GestureDetector(
//                   onTap: () => onSelect!(items![index]),
//                   child: Container(
//                     alignment: Alignment.centerLeft,
//                     height: 40,
//                     padding: const EdgeInsets.only(left: 10),
//                     decoration: BoxDecoration(
//                       color: index.isEven
//                           ? Colors.white
//                           : AppTheme.containerlightColor,
//                     ),
//                     child: Text(items![index]),
//                   ),
//                 ),
//               ))
//         ],
//       ),
//     );
//   }
// }
