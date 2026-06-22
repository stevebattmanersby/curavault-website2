import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:curavault_website/nav.dart';
import 'package:curavault_website/site/marketing_page.dart';
import 'package:curavault_website/site/widgets.dart';
import 'package:curavault_website/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final width = MediaQuery.sizeOf(context).width;
    final twoCol = width >= 980;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  border: Border.all(color: scheme.outline.withValues(alpha: 0.18)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      scheme.primary.withValues(alpha: 0.14),
                      scheme.surface,
                      scheme.tertiary.withValues(alpha: 0.08),
                    ],
                  ),
                ),
                child: twoCol
                    ? Row(
                        children: [
                          const Expanded(child: _HeroCopy()),
                          const SizedBox(width: 18),
                          const Expanded(child: ProductMockupCard()),
                        ],
                      )
                    : const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _HeroCopy(),
                          SizedBox(height: 16),
                          ProductMockupCard(),
                        ],
                      ),
              ),
              const SizedBox(height: 18),
              _TrustStrip(),
              const SizedBox(height: 26),
              _SectionTitle(
                eyebrow: 'Core value',
                title: 'Keep health documents organized — without the chaos.',
                subtitle:
                    'CuraVault is a privacy-first way to store, find, and share important medical documents for individuals, families, and carers. Designed with security in mind, and built for calm daily use.',
              ),
              const SizedBox(height: 14),
              LayoutBuilder(
                builder: (context, c) {
                  final cols = c.maxWidth >= 980 ? 3 : (c.maxWidth >= 640 ? 2 : 1);
                  return _Grid(
                    columns: cols,
                    children: const [
                      FeatureTile(
                        icon: Icons.folder_open,
                        title: 'Document vault',
                        body: 'Upload and categorize referrals, results, prescriptions, discharge notes, and more.',
                      ),
                      FeatureTile(
                        icon: Icons.search,
                        title: 'Fast retrieval',
                        body: 'Find what you need quickly with consistent structure and clear metadata.',
                      ),
                      FeatureTile(
                        icon: Icons.people_alt_outlined,
                        title: 'Family & carer friendly',
                        body: 'Organize records by person and prepare for appointments with less stress.',
                      ),
                      FeatureTile(
                        icon: Icons.lock_outline,
                        title: 'Privacy-first',
                        body: 'Built to minimize data exposure. Security and legal wording subject to review.',
                      ),
                      FeatureTile(
                        icon: Icons.share_outlined,
                        title: 'Share with control',
                        body: 'Prepare a focused set of documents to share when needed — not everything.',
                      ),
                      FeatureTile(
                        icon: Icons.schedule,
                        title: 'Reminders (planned)',
                        body: 'Optional reminders for renewals and appointments — designed to be non-intrusive.',
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 28),
              SubtleTintPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Use cases', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 10),
                    LayoutBuilder(
                      builder: (context, c) {
                        final cols = c.maxWidth >= 980 ? 3 : 1;
                        return _Grid(
                          columns: cols,
                          children: const [
                            _UseCaseCard(
                              icon: Icons.person_outline,
                              title: 'Individuals',
                              body: 'Keep your own records tidy — results, referrals, insurance, and care plans.',
                            ),
                            _UseCaseCard(
                              icon: Icons.family_restroom,
                              title: 'Families',
                              body: 'Organize multiple people under one roof — helpful during emergencies and travel.',
                            ),
                            _UseCaseCard(
                              icon: Icons.volunteer_activism_outlined,
                              title: 'Carers',
                              body: 'Prepare for appointments with quick access to history and key documents.',
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              SectionCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ready to explore?', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                          const SizedBox(height: 8),
                          Text(
                            'See how CuraVault works and what’s included in each plan. Everything on this site is static for now — forms are placeholders.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurface.withValues(alpha: 0.72), height: 1.5),
                          ),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              FilledButton(
                                onPressed: () => context.go(AppRoutes.pricing),
                                child: const Text('View pricing'),
                              ),
                              OutlinedButton(
                                onPressed: () => context.go(AppRoutes.howItWorks),
                                child: const Text('How it works'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (MediaQuery.sizeOf(context).width >= 860) ...[
                      const SizedBox(width: 16),
                      Container(
                        width: 180,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppRadius.xl),
                          gradient: LinearGradient(colors: [scheme.primary, scheme.tertiary]),
                        ),
                        child: const Icon(Icons.shield_moon_outlined, color: Colors.white, size: 44),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 22),
              MarketingPage(
                title: 'Frequently asked questions',
                lead: 'Quick answers to common questions about scope, privacy, and usage.',
                children: const [
                  _HomeFaqPreview(),
                ],
              ),
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  onPressed: () => context.go(AppRoutes.faq),
                  icon: Icon(Icons.help_outline, color: scheme.onSurface),
                  label: const Text('Read the full FAQ'),
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: scheme.outline.withValues(alpha: 0.18)),
            color: scheme.surface.withValues(alpha: 0.70),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lock, size: 16, color: scheme.primary),
              const SizedBox(width: 8),
              Text('Privacy-first • designed with security in mind', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w800)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Your health records.\nOrganized. Accessible. Controlled.',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800, height: 1.05, letterSpacing: -0.8),
        ),
        const SizedBox(height: 12),
        Text(
          'CuraVault helps you collect and manage medical documents for yourself and your loved ones — with a calm interface and a privacy-first mindset.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: scheme.onSurface.withValues(alpha: 0.74), height: 1.55),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            FilledButton.icon(
              onPressed: () => context.go(AppRoutes.features),
              icon: const Icon(Icons.explore, color: Colors.white),
              label: const Text('Explore features'),
            ),
            OutlinedButton(
              onPressed: () => context.go(AppRoutes.security),
              child: const Text('Security & privacy'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Avoid unverified compliance claims: wording subject to review.',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.62)),
        ),
      ],
    );
  }
}

class _TrustStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final items = const [
      _TrustItem(Icons.shield_outlined, 'Security-minded'),
      _TrustItem(Icons.visibility_off_outlined, 'Privacy-first'),
      _TrustItem(Icons.folder_open, 'Document clarity'),
      _TrustItem(Icons.people_alt_outlined, 'Family friendly'),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.18)),
      ),
      child: Wrap(
        spacing: 14,
        runSpacing: 10,
        children: [
          for (final item in items)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item.icon, size: 18, color: scheme.primary),
                const SizedBox(width: 8),
                Text(item.label, style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
        ],
      ),
    );
  }
}

class _TrustItem {
  const _TrustItem(this.icon, this.label);
  final IconData icon;
  final String label;
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.eyebrow, required this.title, required this.subtitle});
  final String eyebrow;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(eyebrow.toUpperCase(), style: Theme.of(context).textTheme.labelSmall?.copyWith(letterSpacing: 1.2, fontWeight: FontWeight.w900, color: scheme.primary)),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Text(title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(letterSpacing: -0.4)),
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Text(subtitle, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: scheme.onSurface.withValues(alpha: 0.74), height: 1.55)),
        ),
      ],
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({required this.columns, required this.children});
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
        final itemWidth = (c.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final child in children)
              SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: scheme.primary),
          const SizedBox(height: 10),
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(body, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurface.withValues(alpha: 0.72), height: 1.5)),
        ],
      ),
    );
  }
}

class _HomeFaqPreview extends StatelessWidget {
  const _HomeFaqPreview();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final cols = c.maxWidth >= 980 ? 2 : 1;
        return _Grid(
          columns: cols,
          children: const [
            FaqItem(
              question: 'Is CuraVault a medical service?',
              answer:
                  'No. CuraVault is intended as a personal document and record management tool. It does not provide medical diagnosis or treatment guidance.',
            ),
            FaqItem(
              question: 'Do you claim HIPAA compliance?',
              answer:
                  'We avoid unverified compliance claims. We use careful wording like “privacy-first” and “designed with security in mind”, and recommend legal review for any compliance statements.',
            ),
          ],
        );
      },
    );
  }
}
