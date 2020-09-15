import 'package:http/http.dart' as http;

class NetworkHelper {
  getDataFromUrl(var page, var queryTerm) async {
    var url =
        'https://api.unsplash.com/search/photos/?client_id=fSD94zadGgOKuulDq1xLmLGlykZtYDOYBS-1iF'
        '-pQV8'
        '&per_page=30&page=$page&query=$queryTerm';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 404;
    }
  }
}
