import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:curavault_website/nav.dart';
import 'package:curavault_website/site/site_header.dart';
import 'package:curavault_website/theme.dart';

void main() {
  Future<void> pumpSiteAt(
    WidgetTester tester,
    String location, {
    Size size = const Size(1280, 800),
  }) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
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

  Future<List<String>> pumpHeader(
    WidgetTester tester, {
    required Size size,
  }) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    final selectedRoutes = <String>[];

    await tester.pumpWidget(
      MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark,
        home: Scaffold(
          body: SiteHeader(
            activePath: AppRoutes.home,
            onLogoTap: () {},
            onNavTap: selectedRoutes.add,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return selectedRoutes;
  }

  testWidgets('/login resolves to the CuraVault Web placeholder',
      (tester) async {
    await pumpSiteAt(
      tester,
      AppRoutes.login,
      size: const Size(390, 844),
    );

    expect(find.text('CuraVault Web'), findsOneWidget);
    expect(
      find.text('CuraVault Web access is being prepared.'),
      findsOneWidget,
    );
    expect(find.byType(TextField), findsNothing);
    expect(find.byType(TextFormField), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('desktop header uses secondary Contact and primary Log in CTAs',
      (tester) async {
    final selectedRoutes = await pumpHeader(
      tester,
      size: const Size(1600, 900),
    );

    expect(
      find.byKey(const ValueKey('site-header-contact')),
      findsOneWidget,
    );
    expect(
      tester.widget(find.byKey(const ValueKey('site-header-contact'))),
      isA<OutlinedButton>(),
    );
    expect(
      tester.widget(find.byKey(const ValueKey('site-header-login'))),
      isA<FilledButton>(),
    );

    await tester.tap(find.byKey(const ValueKey('site-header-login')));
    await tester.pumpAndSettle();

    expect(selectedRoutes, [AppRoutes.login]);
    expect(tester.takeException(), isNull);
  });

  testWidgets('mobile menu exposes Log in without overflow', (tester) async {
    final selectedRoutes = await pumpHeader(
      tester,
      size: const Size(390, 844),
    );

    await tester.tap(find.byTooltip('Menu'));
    await tester.pumpAndSettle();

    final loginItem = find.byKey(const ValueKey('mobile-nav-/login'));
    expect(loginItem, findsOneWidget);
    expect(find.descendant(of: loginItem, matching: find.text('Log in')),
        findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(loginItem);
    await tester.pumpAndSettle();

    expect(selectedRoutes, [AppRoutes.login]);
    expect(tester.takeException(), isNull);
  });

  testWidgets('header renders the canonical CuraVault logo asset',
      (tester) async {
    await pumpHeader(tester, size: const Size(1600, 900));

    final logo = tester.widget<Image>(
      find.byKey(const ValueKey('site-brand-logo')),
    );
    expect(
      (logo.image as AssetImage).assetName,
      'assets/icons/curavault_logo.png',
    );
  });

  test('login placeholder contains no fake auth or external app destinations',
      () {
    final source = File('lib/pages/login_page.dart').readAsStringSync();

    expect(source, isNot(contains('curavault://')));
    expect(source, isNot(contains('apps.apple.com')));
    expect(source, isNot(contains('play.google.com')));
    expect(source, isNot(contains('Supabase')));
    expect(source, isNot(contains('TextField')));
    expect(source, isNot(contains('TextFormField')));
  });

  test('tracked files contain no obsolete generator branding', () {
    const obsoleteBrand = 'dream' 'flow';
    final result = Process.runSync(
      'git',
      ['grep', '-in', obsoleteBrand, '--', '.'],
    );

    expect(result.exitCode, 1, reason: result.stdout.toString());
  });
}
