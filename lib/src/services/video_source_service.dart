import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service for fetching video URLs from Instagram or falling back to defaults.
class VideoSourceService {
  final String tokenApiUrl;
  final List<String> fallbackUrls;
  final http.Client _client;

  VideoSourceService({
    required this.tokenApiUrl,
    required this.fallbackUrls,
    http.Client? client,
  }) : _client = client ?? http.Client();

  /// Fetches the instagram token and then retrieves the video media URLs.
  /// If [tokenApiUrl] is empty or fails, returns [fallbackUrls].
  Future<List<String>> fetchVideos() async {
    if (tokenApiUrl.isEmpty) {
      return List<String>.from(fallbackUrls);
    }

    try {
      final response = await _client.get(Uri.parse(tokenApiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true &&
            data['data'] != null &&
            (data['data'] as List).isNotEmpty) {
          final token = data['data'][0]['api_key'] as String?;
          if (token != null) {
            return await _fetchInstagramVideoUrls(token);
          }
        }
      }
      return List<String>.from(fallbackUrls);
    } catch (_) {
      return List<String>.from(fallbackUrls);
    }
  }

  Future<List<String>> _fetchInstagramVideoUrls(String token) async {
    try {
      final response = await _client.get(
        Uri.parse(
          'https://graph.instagram.com/me/media'
          '?fields=media_url,media_type'
          '&access_token=$token'
          '&limit=5',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null && (data['data'] as List).isNotEmpty) {
          final videoUrls = <String>[
            for (final item in data['data'] as List)
              if (item['media_type'] == 'VIDEO' && item['media_url'] != null)
                item['media_url'] as String,
          ];

          if (videoUrls.isNotEmpty) {
            // Replicate the original behavior of repeating the first video if only 1 is found
            if (videoUrls.length == 1) videoUrls.add(videoUrls[0]);
            return videoUrls;
          }
        }
      }
      return List<String>.from(fallbackUrls);
    } catch (_) {
      return List<String>.from(fallbackUrls);
    }
  }
}
