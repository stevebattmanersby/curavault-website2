import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:curavault_website/nav.dart';
import 'package:curavault_website/site/marketing_page.dart';
import 'package:curavault_website/theme.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return MarketingPage(
      title: 'Support',
      lead: 'Help docs and support flows can be added here. For now, this is a static placeholder.',
      children: [
        SubtleTintPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Suggested support topics', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              _TopicRow(icon: Icons.upload_file_outlined, title: 'Uploading documents', body: 'How to add, rename, and categorize records.'),
              const SizedBox(height: 10),
              _TopicRow(icon: Icons.share_outlined, title: 'Sharing safely', body: 'How to share a targeted set of documents.'),
              const SizedBox(height: 10),
              _TopicRow(icon: Icons.lock_outline, title: 'Privacy & settings', body: 'How to understand privacy controls and device security.'),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton(
                    onPressed: () => context.go(AppRoutes.contact),
                    child: const Text('Contact support'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.go(AppRoutes.faq),
                    child: const Text('FAQ'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Note: these are placeholder items until a real help center is connected.',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.65)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TopicRow extends StatelessWidget {
  const _TopicRow({required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: scheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(body, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.72), height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
