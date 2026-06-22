import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:curavault_website/site/marketing_page.dart';
import 'package:curavault_website/theme.dart';

class AccountDeletionPage extends StatelessWidget {
  const AccountDeletionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return MarketingPage(
      title: 'Account Deletion (Draft)',
      lead:
          'This page describes the intended account deletion process. The product and backend are not connected yet — this is a static placeholder.',
      children: [
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Intended process', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              const _StepRow(1, 'Submit a deletion request via Contact or Data Requests.'),
              const _StepRow(2, 'We verify the requester is the account owner.'),
              const _StepRow(3, 'We delete account data according to our policy (timeline TBD).'),
              const _StepRow(4, 'We confirm completion. Some limited data may be retained if required by law.'),
              const SizedBox(height: 12),
              Text(
                'Disclaimer: Details and timelines are subject to legal review and the final technical implementation.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.72), height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SubtleTintPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Where to request deletion', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              Text('Use the following pages:', style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.55)),
              const SizedBox(height: 10),
              _LinkRow(icon: Icons.mail_outline, label: 'Contact', route: '/contact'),
              const SizedBox(height: 10),
              _LinkRow(icon: Icons.policy_outlined, label: 'Data Requests / Privacy Rights', route: '/data-request'),
              const SizedBox(height: 10),
              Text(
                kIsWeb ? 'Static web placeholder.' : 'Static placeholder.',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.65)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow(this.index, this.text);
  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: scheme.primary.withValues(alpha: 0.12),
              border: Border.all(color: scheme.primary.withValues(alpha: 0.18)),
            ),
            alignment: Alignment.center,
            child: Text('$index', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: scheme.primary, fontWeight: FontWeight.w900)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.55))),
        ],
      ),
    );
  }
}

class _LinkRow extends StatelessWidget {
  const _LinkRow({required this.icon, required this.label, required this.route});
  final IconData icon;
  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => GoRouter.of(context).go(route),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.18)),
        ),
        child: Row(
          children: [
            Icon(icon, color: scheme.primary),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800))),
            Icon(Icons.chevron_right, color: scheme.onSurface.withValues(alpha: 0.70)),
          ],
        ),
      ),
    );
  }
}
