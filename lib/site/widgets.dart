import 'package:flutter/material.dart';

import 'package:curavault_website/site/marketing_page.dart';
import 'package:curavault_website/theme.dart';

class FeatureTile extends StatefulWidget {
  const FeatureTile(
      {super.key, required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;

  @override
  State<FeatureTile> createState() => _FeatureTileState();
}

class _FeatureTileState extends State<FeatureTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _hover
              ? scheme.surfaceContainerHighest.withValues(alpha: 0.35)
              : scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
              color: scheme.outline.withValues(alpha: _hover ? 0.28 : 0.18)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(widget.icon, color: scheme.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(widget.body,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurface.withValues(alpha: 0.72),
                          height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PricingPlanCard extends StatelessWidget {
  const PricingPlanCard({
    super.key,
    this.leadingIcon,
    required this.name,
    required this.priceLabel,
    required this.tagline,
    required this.bullets,
    this.isFeatured = false,
    required this.ctaLabel,
    required this.onCta,
  });

  final IconData? leadingIcon;
  final String name;
  final String priceLabel;
  final String tagline;
  final List<String> bullets;
  final bool isFeatured;
  final String ctaLabel;
  final VoidCallback onCta;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final badge = isFeatured
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: isDark ? 0.16 : 0.12),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: scheme.primary.withValues(alpha: 0.22)),
            ),
            child: Text('Recommended',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: scheme.primary, fontWeight: FontWeight.w800)),
          )
        : null;

    final card = FrostedPanel(
      padding: const EdgeInsets.all(18),
      borderRadius: AppRadius.xl,
      tint: isFeatured ? scheme.surfaceContainerHighest : scheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isFeatured)
            Container(
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: LinearGradient(
                  colors: [
                    scheme.primary.withValues(alpha: 0.95),
                    scheme.tertiary.withValues(alpha: 0.90),
                  ],
                ),
              ),
            ),
          if (isFeatured) const SizedBox(height: 14),
          Row(
            children: [
              if (leadingIcon != null) ...[
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: scheme.outline.withValues(alpha: 0.18)),
                  ),
                  child: Icon(leadingIcon, color: scheme.primary),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800, letterSpacing: -0.2),
                ),
              ),
              if (badge != null) badge,
            ],
          ),
          const SizedBox(height: 12),
          Text(priceLabel,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(letterSpacing: -0.8, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Text(tagline,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.74),
                  height: 1.5)),
          const SizedBox(height: 14),
          for (final b in bullets)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check, size: 18, color: scheme.primary),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Text(b,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(height: 1.45))),
                ],
              ),
            ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onCta,
              style: FilledButton.styleFrom(
                backgroundColor: isFeatured
                    ? scheme.primary
                    : scheme.surfaceContainerHighest,
                foregroundColor:
                    isFeatured ? scheme.onPrimary : scheme.onSurface,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_forward,
                      size: 18,
                      color: isFeatured ? scheme.onPrimary : scheme.onSurface),
                  const SizedBox(width: 8),
                  Text(ctaLabel,
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    if (!isFeatured) return card;

    // Featured plan gets an extra subtle outer stroke (app-like emphasis).
    return Container(
      padding: const EdgeInsets.all(1.3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primary.withValues(alpha: isDark ? 0.55 : 0.40),
            scheme.tertiary.withValues(alpha: isDark ? 0.35 : 0.25),
          ],
        ),
      ),
      child: card,
    );
  }
}

class FaqItem extends StatefulWidget {
  const FaqItem({super.key, required this.question, required this.answer});
  final String question;
  final String answer;

  @override
  State<FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.18)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _open = !_open),
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                      child: Text(widget.question,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700))),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 180),
                    turns: _open ? 0.5 : 0.0,
                    child: Icon(Icons.expand_more,
                        color: scheme.onSurface.withValues(alpha: 0.75)),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            crossFadeState:
                _open ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 180),
            firstChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(widget.answer,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.72),
                        height: 1.55)),
              ),
            ),
            secondChild: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class ProductMockupCard extends StatelessWidget {
  const ProductMockupCard({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: scheme.primary.withValues(alpha: 0.22)),
          boxShadow: [
            BoxShadow(
              color: scheme.primary.withValues(alpha: 0.20),
              blurRadius: 42,
              offset: const Offset(0, 24),
            ),
          ],
        ),
        child: Stack(
          children: [
            const Positioned.fill(child: _HealthDashboardMockup()),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black.withValues(alpha: 0.10),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.08),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 22,
              bottom: 22,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.38),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border:
                      Border.all(color: scheme.primary.withValues(alpha: 0.24)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock_outline, color: scheme.primary, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      'Your data. Your control.',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HealthDashboardMockup extends StatelessWidget {
  const _HealthDashboardMockup();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF031014), Color(0xFF08282A)],
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF071018),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: scheme.primary.withValues(alpha: 0.25)),
            boxShadow: [
              BoxShadow(
                color: scheme.primary.withValues(alpha: 0.22),
                blurRadius: 46,
                offset: const Offset(0, 22),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 132,
                height: 132,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: scheme.primary.withValues(alpha: 0.95),
                    width: 10,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: scheme.primary.withValues(alpha: 0.24),
                      blurRadius: 26,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '87',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        'Excellent',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: scheme.primary,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Row(
                      children: [
                        Expanded(
                          child: _DashboardStat(
                            icon: Icons.monitor_heart_outlined,
                            value: '120/80',
                            label: 'Blood pressure',
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _DashboardStat(
                            icon: Icons.medication_outlined,
                            value: '3',
                            label: 'Medications',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _DashboardStat(
                            icon: Icons.folder_open,
                            value: '24',
                            label: 'Documents',
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _DashboardStat(
                            icon: Icons.favorite_border,
                            value: '72',
                            label: 'Heart rate',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardStat extends StatelessWidget {
  const _DashboardStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: scheme.primary, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.62),
                ),
          ),
        ],
      ),
    );
  }
}

class _DocumentsMockup extends StatelessWidget {
  const _DocumentsMockup();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF031014), Color(0xFF092126)],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF071018),
                borderRadius: BorderRadius.circular(24),
                border:
                    Border.all(color: scheme.primary.withValues(alpha: 0.20)),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _DocumentRow(
                    icon: Icons.science_outlined,
                    title: 'Blood test results',
                    label: 'Lab results',
                  ),
                  SizedBox(height: 10),
                  _DocumentRow(
                    icon: Icons.image_search_outlined,
                    title: 'MRI scan',
                    label: 'Imaging',
                  ),
                  SizedBox(height: 10),
                  _DocumentRow(
                    icon: Icons.health_and_safety_outlined,
                    title: 'Insurance card',
                    label: 'Health plan',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _FloatingDocIcon(
                  icon: Icons.picture_as_pdf_outlined,
                  label: 'PDF',
                  color: scheme.error,
                ),
                const SizedBox(height: 12),
                _FloatingDocIcon(
                  icon: Icons.badge_outlined,
                  label: 'ID',
                  color: scheme.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentRow extends StatelessWidget {
  const _DocumentRow({
    required this.icon,
    required this.title,
    required this.label,
  });

  final IconData icon;
  final String title;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.14)),
      ),
      child: Row(
        children: [
          Icon(icon, color: scheme.primary, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.60),
                      ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: scheme.onSurface.withValues(alpha: 0.48),
          ),
        ],
      ),
    );
  }
}

class _FloatingDocIcon extends StatelessWidget {
  const _FloatingDocIcon({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: color.withValues(alpha: 0.30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ],
      ),
    );
  }
}

class FeatureShowcasePanel extends StatelessWidget {
  const FeatureShowcasePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, c) {
        final wide = c.maxWidth >= 900;

        return Container(
          padding: EdgeInsets.all(wide ? 18 : 14),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: scheme.outline.withValues(alpha: 0.18)),
          ),
          child: Column(
            children: [
              wide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(flex: 7, child: _FeatureVisualFrame()),
                        const SizedBox(width: 14),
                        Expanded(
                          flex: 5,
                          child: _FeatureShowcaseCopy(scheme: scheme),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _FeatureVisualFrame(),
                        const SizedBox(height: 12),
                        _FeatureShowcaseCopy(scheme: scheme),
                      ],
                    ),
              const SizedBox(height: 14),
              const _ShowcaseStepGrid(),
            ],
          ),
        );
      },
    );
  }
}

class _FeatureVisualFrame extends StatelessWidget {
  const _FeatureVisualFrame();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const _DocumentsMockup(),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withValues(alpha: 0.38),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureShowcaseCopy extends StatelessWidget {
  const _FeatureShowcaseCopy({required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'A cleaner path from document to decision',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w900, letterSpacing: 0),
        ),
        const SizedBox(height: 10),
        Text(
          'Keep the product story clear: one secure vault, one calm workflow, and small focused panels for the details.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: scheme.onSurface.withValues(alpha: 0.72),
                height: 1.55,
              ),
        ),
      ],
    );
  }
}

class _ShowcaseStepGrid extends StatelessWidget {
  const _ShowcaseStepGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final cols = c.maxWidth >= 860 ? 3 : 1;
        return _ResponsiveWrap(
          columns: cols,
          gap: 10,
          children: const [
            _ShowcaseStep(
              icon: Icons.upload_file_outlined,
              title: 'Add the record',
              body: 'Scans, PDFs, referrals, letters, and results.',
            ),
            _ShowcaseStep(
              icon: Icons.label_important_outline,
              title: 'Structure the details',
              body: 'Sort by person, category, date, and appointment context.',
            ),
            _ShowcaseStep(
              icon: Icons.fact_check_outlined,
              title: 'Find the right set',
              body: 'Prepare only the documents needed for the moment.',
            ),
          ],
        );
      },
    );
  }
}

class _ShowcaseStep extends StatelessWidget {
  const _ShowcaseStep({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.30),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.16)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: scheme.primary.withValues(alpha: 0.18)),
            ),
            child: Icon(icon, color: scheme.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.68),
                        height: 1.4,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureWorkflowStrip extends StatelessWidget {
  const FeatureWorkflowStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final cols = c.maxWidth >= 920 ? 4 : (c.maxWidth >= 620 ? 2 : 1);
        final items = const [
          _WorkflowItem(Icons.cloud_upload_outlined, 'Upload',
              'Bring records into one secure place.'),
          _WorkflowItem(Icons.account_tree_outlined, 'Sort',
              'Group by person, topic, and date.'),
          _WorkflowItem(
              Icons.search, 'Retrieve', 'Search calmly when time matters.'),
          _WorkflowItem(Icons.share_outlined, 'Share',
              'Prepare a focused appointment pack.'),
        ];

        if (cols == 1) {
          return Column(
            children: [
              for (final item in items) ...[
                item,
                const SizedBox(height: 12),
              ],
            ],
          );
        }

        const gap = 12.0;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final item in items)
              SizedBox(
                width: (c.maxWidth - gap * (cols - 1)) / cols,
                child: item,
              ),
          ],
        );
      },
    );
  }
}

class VisualFeatureLibrary extends StatelessWidget {
  const VisualFeatureLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF061017),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.10),
            blurRadius: 36,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LibraryHeading(
            eyebrow: 'Health record toolkit',
            title: 'A visual command center for health records',
            body:
                'Bring documents, medication notes, timelines, and family records into one calm view before appointments, travel, or an emergency.',
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, c) {
              final cols = c.maxWidth >= 1080 ? 4 : (c.maxWidth >= 700 ? 2 : 1);
              final items = const [
                _LibraryCard(
                  icon: Icons.shield_outlined,
                  title: 'Secure vault',
                  body:
                      'A guarded home for referrals, results, notes, and IDs.',
                ),
                _LibraryCard(
                  icon: Icons.auto_awesome,
                  title: 'AI assistance',
                  body:
                      'Helpful summaries and organisation cues, clearly labelled.',
                ),
                _LibraryCard(
                  icon: Icons.document_scanner_outlined,
                  title: 'Scan and capture',
                  body: 'Turn paper admin into searchable digital records.',
                ),
                _LibraryCard(
                  icon: Icons.timeline,
                  title: 'Timeline',
                  body: 'See important health events in chronological context.',
                ),
              ];
              return _ResponsiveWrap(columns: cols, gap: 12, children: items);
            },
          ),
        ],
      ),
    );
  }
}

class HealthStatsPanel extends StatelessWidget {
  const HealthStatsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final cols = c.maxWidth >= 980 ? 4 : (c.maxWidth >= 620 ? 2 : 1);
        return _ResponsiveWrap(
          columns: cols,
          gap: 12,
          children: const [
            _StatCard(
              icon: Icons.favorite_border,
              label: 'Health score',
              value: '87',
              detail: 'Ready for review',
            ),
            _StatCard(
              icon: Icons.monitor_heart_outlined,
              label: 'Blood pressure',
              value: '120/80',
              detail: 'Latest reading',
            ),
            _StatCard(
              icon: Icons.medication_outlined,
              label: 'Medications',
              value: '3',
              detail: 'Active records',
            ),
            _StatCard(
              icon: Icons.folder_open,
              label: 'Documents',
              value: '24',
              detail: 'Organised files',
            ),
          ],
        );
      },
    );
  }
}

class TrustBadgeWall extends StatelessWidget {
  const TrustBadgeWall({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final cols = c.maxWidth >= 1020 ? 6 : (c.maxWidth >= 700 ? 3 : 2);
        return _ResponsiveWrap(
          columns: cols,
          gap: 10,
          children: const [
            _TrustBadge(
                icon: Icons.privacy_tip_outlined, label: 'Privacy first'),
            _TrustBadge(icon: Icons.lock_outline, label: 'Encrypted'),
            _TrustBadge(icon: Icons.person_outline, label: 'Your data'),
            _TrustBadge(icon: Icons.auto_awesome, label: 'AI assisted'),
            _TrustBadge(icon: Icons.family_restroom, label: 'Family ready'),
            _TrustBadge(icon: Icons.share_outlined, label: 'Secure sharing'),
          ],
        );
      },
    );
  }
}

class _LibraryHeading extends StatelessWidget {
  const _LibraryHeading({
    required this.eyebrow,
    required this.title,
    required this.body,
  });

  final String eyebrow;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 760),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eyebrow.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w900, letterSpacing: 0),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.70),
                  height: 1.55,
                ),
          ),
        ],
      ),
    );
  }
}

class _LibraryCard extends StatelessWidget {
  const _LibraryCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.18)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primary.withValues(alpha: 0.13),
            const Color(0xFF07141B),
          ],
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _CrispFeatureBanner(icon: icon),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.34),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withValues(alpha: 0.38),
                            border: Border.all(
                              color: scheme.primary.withValues(alpha: 0.34),
                            ),
                          ),
                          child: Icon(icon, color: scheme.primary, size: 19),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 5),
              Text(
                body,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurface.withValues(alpha: 0.68),
                      height: 1.4,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CrispFeatureBanner extends StatelessWidget {
  const _CrispFeatureBanner({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primary.withValues(alpha: 0.18),
            const Color(0xFF07141B),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 20,
            top: 14,
            child: Icon(
              icon,
              size: 72,
              color: scheme.primary.withValues(alpha: 0.12),
            ),
          ),
          Positioned(
            left: 18,
            top: 18,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: scheme.primary.withValues(alpha: 0.14),
                border: Border.all(
                  color: scheme.primary.withValues(alpha: 0.32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: scheme.primary.withValues(alpha: 0.16),
                    blurRadius: 22,
                  ),
                ],
              ),
              child: Icon(icon, color: scheme.primary, size: 25),
            ),
          ),
          Positioned(
            left: 86,
            right: 18,
            top: 28,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 8,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 10),
                FractionallySizedBox(
                  widthFactor: 0.62,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: scheme.primary.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.detail,
  });

  final IconData icon;
  final String label;
  final String value;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      constraints: const BoxConstraints(minHeight: 110),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: scheme.primary, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w900, letterSpacing: 0),
          ),
          const SizedBox(height: 5),
          Text(
            detail,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.66),
                ),
          ),
        ],
      ),
    );
  }
}

class _TrustBadge extends StatelessWidget {
  const _TrustBadge({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      constraints: const BoxConstraints(minHeight: 58),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.16)),
      ),
      child: Row(
        children: [
          Icon(icon, color: scheme.primary, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.w800, height: 1.2),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResponsiveWrap extends StatelessWidget {
  const _ResponsiveWrap({
    required this.columns,
    required this.gap,
    required this.children,
  });

  final int columns;
  final double gap;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (columns <= 1) {
      return Column(
        children: [
          for (final child in children) ...[
            child,
            SizedBox(height: gap),
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

class _WorkflowItem extends StatelessWidget {
  const _WorkflowItem(this.icon, this.title, this.body);
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      constraints: const BoxConstraints(minHeight: 112),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: scheme.primary, size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 5),
          Text(
            body,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.70),
                  height: 1.45,
                ),
          ),
        ],
      ),
    );
  }
}
