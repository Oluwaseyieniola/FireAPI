import 'dart:convert';
import 'package:http/http.dart' as http;

const token =
    'BQBs-wc84DdxCCTp3GR2SCMJOhS6fA_1huz6qW2SyIxLAnD0Hb-7TzgA0091B8BarCLhLhZbeoHAiGs0AeL1MvMCWZNylkNW1AMbSM1yvGgXDruJb2bKURdThCGfASk_CBsLffDd3pBXlHZJIm9jiuxschKrt_BJIa4XWJfP4RX6-Gdn9Mzjk-NrmoQr2L6HZvRgLsacw8J5gloPEPEFvkJIJAJ_jZUYf1I5P1fWn27Id5X0aBeZJDAKum1DY310CZO4UVK_qSWWcDOEBDgLGBiKJvQDJwCSTlDXcXOWi-jqqOSRyYpoitYbc1JY4nWsk39GV7mQSN2O5-lr3VRGzcyuQwre8J5r0A-VeHfFHvtftOk';

Future<Map<String, dynamic>> fetchWebApi(String endpoint, String method,
    [Map<String, dynamic>? body]) async {
  try {
    final response = await http.post(
      Uri.parse('https://api.spotify.com/$endpoint'),
      headers: {'Authorization': 'Bearer $token'},
      body: jsonEncode(body ?? {}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch data from API');
    }
  } catch (e) {
    throw Exception('Failed to connect to API server');
  }
}

Future<List<dynamic>> getTopTracks() async {
  // Endpoint reference : https://developer.spotify.com/documentation/web-api/reference/get-users-top-artists-and-tracks
  try {
    final response = await fetchWebApi(
        'v1/me/top/tracks?time_range=short_term&limit=5', 'GET');

    return response['items'];
  } catch (e) {
    print(e);
    return [];
  }
}

void main() async {
  final topTracks = await getTopTracks();
  if (topTracks.isEmpty) {
    print('Failed to get top tracks from API');
  } else {
    print(topTracks
        .map((e) =>
            '${e['name']} by ${e['artists'].map((artist) => artist['name']).join(', ')}')
        .toList());
  }
}
