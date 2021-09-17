import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;

part 'network_utility.freezed.dart';

@freezed
class GooglePlaceException with _$GooglePlaceException {
  const factory GooglePlaceException.unknown() = _Unknown;
}

/// The Network Utility
class NetworkUtility {
  static Future<String> fetchUrl(
    Uri uri, {
    Map<String, String>? headers,
  }) async {
    try {
      final response =
          await http.get(uri, headers: headers).timeout(GooglePlace.timeout);
      if (response.statusCode == 200) {
        return response.body;
      }
      throw GooglePlaceException.unknown();
    } on GooglePlaceException catch (_) {
      rethrow;
    } catch (e) {
      throw GooglePlaceException.unknown();
    }
  }
}
