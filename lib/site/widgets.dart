import 'package:flutter/material.dart';

import 'package:curavault_website/site/marketing_page.dart';
import 'package:curavault_website/theme.dart';

class FeatureTile extends StatefulWidget {
  const FeatureTile({super.key, required this.icon, required this.title, required this.body});
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
          color: _hover ? scheme.surfaceContainerHighest.withValues(alpha: 0.35) : scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: scheme.outline.withValues(alpha: _hover ? 0.28 : 0.18)),
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
                  Text(widget.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(widget.body, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurface.withValues(alpha: 0.72), height: 1.5)),
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
            child: Text('Recommended', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: scheme.primary, fontWeight: FontWeight.w800)),
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
                    border: Border.all(color: scheme.outline.withValues(alpha: 0.18)),
                  ),
                  child: Icon(leadingIcon, color: scheme.primary),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.2),
                ),
              ),
              if (badge != null) badge,
            ],
          ),
          const SizedBox(height: 12),
          Text(priceLabel, style: Theme.of(context).textTheme.headlineSmall?.copyWith(letterSpacing: -0.8, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Text(tagline, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurface.withValues(alpha: 0.74), height: 1.5)),
          const SizedBox(height: 14),
          for (final b in bullets)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check, size: 18, color: scheme.primary),
                  const SizedBox(width: 10),
                  Expanded(child: Text(b, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.45))),
                ],
              ),
            ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onCta,
              style: FilledButton.styleFrom(
                backgroundColor: isFeatured ? scheme.primary : scheme.surfaceContainerHighest,
                foregroundColor: isFeatured ? scheme.onPrimary : scheme.onSurface,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_forward, size: 18, color: isFeatured ? scheme.onPrimary : scheme.onSurface),
                  const SizedBox(width: 8),
                  Text(ctaLabel, style: const TextStyle(fontWeight: FontWeight.w800)),
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
                  Expanded(child: Text(widget.question, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700))),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 180),
                    turns: _open ? 0.5 : 0.0,
                    child: Icon(Icons.expand_more, color: scheme.onSurface.withValues(alpha: 0.75)),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            crossFadeState: _open ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 180),
            firstChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(widget.answer, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurface.withValues(alpha: 0.72), height: 1.55)),
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
      aspectRatio: 5 / 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.18)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              scheme.primary.withValues(alpha: 0.16),
              scheme.surface,
              scheme.tertiary.withValues(alpha: 0.10),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _MockPill(icon: Icons.folder_open, label: 'Documents'),
                  const SizedBox(width: 10),
                  _MockPill(icon: Icons.schedule, label: 'Reminders'),
                  const SizedBox(width: 10),
                  _MockPill(icon: Icons.people_alt_outlined, label: 'Family access'),
                ],
              ),
              const Spacer(),
              Text('Preview', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.65), fontWeight: FontWeight.w800, letterSpacing: 0.6)),
              const SizedBox(height: 8),
              Text('A calm space for health records', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.2)),
              const SizedBox(height: 8),
              Text(
                'This is a static mockup placeholder. Later we can swap this for real screenshots, a video, or interactive demos.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.72), height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MockPill extends StatelessWidget {
  const _MockPill({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.60),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: scheme.onSurface.withValues(alpha: 0.80)),
          const SizedBox(width: 8),
          Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
