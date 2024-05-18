

import 'package:flutter/material.dart';
import 'package:reconnect/Views/color.dart';
import 'package:reconnect/Views/widgets/Button.dart';
//import 'package:url_launcher/url_launcher.dart';

class Pay extends StatefulWidget {
  const Pay({super.key});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  final _amountcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Implement your widget build method here
    return Scaffold(body: Text("hi"));
  }

  /*void _continueToPay() {
    // Call your payment function here
    Paymemt()
      .getPaymentKey(int.parse(widget.totalprice))
      .then((paymentKey) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Visa(
              paymentToken: paymentKey,
              totalprice: widget.totalprice,
            ),
          ),
        );
      });
  }
}
*/
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.primaryColor,
    appBar: AppBar(
      backgroundColor: AppColors.secondaryColor,
      title: const Text(
        'Reconnect',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: AppColors.primaryColor),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.keyboard_arrow_left,
            color: AppColors.primaryColor),
      ),
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 100,
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 0),
                  child: Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 0),
                      child: TextFormField(
                        cursorColor: AppColors.secondaryColor,
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
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    cursorColor: AppColors.secondaryColor,
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
                    cursorColor: AppColors.secondaryColor,
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
            height: 30,
          ),
          Container(
            padding: EdgeInsets.only(
              right: 10,
              left: 10,
            ),
            child: TextFormField(
              cursorColor: AppColors.secondaryColor,
              decoration: InputDecoration(
                labelText: 'Cardholder Name *',
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
          Container(
            padding: EdgeInsets.only(
              top: 30,
              right: 10,
              left: 10,
            ),
            child: TextFormField(
              cursorColor: AppColors.secondaryColor,
              decoration: InputDecoration(
                labelText: 'Security code *',
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
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.credit_card,
                color: AppColors.textolor,
              ),
              SizedBox(width: 5),
              Text(
                '3 digits on back of your card',
                style: TextStyle(color: AppColors.textolor, fontSize: 10),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          button(button_text: "Pay Now")
        ],
      ),
    ),
  );
}


