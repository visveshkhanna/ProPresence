import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<String> processImage(String image) async {
  var client = http.Client();
  final request =
      http.MultipartRequest('POST', Uri.parse("http://127.0.0.1/upload/"));
  final filePart = await http.MultipartFile.fromPath('file', image);
  request.files.add(filePart);
  final response = await request.send();

  if (response.statusCode == 200) {
    final responseData = await response.stream.bytesToString();
    final jsonResponse = json.decode(responseData);
    // print('Response: $jsonResponse');
    return jsonResponse["name"];
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
  return "";
}
