import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class EmojiRemoteDataSource {
  Future<List<String>> fetchEmojis(int count, String categoryName);
}

class EmojiRemoteDataSourceImpl implements EmojiRemoteDataSource {
  final http.Client client;

  EmojiRemoteDataSourceImpl({required this.client});

  @override
  Future<List<String>> fetchEmojis(int count, String categoryName) async {
    final response = await client.get(
      Uri.parse('https://emojihub.yurace.pro/api/all/category/$categoryName'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> emojis = json.decode(response.body);
      return emojis
          .take(count)
          .map((e) => _parseUnicodeEmoji(e['unicode'] as List<dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load emojis');
    }
  }

  String _parseUnicodeEmoji(List<dynamic> unicodeList) {
    final unicodeString = unicodeList.first as String;
    
    final hexCode = unicodeString.replaceAll('U+', '');
    final codePoint = int.parse(hexCode, radix: 16);
    return String.fromCharCode(codePoint);
  }
}