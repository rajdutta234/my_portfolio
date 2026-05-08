import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../api_routes.dart';
import '../../models/contact_model.dart';

class ContactServices {
  ContactServices._internal();
  static final ContactServices _instance = ContactServices._internal();
  factory ContactServices() => _instance;

  late Dio _dio;
  bool _initialized = false;

  Dio get dio {
    if (!_initialized) {
      initializeDio();
    }
    return _dio;
  }

  void initializeDio({String? authToken}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: apiBaseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (authToken != null && authToken.trim().isNotEmpty)
            'Authorization': 'Bearer $authToken',
        },
      ),
    );

    _dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: false,
        responseBody: true,
        compact: true,
      ),
    );
    _initialized = true;
  }

  Future<Map<String, dynamic>> sendContactMessage(ContactModel contact) async {
    try {
      final response = await dio.post(
        sendContactEndpoint,
        data: contact.toJson(),
      );
      
      return _asMap(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? "Failed to send message");
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }

  // Helper methods from the requested pattern
  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return <String, dynamic>{};
  }

  // ignore: unused_element
  List<dynamic> _asList(dynamic value) => value is List ? value : <dynamic>[];

  // ignore: unused_element
  Map<String, dynamic> _unwrapData(dynamic payload) {
    if (payload is Map<String, dynamic>) {
      if (payload['data'] is Map<String, dynamic>) {
        return payload['data'] as Map<String, dynamic>;
      }
      return payload;
    }
    if (payload is Map) return Map<String, dynamic>.from(payload);
    return <String, dynamic>{};
  }
}
