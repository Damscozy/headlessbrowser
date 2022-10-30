// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ekcab/controller/request_controller.dart';

// class DeliveryDetails extends StatelessWidget {
//   final RequestController controller = Get.find();
//   final _formKey = GlobalKey<FormState>();
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
//               "Delivery Details",
//               style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextFormField(
//                     controller: controller.reciverNameController,
//                     decoration: InputDecoration(
//                       labelText: 'Reciver Name',
//                       border: appInputOutlineBorder(),
//                       focusedBorder: appInputOutlineBorder(),
//                       isDense: true,
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) return 'Please enter reciver name';
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextFormField(
//                           controller: controller.reciverContactController,
//                           decoration: InputDecoration(
//                             labelText: 'Phone',
//                             prefixIcon: CountryCodePicker(
//                               showFlag: false,
//                               onChanged: (value) =>
//                                   controller.countryCode(value.dialCode),
//                             ),
//                             border: appInputOutlineBorder(),
//                             focusedBorder: appInputOutlineBorder(),
//                             isDense: true,
//                           ),
//                           keyboardType: TextInputType.phone,
//                           validator: (value) {
//                             if (value!.isEmpty)
//                               return 'Please enter phone';
//                             else if (value.length < 8)
//                               return 'Please enter valid phone';
//                             return null;
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: controller.noteController,
//                     decoration: InputDecoration(
//                       labelText: 'Notes',
//                       border: appInputOutlineBorder(),
//                       focusedBorder: appInputOutlineBorder(),
//                       isDense: true,
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) return 'Please enter note';
//                       return null;
//                     },
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                         onTap: () => controller.bottomSheetIndex--,
//                         child: Text(
//                           "Back",
//                           style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                 color: AppTheme.btnColor,
//                               ),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           if (_formKey.currentState!.validate()) {
//                             controller.bottomSheetIndex++;
//                           }
//                         },
//                         child: Text(
//                           "Next",
//                           style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                 color: AppTheme.btnColor,
//                               ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
