import 'package:flutter/material.dart';

import 'package:curavault_website/site/marketing_page.dart';
import 'package:curavault_website/theme.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return MarketingPage(
      title: 'Privacy Policy (Draft)',
      lead:
          'This is a placeholder privacy policy for the static marketing site. It must be reviewed and updated before production use.',
      children: [
        SectionCard(
          child: _LegalBody(
            paragraphs: [
              'CuraVault is a personal health record and medical document management platform intended for individuals, families, and carers.',
              'This website is currently a static marketing site. We do not collect newsletter sign-ups, process payments, or provide user accounts here.',
              'If you contact us using the placeholder form, treat it as non-functional and avoid including highly sensitive information.',
              'Future versions of CuraVault may collect personal data required to provide the service. Data practices will be documented clearly here.',
              'For privacy rights requests, please use the “Data Requests / Privacy Rights” page.',
            ],
          ),
        ),
        const SizedBox(height: 14),
        SubtleTintPanel(
          child: Text(
            'Disclaimer: This draft is not legal advice and is subject to review.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.75), height: 1.5),
          ),
        ),
      ],
    );
  }
}

class _LegalBody extends StatelessWidget {
  const _LegalBody({required this.paragraphs});
  final List<String> paragraphs;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final p in paragraphs) ...[
          Text(p, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurface.withValues(alpha: 0.78), height: 1.65)),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}
