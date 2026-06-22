import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:curavault_website/nav.dart';
import 'package:curavault_website/site/marketing_page.dart';
import 'package:curavault_website/site/widgets.dart';
import 'package:curavault_website/theme.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return MarketingPage(
      title: 'Features',
      lead: 'A calm, structured way to keep important health documents ready when you need them.',
      children: [
        LayoutBuilder(
          builder: (context, c) {
            final cols = c.maxWidth >= 980 ? 2 : 1;
            return _FeatureGrid(
              columns: cols,
              children: const [
                FeatureTile(
                  icon: Icons.account_tree_outlined,
                  title: 'Organize by person',
                  body: 'Keep separate vaults for individuals, family members, or cared-for people.',
                ),
                FeatureTile(
                  icon: Icons.label_outline,
                  title: 'Tags & categories',
                  body: 'Use consistent categories for results, referrals, letters, imaging, insurance, and more.',
                ),
                FeatureTile(
                  icon: Icons.security,
                  title: 'Security-minded design',
                  body: 'Designed with security in mind. Specific claims are subject to technical and legal review.',
                ),
                FeatureTile(
                  icon: Icons.picture_as_pdf_outlined,
                  title: 'Scan & store (planned)',
                  body: 'Capture documents from paper when needed. Keep a clear digital record over time.',
                ),
                FeatureTile(
                  icon: Icons.share_outlined,
                  title: 'Share a curated set',
                  body: 'Export or share a targeted set of documents for an appointment or second opinion.',
                ),
                FeatureTile(
                  icon: Icons.history,
                  title: 'Timeline view (planned)',
                  body: 'A chronological view to see what happened and when — without digging through folders.',
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 18),
        SubtleTintPanel(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Next: see it in context', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text(
                      'Walk through the flow from capture → organization → retrieval → sharing.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurface.withValues(alpha: 0.72), height: 1.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: () => context.go(AppRoutes.howItWorks),
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: const Text('How it works'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  const _FeatureGrid({required this.columns, required this.children});
  final int columns;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final gap = 14.0;
    if (columns == 1) {
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
