import 'base_localization.dart';

class EnglishLocalization extends AppLocalization {
  EnglishLocalization() : super(code: 'en', name: 'English');

  @override
  String get noInternetConnection => 'No Internet Connection';

  @override
  String get cancelApiRequestError => 'Request to API server was cancelled';

  @override
  String get connectionTimeoutApiRequestError =>
      'Connection timeout with API server';

  @override
  String get invalidStatusApiRequestError => 'Received invalid status code %s';

  @override
  String get somethingWentWrong => 'Something went wrong...';

  @override
  String get receiveTimeoutApiRequestError =>
      'Receive timeout in connection with API server';

  @override
  String get retry => 'Re-Try';

  @override
  String get ok => 'Ok';

  @override
  String get connectionError => 'Connection Error';
}
