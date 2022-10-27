// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:headlessbrowser/config/app_theme.dart';
// import 'package:headlessbrowser/controller/request_controller.dart';\

// class PaymentOption extends StatelessWidget{
//   final RequestController controller = Get.find();
//   final _formKey = GlobalKey<FormState>();
//   // final userController =Get.find<AuthController>();
  
// @override
//   Widget build(BuildContext context) {
//    return Obx(()
//  {
//        return Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.white,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(15),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Payment Option",
//                   style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
                    
//                       Container(
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: [
   
//                          const Text("Accept Payment on Delivery"),
//                          Container(
//               child: FlutterSwitch(
//                 width: 60.0,
//                 height: 35.0,
//                 valueFontSize: 15.0,
//                 toggleSize: 20.0,
//                 value: controller.acceptPayment.value,
//                 borderRadius: 30.0,
//                 padding: 8.0,
//                 showOnOff: false,
//                 onToggle: (val) {
//                   if(userController.appUser.value!.isUpgraded!)
//                   controller.acceptPayment(val);
//                   else
//                   Get.snackbar("Error", "Kindly Upgrade your account to enjoy this features");
//                 },
//               ),
//             )
//                        ],
//                      ),
//                       ),
               
//                       const SizedBox(height: 10),
//                       Visibility(
//                         visible:  controller.acceptPayment.value,
//                         child: TextFormField(
//                           controller: controller.amountController,
//                           decoration: InputDecoration(
//                             labelText: 'Price',
                          
//                             border: appInputOutlineBorder(),
//                             focusedBorder: appInputOutlineBorder(),
   
//                             isDense: true,
//                           ),
//                           keyboardType: TextInputType.number,
//                           validator: (value) {
//                             if (value!.isEmpty)
//                               return 'Please enter price';
                           
//                             return null;
//                           },
//                         ),
//                       ),
                     
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                             onTap: () => controller.bottomSheetIndex--,
//                             child: Text(
//                               "Back",
//                               style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                     color: AppTheme.btnColor,
//                                   ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               if (_formKey.currentState!.validate()) {
//                                 controller.bottomSheetIndex++;
//                               }
//                             },
//                             child: Text(
//                               "Next",
//                               style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                                     color: AppTheme.btnColor,
//                                   ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//      }
//    );

//   }

// }