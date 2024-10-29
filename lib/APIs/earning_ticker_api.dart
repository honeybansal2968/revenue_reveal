import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchEarningsData(String ticker) async {
  final url = Uri.parse(
      'https://api.api-ninjas.com/v1/earningscalendar?ticker=$ticker');
  final response = await http.get(
    url,
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data;
  } else {
    print('Request failed with status: ${response.statusCode}');
    return [];
  }
}

Future<String> fetchEarningsTranscript(
    String ticker, int year, int quarter) async {
  final url = Uri.parse(
      'https://api.api-ninjas.com/v1/earningstranscript?ticker=$ticker&year=$year&quarter=$quarter');
  final response = await http.get(
    url,
    headers: {
      'X-Api-Key': 'YOUR_API_KEY',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("Transcript for $ticker Q$quarter $year: $data");
    return data["transcript"];
  } else {
    print(
        'Request failed with status: ${response.statusCode} for $ticker Q$quarter $year');
    return "";
  }
}
