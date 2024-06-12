import 'package:flutter/material.dart';
import 'package:reconnect/Views/payment.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:reconnect/Views/color.dart';
import 'package:get/get.dart';
import 'package:reconnect/Views/authentications/routes/navigationcontroller.dart';

class PaymobInterface extends StatefulWidget {
  final String paymentToken;

  const PaymobInterface({super.key, required this.paymentToken});

  @override
  _PaymobInterfaceState createState() => _PaymobInterfaceState();
}

class _PaymobInterfaceState extends State<PaymobInterface> {
  @override
  Widget build(BuildContext context) {
    BottomNavigationController bottomnavigationcontroller =
        Get.put(BottomNavigationController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondaryColor,
          title: const Text(
            ' Payment',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.primaryColor),
          ),
        ),
        body: WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(const Color(0x00000000))
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    // Update loading bar.
                  },
                  onPageStarted: (String url) {},
                  onPageFinished: (String url) {},
                  onWebResourceError: (WebResourceError error) {},
                  onNavigationRequest: (NavigationRequest request) {
                    if (request.url.startsWith('https://www.youtube.com/')) {
                      return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
                  },
                ),
              )
              ..loadRequest(Uri.parse(
                'https://accept.paymob.com/api/acceptance/iframes/841120?payment_token=${widget.paymentToken}',
              ))));
  }
}

class Donation extends StatefulWidget {
  const Donation({super.key});

  @override
  State<Donation> createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  final amountController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: const Image(
                image: AssetImage("assets/donation.jpg"),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.secondaryColor),
              ),
              child: const Stack(
                alignment: Alignment.topLeft,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 80),
                    child: Text(
                      'About',
                      style: TextStyle(color: AppColors.textolor, fontSize: 16),
                    ),
                  ),
                  TextField(
                    cursorColor: AppColors.secondaryColor,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(
                          16, 30, 16, 16), // Adjust padding as needed
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              height: 190,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondaryColor),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, bottom: 10, right: 60),
                          child: Container(
                            height: 43,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.secondaryColor),
                            ),
                            child: Container(
                              height: 20,
                              padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
                              child: TextFormField(
                                controller: nameController,
                                cursorColor: AppColors.secondaryColor,
                                decoration: const InputDecoration(
                                  hintText: 'Name',
                                  hintStyle: TextStyle(
                                      color: AppColors.textolor, fontSize: 15),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 2, bottom: 3, left: 10, right: 60),
                          child: Container(
                            height: 43,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.secondaryColor),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 20, 3, 3),
                              child: TextFormField(
                                controller: emailController,
                                cursorColor: AppColors.secondaryColor,
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      color: AppColors.textolor, fontSize: 15),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, bottom: 10, right: 150),
                          child: Container(
                            height: 43,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.secondaryColor),
                            ),
                            child: Container(
                              height: 20,
                              padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
                              child: TextFormField(
                                controller: amountController,
                                cursorColor: AppColors.secondaryColor,
                                decoration: const InputDecoration(
                                  hintText: 'Amount',
                                  hintStyle: TextStyle(
                                      color: AppColors.textolor, fontSize: 15),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _pay();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors
                    .secondaryColor, // Change color to your desired color
                maximumSize:
                    const Size(230, 60), // Set width and height to increase size
              ),
              child: const Text(
                'Donate now',
                style: TextStyle(
                    fontSize: 17,
                    color:
                        AppColors.primaryColor), // Adjust font size as needed
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pay() {
    String amountString = amountController.text;
    int amount = int.tryParse(amountString) ?? 0;
    String name = nameController.text;
    String email = emailController.text;
    if (amount > 0) {
      PaymobManager()
          .getPaymentKey(amount, "EGP", name, email)
          .then((String paymentKey) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymobInterface(paymentToken: paymentKey),
          ),
        );
      });
    } else {
      // Handle invalid amount
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Invalid Amount'),
            content: const Text('Please enter a valid amount.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
