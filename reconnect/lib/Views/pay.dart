// // import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:reconnect/Views/color.dart';

// class Pay extends StatelessWidget {
//   const Pay({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//               top: 90,
//               left: 10,
//               right: 10,
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(right: 5),
//                   child: Expanded(
//                     child: Container(
//                       padding: EdgeInsets.only(right: 10),
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Enter your Visa Number *',
//                           labelStyle: TextStyle(color: AppColors.textolor),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: AppColors.secondaryColor),
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.only(left: 10),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Expiry month *',
//                       labelStyle: TextStyle(color: AppColors.textolor),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: AppColors.secondaryColor),
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.only(right: 10),
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Expiry year *',
//                       labelStyle: TextStyle(color: AppColors.textolor),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: AppColors.secondaryColor),
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.only(
//                 right: 10,
//                 left: 10,
//               ),
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Cardholder Name*',
//                   labelStyle: TextStyle(color: AppColors.textolor),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25)),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: AppColors.secondaryColor),
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/widgets/Button.dart';

class Pay extends StatelessWidget {
  const Pay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 90,
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 5),
                  child: Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter your Visa Number *',
                          labelStyle: TextStyle(color: AppColors.textolor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.secondaryColor),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Expiry month *',
                      labelStyle: TextStyle(color: AppColors.textolor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondaryColor),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Expiry year *',
                      labelStyle: TextStyle(color: AppColors.textolor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondaryColor),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                right: 10,
                left: 10,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Cardholder Name*',
                  labelStyle: TextStyle(color: AppColors.textolor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondaryColor),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 20, bottom: 170),
                  child: Row(
                    children: [
                      Icon(
                        Icons.credit_card,
                        color: AppColors.textolor,
                      ),
                      SizedBox(width: 2),
                      Text(
                        '3 digits on back of your card',
                        style: TextStyle(
                          color: AppColors.textolor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 4, left: 60, bottom: 150),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Security code*',
                      labelStyle: TextStyle(color: AppColors.textolor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.secondaryColor),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          button(button_text: "Pay Now")
        ],
      ),
    );
  }
}
