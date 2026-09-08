import 'password_recovery_browser_stub.dart'
    if (dart.library.html) 'password_recovery_browser_web.dart';

abstract interface class PasswordRecoveryBrowser {
  void clearRecoveryLocation();

  void openApp(Uri uri);
}

PasswordRecoveryBrowser createPasswordRecoveryBrowser() =>
    createPlatformPasswordRecoveryBrowser();
