import 'password_recovery_browser.dart';

PasswordRecoveryBrowser createPlatformPasswordRecoveryBrowser() =>
    const _NoopPasswordRecoveryBrowser();

class _NoopPasswordRecoveryBrowser implements PasswordRecoveryBrowser {
  const _NoopPasswordRecoveryBrowser();

  @override
  void clearRecoveryLocation() {}

  @override
  void openApp(Uri uri) {}
}
