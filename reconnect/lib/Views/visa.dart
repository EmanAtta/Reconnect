/*
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class Visa extends StatefulWidget {
  final String paymentToken;

  const Visa({Key? key, required this.paymentToken, required totalprice}) : super(key: key);

  @override
  State<Visa> createState() => _VisaState();
}

class _VisaState extends State<Visa> {
  InAppWebViewController? _webviewController;

@override
@override
  void initState() {
    super.initState();
  }

  void startPayment() {
    _webviewController?.loadUrl(
      urlRequest: URLRequest(
        url:Uri.parse(
          'https://accept.paymob.com/api/acceptance/iframes/841119?payment_token=${widget.paymentToken}',
        ),
      ),
    );
  }

  Future<void> handlePayment(String paymentToken) async {
    try {
      final response = await http.post(
        Uri.parse('https://your-payment-api.com/process-payment'),
        // Additional parameters if needed
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment successful')),
        );
        // Navigate to payment success screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred during payment')),
      );
      print('Error during payment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visa'),
      ),
      body: InAppWebView(
        // ignore: deprecated_member_use
        initialOptions: InAppWebViewGroupOptions(
          // ignore: deprecated_member_use
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
          ),
        ),
        onWebViewCreated: (controller) {
          _webviewController = controller;
          startPayment(widget.paymentToken);
        },
        onLoadStop: (controller, url) {
          if (url != null &&
              url.queryParameters.containsKey('success') &&
              url.queryParameters['success'] == 'true') {
            print("payment success");
            // Handle payment success
          } else if (url != null &&
              url.queryParameters.containsKey('success') &&
              url.queryParameters['success'] == 'false') {
            print("payment failed");
            // Handle payment failure
          }
          print('stop $url');
        },
      ),
    );
  }
}