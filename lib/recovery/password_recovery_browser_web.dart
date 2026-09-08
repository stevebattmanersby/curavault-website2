import 'package:web/web.dart' as web;

import 'password_recovery_browser.dart';

PasswordRecoveryBrowser createPlatformPasswordRecoveryBrowser() =>
    const _WebPasswordRecoveryBrowser();

class _WebPasswordRecoveryBrowser implements PasswordRecoveryBrowser {
  const _WebPasswordRecoveryBrowser();

  @override
  void clearRecoveryLocation() {
    web.window.history.replaceState(null, '', '/reset-password');
  }

  @override
  void openApp(Uri uri) {
    web.window.location.assign(uri.toString());
  }
}
