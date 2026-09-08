enum PasswordRecoveryLinkStatus { ready, unavailable }

class PasswordRecoveryHandoff {
  const PasswordRecoveryHandoff._({required this.status, this.appUri});

  static const String _appScheme = 'curavault';
  static const String _appHost = 'reset-password';
  static const int _maxCredentialLength = 8192;

  final PasswordRecoveryLinkStatus status;
  final Uri? appUri;

  bool get canOpenApp => status == PasswordRecoveryLinkStatus.ready;

  factory PasswordRecoveryHandoff.fromUri(Uri uri) {
    final query = uri.queryParameters;
    final fragment = _parseFragment(uri.fragment);
    if (fragment == null || _containsRecoveryError(query, fragment)) {
      return const PasswordRecoveryHandoff._(
        status: PasswordRecoveryLinkStatus.unavailable,
      );
    }

    final type = query['type'] ?? fragment['type'];
    if (type != null && type != 'recovery') {
      return const PasswordRecoveryHandoff._(
        status: PasswordRecoveryLinkStatus.unavailable,
      );
    }

    final code = query['code'] ?? fragment['code'];
    if (_isSafeCredential(code)) {
      return PasswordRecoveryHandoff._(
        status: PasswordRecoveryLinkStatus.ready,
        appUri: Uri(
          scheme: _appScheme,
          host: _appHost,
          queryParameters: {'code': code!},
        ),
      );
    }

    final accessToken = fragment['access_token'];
    final refreshToken = fragment['refresh_token'];
    final expiresIn = fragment['expires_in'];
    final tokenType = fragment['token_type'];
    final isImplicitRecovery = type == 'recovery' &&
        _isSafeCredential(accessToken) &&
        _isSafeCredential(refreshToken) &&
        _isSafePositiveInteger(expiresIn) &&
        tokenType == 'bearer';

    if (!isImplicitRecovery) {
      return const PasswordRecoveryHandoff._(
        status: PasswordRecoveryLinkStatus.unavailable,
      );
    }

    final appFragment = Uri(
      queryParameters: {
        'access_token': accessToken!,
        'refresh_token': refreshToken!,
        'expires_in': expiresIn!,
        'token_type': tokenType!,
        'type': 'recovery',
      },
    ).query;

    return PasswordRecoveryHandoff._(
      status: PasswordRecoveryLinkStatus.ready,
      appUri: Uri(
        scheme: _appScheme,
        host: _appHost,
        fragment: appFragment,
      ),
    );
  }

  static Map<String, String>? _parseFragment(String rawFragment) {
    if (rawFragment.isEmpty) return const {};
    try {
      return Uri.splitQueryString(rawFragment);
    } on FormatException {
      return null;
    }
  }

  static bool _containsRecoveryError(
    Map<String, String> query,
    Map<String, String> fragment,
  ) {
    const errorKeys = {'error', 'error_code', 'error_description'};
    return errorKeys.any(query.containsKey) ||
        errorKeys.any(fragment.containsKey);
  }

  static bool _isSafeCredential(String? value) {
    if (value == null || value.isEmpty || value.length > _maxCredentialLength) {
      return false;
    }
    return !value.runes.any((unit) => unit < 0x21 || unit == 0x7f);
  }

  static bool _isSafePositiveInteger(String? value) {
    final parsed = int.tryParse(value ?? '');
    return parsed != null && parsed > 0;
  }
}
