import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:curavault_website/nav.dart';
import 'package:curavault_website/pages/password_reset_landing_page.dart';
import 'package:curavault_website/recovery/password_recovery_browser.dart';
import 'package:curavault_website/theme.dart';

class _FakePasswordRecoveryBrowser implements PasswordRecoveryBrowser {
  int clearCalls = 0;
  Uri? openedUri;

  @override
  void clearRecoveryLocation() => clearCalls += 1;

  @override
  void openApp(Uri uri) => openedUri = uri;
}

void main() {
  Future<void> pumpSiteAt(WidgetTester tester, [String? location]) async {
    final router = AppRouter.createRouter(initialLocation: location);
    addTearDown(router.dispose);
    await tester.pumpWidget(
      MaterialApp.router(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark,
        routerConfig: router,
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('/reset-password resolves without rendering recovery parameters',
      (tester) async {
    const recoveryCode = 'private-recovery-code';
    tester.binding.platformDispatcher.defaultRouteNameTestValue =
        '${AppRoutes.resetPassword}?code=$recoveryCode';
    addTearDown(
      tester.binding.platformDispatcher.clearDefaultRouteNameTestValue,
    );
    await pumpSiteAt(tester);

    expect(find.text('Continue in CuraVault'), findsOneWidget);
    expect(find.textContaining(recoveryCode), findsNothing);
  });

  testWidgets('recovery parameters are not logged', (tester) async {
    const recoveryCode = 'never-log-this-recovery-code';
    final messages = <String>[];
    final previousDebugPrint = debugPrint;
    debugPrint = (message, {wrapWidth}) {
      if (message != null) messages.add(message);
    };
    try {
      await tester.pumpWidget(
        MaterialApp(
          home: PasswordResetLandingPage(
            recoveryUri: Uri(
              scheme: 'https',
              host: 'www.curavault.io',
              path: '/reset-password',
              queryParameters: {'code': recoveryCode},
            ),
          ),
        ),
      );
    } finally {
      debugPrint = previousDebugPrint;
    }

    expect(messages.join('\n'), isNot(contains(recoveryCode)));
  });

  testWidgets('valid PKCE recovery hands only the code to the app',
      (tester) async {
    final browser = _FakePasswordRecoveryBrowser();
    const recoveryCode = 'one-time-pkce-code';

    await tester.pumpWidget(
      MaterialApp(
        home: PasswordResetLandingPage(
          recoveryUri: Uri.https(
            'www.curavault.io',
            '/reset-password',
            {
              'code': recoveryCode,
              'next': 'https://untrusted.example',
            },
          ),
          browser: browser,
        ),
      ),
    );

    expect(browser.clearCalls, 1);
    await tester.tap(
      find.byKey(const ValueKey('password-recovery-open-app')),
    );
    await tester.pump();

    expect(browser.openedUri?.scheme, 'curavault');
    expect(browser.openedUri?.host, 'reset-password');
    expect(browser.openedUri?.queryParameters, {'code': recoveryCode});
    expect(browser.openedUri.toString(), isNot(contains('untrusted.example')));
  });

  testWidgets('missing and malformed recovery information fail safely',
      (tester) async {
    for (final uri in [
      Uri.https('www.curavault.io', '/reset-password'),
      Uri.parse(
        'https://www.curavault.io/reset-password?error=access_denied&error_description=private-detail',
      ),
      Uri.parse(
        'https://www.curavault.io/reset-password#type=recovery&access_token=incomplete',
      ),
    ]) {
      await tester.pumpWidget(
        MaterialApp(home: PasswordResetLandingPage(recoveryUri: uri)),
      );
      await tester.pump();

      expect(find.text('Reset link unavailable'), findsOneWidget);
      expect(find.textContaining('private-detail'), findsNothing);
      expect(find.byKey(const ValueKey('password-recovery-open-app')),
          findsNothing);
    }
  });

  testWidgets('legacy implicit recovery forwards only required session fields',
      (tester) async {
    final browser = _FakePasswordRecoveryBrowser();
    final uri = Uri.parse(
      'https://www.curavault.io/reset-password#access_token=access-value&refresh_token=refresh-value&expires_in=3600&token_type=bearer&type=recovery&provider_token=discard-me',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: PasswordResetLandingPage(
          recoveryUri: uri,
          browser: browser,
        ),
      ),
    );
    await tester.tap(
      find.byKey(const ValueKey('password-recovery-open-app')),
    );

    final handoff = Uri.splitQueryString(browser.openedUri!.fragment);
    expect(handoff, {
      'access_token': 'access-value',
      'refresh_token': 'refresh-value',
      'expires_in': '3600',
      'token_type': 'bearer',
      'type': 'recovery',
    });
    expect(browser.openedUri.toString(), isNot(contains('discard-me')));
  });

  testWidgets('existing billing and home routes remain intact', (tester) async {
    await pumpSiteAt(tester, AppRoutes.billingSuccess);
    expect(find.text('Subscription activated'), findsOneWidget);

    await pumpSiteAt(tester, AppRoutes.billingCancel);
    expect(find.text('No changes were made'), findsOneWidget);

    await pumpSiteAt(tester, AppRoutes.home);
    expect(find.text('CuraVault'), findsWidgets);
  });

  test('recovery implementation has no logging or browser persistence', () {
    final source = [
      'lib/pages/password_reset_landing_page.dart',
      'lib/recovery/password_recovery_browser.dart',
      'lib/recovery/password_recovery_browser_stub.dart',
      'lib/recovery/password_recovery_browser_web.dart',
      'lib/recovery/password_recovery_handoff.dart',
    ].map((path) => File(path).readAsStringSync()).join('\n');

    expect(source, isNot(contains('debugPrint')));
    expect(source, isNot(contains('print(')));
    expect(source, isNot(contains('localStorage')));
    expect(source, isNot(contains('sessionStorage')));
    expect(source, isNot(contains('analytics')));
  });

  test('Netlify recovery route disables storage and referrers', () {
    final headers = File('web/_headers').readAsStringSync();

    expect(headers, contains('/reset-password'));
    expect(headers, contains('Cache-Control: no-store'));
    expect(headers, contains('Referrer-Policy: no-referrer'));
    expect(File('web/_redirects').readAsStringSync(), contains('/index.html'));
    expect(
      File('lib/main.dart').readAsStringSync(),
      contains('usePathUrlStrategy();'),
    );
  });
}
