import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:curavault_website/nav.dart';
import 'package:curavault_website/site/marketing_page.dart';
import 'package:curavault_website/theme.dart';

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final steps = const [
      _Step(
        icon: Icons.upload_file_outlined,
        title: 'Capture & upload',
        body: 'Add documents like referrals, test results, letters, prescriptions, and care plans.',
      ),
      _Step(
        icon: Icons.account_tree_outlined,
        title: 'Organize with structure',
        body: 'Group by person, category, and date so information stays consistent over time.',
      ),
      _Step(
        icon: Icons.search,
        title: 'Retrieve quickly',
        body: 'Search and filter to find what’s needed before an appointment or during travel.',
      ),
      _Step(
        icon: Icons.share_outlined,
        title: 'Share intentionally',
        body: 'Prepare a focused packet for a clinician or caregiver rather than sharing everything.',
      ),
    ];

    return MarketingPage(
      title: 'How It Works',
      lead: 'A simple workflow that keeps documents tidy and accessible without turning your life into a filing cabinet.',
      children: [
        LayoutBuilder(
          builder: (context, c) {
            final cols = c.maxWidth >= 980 ? 2 : 1;
            return _StepsGrid(columns: cols, steps: steps);
          },
        ),
        const SizedBox(height: 18),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('A note on privacy & security', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(
                'We use careful wording on this website. CuraVault aims to be privacy-first and designed with security in mind, but any legal or compliance wording should be reviewed by qualified professionals.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurface.withValues(alpha: 0.72), height: 1.55),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton(
                    onPressed: () => context.go(AppRoutes.security),
                    child: const Text('Security & Privacy'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.go(AppRoutes.pricing),
                    child: const Text('Pricing'),
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

class _StepsGrid extends StatelessWidget {
  const _StepsGrid({required this.columns, required this.steps});
  final int columns;
  final List<_Step> steps;

  @override
  Widget build(BuildContext context) {
    final gap = 14.0;
    final tiles = [
      for (var i = 0; i < steps.length; i++) _StepCard(index: i + 1, step: steps[i]),
    ];
    if (columns <= 1) {
      return Column(
        children: [
          for (final t in tiles) ...[
            t,
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
            for (final t in tiles) SizedBox(width: w, child: t),
          ],
        );
      },
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.index, required this.step});
  final int index;
  final _Step step;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: scheme.primary.withValues(alpha: 0.12),
                ),
                child: Icon(step.icon, color: scheme.primary),
              ),
              const SizedBox(width: 10),
              Text('Step $index', style: Theme.of(context).textTheme.labelSmall?.copyWith(letterSpacing: 1.2, fontWeight: FontWeight.w900, color: scheme.primary)),
            ],
          ),
          const SizedBox(height: 12),
          Text(step.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.2)),
          const SizedBox(height: 8),
          Text(step.body, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurface.withValues(alpha: 0.72), height: 1.55)),
        ],
      ),
    );
  }
}

class _Step {
  const _Step({required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;
}
