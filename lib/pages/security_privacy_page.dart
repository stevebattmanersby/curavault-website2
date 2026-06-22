import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:curavault_website/nav.dart';
import 'package:curavault_website/site/marketing_page.dart';
import 'package:curavault_website/site/widgets.dart';
import 'package:curavault_website/theme.dart';

class SecurityPrivacyPage extends StatelessWidget {
  const SecurityPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return MarketingPage(
      title: 'Security & Privacy',
      lead:
          'We aim to be privacy-first and designed with security in mind. Specific security, legal, and compliance statements should be reviewed by qualified professionals.',
      children: [
        LayoutBuilder(
          builder: (context, c) {
            final cols = c.maxWidth >= 980 ? 2 : 1;
            return _SecurityGrid(
              columns: cols,
              children: const [
                FeatureTile(
                  icon: Icons.shield_outlined,
                  title: 'Security-minded approach',
                  body: 'Threat modeling, least-privilege access, and careful handling of data paths are part of the intended design.',
                ),
                FeatureTile(
                  icon: Icons.visibility_off_outlined,
                  title: 'Privacy-first product decisions',
                  body: 'We prioritize reducing data exposure and avoiding unnecessary collection wherever possible.',
                ),
                FeatureTile(
                  icon: Icons.manage_accounts_outlined,
                  title: 'User control',
                  body: 'Clear controls for what you store, what you export, and what you choose to share.',
                ),
                FeatureTile(
                  icon: Icons.policy_outlined,
                  title: 'Policy clarity',
                  body: 'Policies should be written in plain language and updated as the product evolves.',
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 18),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Avoiding unverified claims', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(
                'This website intentionally avoids claims like “HIPAA compliant” unless verified and reviewed. We use careful wording such as “privacy-first” and “designed with security in mind”.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurface.withValues(alpha: 0.72), height: 1.55),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  OutlinedButton(
                    onPressed: () => context.go(AppRoutes.privacy),
                    child: const Text('Privacy Policy'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.go(AppRoutes.dataRequest),
                    child: const Text('Data requests'),
                  ),
                  FilledButton(
                    onPressed: () => context.go(AppRoutes.contact),
                    child: const Text('Contact'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SecurityGrid extends StatelessWidget {
  const _SecurityGrid({required this.columns, required this.children});
  final int columns;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final gap = 14.0;
    if (columns <= 1) {
      return Column(
        children: [
          for (final child in children) ...[
            child,
            const SizedBox(height: 14),
          ],
        ],
      );
    }
    return LayoutBuilder(
      builder: (context, c) {
        final w = (c.maxWidth - gap) / 2;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final child in children) SizedBox(width: w, child: child),
          ],
        );
      },
    );
  }
}
