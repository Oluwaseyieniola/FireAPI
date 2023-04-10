import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotless_api/spotify/models/GetTop.dart';
import 'package:http/http.dart' as http;

class Spotifire extends StatefulWidget {
  const Spotifire({super.key});

  @override
  State<Spotifire> createState() => _SpotifireState();
}

class _SpotifireState extends State<Spotifire> {
  List<Map<String, dynamic>> _topTracks = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTopTracks();
  }

  Future<void> _getTopTracks() async {
    final response = await http.get(
        Uri.parse(
            'https://api.spotify.com/v1/me/top/tracks?time_range=short_term&limit=5'),
        headers: {'Authorization': 'Bearer $token'});
    final responseBody = jsonDecode(response.body);
    setState(() {
      _topTracks = List<Map<String, dynamic>>.from(responseBody['items']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seyi\'s top tracks')),
      body: ListView.builder(
          itemCount: _topTracks.length,
          itemBuilder: ((context, index) {
            final track = _topTracks[index];
            return ListTile(
                title: Text(track['name']),
                subtitle: Text(track['artists']
                    .map((artist) => artist['name'])
                    .join(', ')));
          })),
    );
  }
}
