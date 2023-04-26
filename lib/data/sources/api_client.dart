import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:obs_foundation/obs_foundation.dart';
import 'package:remind_me/core/config/config.dart';

/// A provider that fetches data from an API.
@immutable
class AppApiClient extends ApiClient {
  /// Creates a new [AppApiClient].
  AppApiClient({
    required Config config,
    http.Client? client,
  })  : _config = config,
        super(
          // You can use innerClient here.
          innerClient: client ?? http.Client(),
        );

  factory AppApiClient.update(
    Config config,
    AppApiClient? old,
  ) {
    if (old == null || config != old._config) {
      return AppApiClient(
        config: config,
      );
    } else {
      return old;
    }
  }

  /// The configuration to use when calling the API.
  final Config _config;

  @override
  String get baseUrl => _config.authority;
}

List<T> _getListFromObject<T>(
  Object object,
  T Function(dynamic) deserializer,
) {
  return (object as List<dynamic>).map(deserializer).toList();
}
