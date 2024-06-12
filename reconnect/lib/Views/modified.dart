import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'authentications/routes/navigationcontroller.dart';

class SecondPage extends StatelessWidget {
  final String? modifiedImageUrl;
  final File? imageFile;

  const SecondPage({super.key, this.modifiedImageUrl, this.imageFile});

  Future<void> _saveImageToDevice(BuildContext context) async {
    try {
      print('Saving image...');

      final http.Response response = await http.get(Uri.parse(modifiedImageUrl!));
      if (response.statusCode == 200) {
        final Uint8List imageData = response.bodyBytes;

        final result = await ImageGallerySaver.saveImage(imageData);

        if (result['isSuccess']) {
          print('Image saved successfully.');
          final directory = await getExternalStorageDirectory();
          final String path = '${directory!.path}/new_application';
          final directoryExists = await Directory(path).exists();
          if (!directoryExists) {
            await Directory(path).create(recursive: true);
          }

          // Generate a unique filename using the current timestamp
          final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
          final File newImage = File('$path/image_$timestamp.jpg');
          await newImage.writeAsBytes(imageData);
          print('Image saved to: $path/image_$timestamp.jpg');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.transparent,
              content: Text('Image saved to: $path/image_$timestamp.jpg',style: const TextStyle(color: Colors.white)),
            ),
          );
        } else {
          print('Failed to save image: $result');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.transparent,
              content: Text('Failed to save image',style: TextStyle(color: Colors.white),),
            ),
          );
        }
      } else {
        print('Failed to download image: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.transparent,
            content: Text('Failed to download image',style: TextStyle(color: Colors.white)),
          ),
        );
      }
    } catch (e) {
      print('Error saving image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.transparent,
          content: Text('Error saving image',style: TextStyle(color: Colors.white)),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
     BottomNavigationController bottomnavigationcontroller =
      Get.put(BottomNavigationController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modified Image'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
           Get.back();
            
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: const Color(0xFF4A563E),
                child: Center(
                  child: modifiedImageUrl != null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 300,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              modifiedImageUrl!,
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                          : null,
                                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              bottomnavigationcontroller.change(0);
                              Get.close(2);
                              // Perform any action when the button is pressed
                            },
                            icon: const Icon(Icons.restart_alt_sharp,color: Colors.white,),
                          ),
                          const SizedBox(width: 15,),
                          IconButton(
                            onPressed: () async {
                              await _saveImageToDevice(context);
                            },
                            icon: const Icon(Icons.download, color: Colors.white),
                          ),
                          const SizedBox(width: 15,),
                          IconButton(
                            onPressed: () {
                            bottomnavigationcontroller.change(1);
                            Get.close(2);
                              // Perform any action when the button is pressed
                            },
                            icon: const Icon(Icons.share,color: Colors.white,),
                          ),
                        ],
                      ),
                    ],
                  )
                      : const Text(
                    'Modified image will appear here ...',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}