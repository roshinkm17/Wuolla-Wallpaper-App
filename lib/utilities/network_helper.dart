import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  getDataFromUrl() async {
    var response = await http.get(
        'https://api.unsplash.com/photos/?client_id=fSD94zadGgOKuulDq1xLmLGlykZtYDOYBS-1iF-pQV8');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 404;
    }
  }
}
