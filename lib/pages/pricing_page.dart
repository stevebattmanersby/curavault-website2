import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:curavault_website/nav.dart';
import 'package:curavault_website/site/marketing_page.dart';
import 'package:curavault_website/site/widgets.dart';
import 'package:curavault_website/theme.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PricingPageBody();
  }
}

class _PricingPageBody extends StatefulWidget {
  const _PricingPageBody();

  @override
  State<_PricingPageBody> createState() => _PricingPageBodyState();
}

class _PricingPageBodyState extends State<_PricingPageBody> {
  bool _annual = true;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final annualSaveLabel = 'Save ~15%';

    String p(String monthly) {
      if (!_annual) return monthly;
      final value = double.tryParse(monthly.replaceAll(RegExp(r'[^0-9.]'), ''));
      if (value == null) return monthly;
      final annual = (value * 12 * 0.85);
      return '\$${annual.toStringAsFixed(0)} / year';
    }

    return MarketingPage(
      title: 'Pricing',
      lead: 'Clear, calm pricing for families and carers. This is a static preview — we can wire billing later.',
      children: [
        LayoutBuilder(
          builder: (context, c) {
            final isWide = c.maxWidth >= 920;
            final left = ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Choose what fits your household', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900, letterSpacing: -0.3)),
                  const SizedBox(height: 10),
                  Text(
                    'Start free, then upgrade when you need multiple profiles, sharing, and carer workflows. Your data stays yours — pricing is simple and transparent.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: scheme.onSurface.withValues(alpha: 0.76), height: 1.55),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: const [
                      _MiniValueChip(icon: Icons.shield_outlined, label: 'Privacy-first'),
                      _MiniValueChip(icon: Icons.lock_outline, label: 'Encryption-focused'),
                      _MiniValueChip(icon: Icons.file_present_outlined, label: 'Export-ready'),
                    ],
                  ),
                ],
              ),
            );

            final right = SubtleTintPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Billing', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 10),
                  _BillingToggle(
                    annual: _annual,
                    saveLabel: annualSaveLabel,
                    onChange: (v) => setState(() => _annual = v),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _annual
                        ? 'Annual billing is shown as a single yearly amount (placeholder) to match the app-style clarity.'
                        : 'Monthly billing is shown per month (placeholder).',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.72), height: 1.5),
                  ),
                ],
              ),
            );

            if (!isWide) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  left,
                  const SizedBox(height: 14),
                  right,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: left),
                const SizedBox(width: 16),
                SizedBox(width: 340, child: right),
              ],
            );
          },
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, c) {
            final cols = c.maxWidth >= 980 ? 3 : 1;
            final familyMonthly = '\$6 / month';
            final careMonthly = '\$12 / month';

            String family = _annual ? p(familyMonthly) : familyMonthly;
            String care = _annual ? p(careMonthly) : careMonthly;
            if (_annual) {
              family = '$family  •  billed annually';
              care = '$care  •  billed annually';
            }

            final cards = [
              PricingPlanCard(
                leadingIcon: Icons.lock_outline,
                name: 'Starter',
                priceLabel: 'Free',
                tagline: 'A calm start for organising essential records.',
                bullets: const [
                  'Single profile',
                  'Document vault basics',
                  'Manual export (PDF)',
                ],
                ctaLabel: 'Get updates',
                onCta: () => context.go(AppRoutes.contact),
              ),
              PricingPlanCard(
                leadingIcon: Icons.people_alt_outlined,
                name: 'Family',
                priceLabel: family,
                tagline: 'For households managing multiple people and shared records.',
                bullets: const [
                  'Multiple profiles',
                  'Sharing controls (planned)',
                  'Priority support (planned)',
                ],
                isFeatured: true,
                ctaLabel: 'Upgrade',
                onCta: () => context.go(AppRoutes.contact),
              ),
              PricingPlanCard(
                leadingIcon: Icons.health_and_safety_outlined,
                name: 'Care',
                priceLabel: care,
                tagline: 'For carers coordinating records, appointments, and notes.',
                bullets: const [
                  'Multiple profiles',
                  'Care team access (planned)',
                  'Audit notes (planned)',
                ],
                ctaLabel: 'Talk to us',
                onCta: () => context.go(AppRoutes.contact),
              ),
            ];
            return _PricingGrid(columns: cols, children: cards);
          },
        ),
        const SizedBox(height: 18),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('All plans include', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900)),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, c) {
                  final cols = c.maxWidth >= 920 ? 3 : 1;
                  final items = const [
                    _IncludedItem(icon: Icons.enhanced_encryption, title: 'Secure by design', body: 'Encryption-focused architecture and careful defaults.'),
                    _IncludedItem(icon: Icons.folder_open, title: 'Fast organisation', body: 'Store, tag, and retrieve documents when you need them.'),
                    _IncludedItem(icon: Icons.download, title: 'Export anytime', body: 'Portable exports so you’re never locked in.'),
                    _IncludedItem(icon: Icons.manage_accounts_outlined, title: 'Profiles', body: 'Built for individuals now, expanding to family & carers.'),
                    _IncludedItem(icon: Icons.help_outline, title: 'Human support', body: 'Clear help content and a direct contact channel.'),
                    _IncludedItem(icon: Icons.policy_outlined, title: 'Privacy-first', body: 'Designed to respect sensitive health information.'),
                  ];
                  return _IncludedGrid(columns: cols, children: items);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        SubtleTintPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('What you’re paying for', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900)),
              const SizedBox(height: 10),
              Text(
                'This website is currently static — no billing, Stripe, newsletter, or login is connected yet. When you’re ready, we can add a real checkout flow and account system.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurface.withValues(alpha: 0.74), height: 1.55),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => context.go(AppRoutes.faq),
                    icon: Icon(Icons.help_outline, color: scheme.onSurface),
                    label: const Text('FAQ'),
                  ),
                  FilledButton.icon(
                    onPressed: () => context.go(AppRoutes.contact),
                    icon: Icon(Icons.mail_outline, color: scheme.onPrimary),
                    label: const Text('Contact'),
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

class _BillingToggle extends StatelessWidget {
  const _BillingToggle({required this.annual, required this.onChange, required this.saveLabel});
  final bool annual;
  final ValueChanged<bool> onChange;
  final String saveLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.30),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.22)),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            alignment: annual ? Alignment.centerLeft : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                height: 42,
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: scheme.primary.withValues(alpha: 0.18)),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _BillingToggleButton(
                  label: 'Annual',
                  trailing: saveLabel,
                  isActive: annual,
                  onTap: () => onChange(true),
                ),
              ),
              Expanded(
                child: _BillingToggleButton(
                  label: 'Monthly',
                  isActive: !annual,
                  onTap: () => onChange(false),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BillingToggleButton extends StatefulWidget {
  const _BillingToggleButton({required this.label, required this.isActive, required this.onTap, this.trailing});
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final String? trailing;

  @override
  State<_BillingToggleButton> createState() => _BillingToggleButtonState();
}

class _BillingToggleButtonState extends State<_BillingToggleButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = widget.isActive ? scheme.primary : scheme.onSurface.withValues(alpha: 0.82);
    final pressedBg = scheme.surfaceContainerHighest.withValues(alpha: 0.18);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () {
        setState(() => _pressed = false);
        widget.onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: _pressed && !widget.isActive ? pressedBg : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(widget.label, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: fg, fontWeight: FontWeight.w900)),
            if (widget.trailing != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: scheme.outline.withValues(alpha: 0.20)),
                ),
                child: Text(widget.trailing!, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.76), fontWeight: FontWeight.w900)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _IncludedItem extends StatelessWidget {
  const _IncludedItem({required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: scheme.outline.withValues(alpha: 0.18)),
          ),
          child: Icon(icon, color: scheme.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900)),
              const SizedBox(height: 6),
              Text(body, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurface.withValues(alpha: 0.72), height: 1.5)),
            ],
          ),
        ),
      ],
    );
  }
}

class _IncludedGrid extends StatelessWidget {
  const _IncludedGrid({required this.columns, required this.children});
  final int columns;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final gap = 14.0;
    if (columns <= 1) {
      return Column(
        children: [
          for (final c in children) ...[
            c,
            const SizedBox(height: 14),
          ],
        ],
      );
    }
    return LayoutBuilder(
      builder: (context, c) {
        final w = (c.maxWidth - gap * (columns - 1)) / columns;
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

class _MiniValueChip extends StatelessWidget {
  const _MiniValueChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: scheme.primary),
          const SizedBox(width: 8),
          Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _PricingGrid extends StatelessWidget {
  const _PricingGrid({required this.columns, required this.children});
  final int columns;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final gap = 14.0;
    if (columns <= 1) {
      return Column(
        children: [
          for (final c in children) ...[
            c,
            const SizedBox(height: 14),
          ],
        ],
      );
    }
    return LayoutBuilder(
      builder: (context, c) {
        final w = (c.maxWidth - gap * (columns - 1)) / columns;
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
