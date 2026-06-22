import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:curavault_website/pages/account_deletion_page.dart';
import 'package:curavault_website/pages/contact_page.dart';
import 'package:curavault_website/pages/data_request_page.dart';
import 'package:curavault_website/pages/faq_page.dart';
import 'package:curavault_website/pages/features_page.dart';
import 'package:curavault_website/pages/home_page.dart';
import 'package:curavault_website/pages/how_it_works_page.dart';
import 'package:curavault_website/pages/pricing_page.dart';
import 'package:curavault_website/pages/privacy_policy_page.dart';
import 'package:curavault_website/pages/security_privacy_page.dart';
import 'package:curavault_website/pages/support_page.dart';
import 'package:curavault_website/pages/terms_page.dart';
import 'package:curavault_website/site/site_shell.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      ShellRoute(
        builder: (context, state, child) => SiteShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            pageBuilder: (context, state) => const NoTransitionPage(child: HomePage()),
          ),
          GoRoute(
            path: AppRoutes.features,
            name: 'features',
            pageBuilder: (context, state) => const NoTransitionPage(child: FeaturesPage()),
          ),
          GoRoute(
            path: AppRoutes.howItWorks,
            name: 'howItWorks',
            pageBuilder: (context, state) => const NoTransitionPage(child: HowItWorksPage()),
          ),
          GoRoute(
            path: AppRoutes.pricing,
            name: 'pricing',
            pageBuilder: (context, state) => const NoTransitionPage(child: PricingPage()),
          ),
          GoRoute(
            path: AppRoutes.security,
            name: 'security',
            pageBuilder: (context, state) => const NoTransitionPage(child: SecurityPrivacyPage()),
          ),
          GoRoute(
            path: AppRoutes.faq,
            name: 'faq',
            pageBuilder: (context, state) => const NoTransitionPage(child: FaqPage()),
          ),
          GoRoute(
            path: AppRoutes.support,
            name: 'support',
            pageBuilder: (context, state) => const NoTransitionPage(child: SupportPage()),
          ),
          GoRoute(
            path: AppRoutes.contact,
            name: 'contact',
            pageBuilder: (context, state) => const NoTransitionPage(child: ContactPage()),
          ),
          GoRoute(
            path: AppRoutes.privacy,
            name: 'privacy',
            pageBuilder: (context, state) => const NoTransitionPage(child: PrivacyPolicyPage()),
          ),
          GoRoute(
            path: AppRoutes.deleteAccount,
            name: 'deleteAccount',
            pageBuilder: (context, state) => const NoTransitionPage(child: AccountDeletionPage()),
          ),
          GoRoute(
            path: AppRoutes.terms,
            name: 'terms',
            pageBuilder: (context, state) => const NoTransitionPage(child: TermsPage()),
          ),
          GoRoute(
            path: AppRoutes.dataRequest,
            name: 'dataRequest',
            pageBuilder: (context, state) => const NoTransitionPage(child: DataRequestPage()),
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Page not found', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(
                    'The page you requested does not exist.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => context.go(AppRoutes.home),
                    child: const Text('Go to Home'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class AppRoutes {
  static const String home = '/';
  static const String features = '/features';
  static const String howItWorks = '/how-it-works';
  static const String pricing = '/pricing';
  static const String security = '/security';
  static const String faq = '/faq';
  static const String support = '/support';
  static const String contact = '/contact';
  static const String privacy = '/privacy';
  static const String deleteAccount = '/delete-account';
  static const String terms = '/terms';
  static const String dataRequest = '/data-request';
}
