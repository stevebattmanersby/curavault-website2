import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:curavault_website/nav.dart';
import 'package:curavault_website/theme.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: isDark ? 0.36 : 0.22),
        border: Border(top: BorderSide(color: scheme.outline.withValues(alpha: isDark ? 0.45 : 0.18))),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: 16,
                runSpacing: 10,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  _FooterColumn(
                    title: 'Product',
                    links: [
                      _FooterLink('Features', AppRoutes.features),
                      _FooterLink('How it works', AppRoutes.howItWorks),
                      _FooterLink('Pricing', AppRoutes.pricing),
                      _FooterLink('Security & Privacy', AppRoutes.security),
                    ],
                  ),
                  _FooterColumn(
                    title: 'Help',
                    links: [
                      _FooterLink('FAQ', AppRoutes.faq),
                      _FooterLink('Support', AppRoutes.support),
                      _FooterLink('Contact', AppRoutes.contact),
                      _FooterLink('Account deletion', AppRoutes.deleteAccount),
                    ],
                  ),
                  _FooterColumn(
                    title: 'Legal',
                    links: [
                      _FooterLink('Privacy Policy', AppRoutes.privacy),
                      _FooterLink('Terms of Service', AppRoutes.terms),
                      _FooterLink('Data requests / privacy rights', AppRoutes.dataRequest),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: scheme.outline.withValues(alpha: isDark ? 0.55 : 0.20)),
                  color: scheme.surface.withValues(alpha: isDark ? 0.40 : 0.65),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Important note', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 6),
                    Text(
                      'CuraVault is designed as a personal document and record organizer. Content on this website is for general information only and is subject to legal and technical review. Do not rely on it as medical advice.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.72), height: 1.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '© ${DateTime.now().year} CuraVault. All rights reserved.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.65)),
                    ),
                  ),
                  Text(
                    'Privacy-first • Security-minded',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.65)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  const _FooterColumn({required this.title, required this.links});
  final String title;
  final List<_FooterLink> links;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: scheme.onSurface, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          for (final link in links)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _FooterLinkRow(link: link),
            ),
        ],
      ),
    );
  }
}

class _FooterLinkRow extends StatefulWidget {
  const _FooterLinkRow({required this.link});
  final _FooterLink link;

  @override
  State<_FooterLinkRow> createState() => _FooterLinkRowState();
}

class _FooterLinkRowState extends State<_FooterLinkRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => context.go(widget.link.route),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 120),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: _hover ? scheme.primary : scheme.onSurface.withValues(alpha: 0.70),
                fontWeight: FontWeight.w600,
              ),
          child: Text(widget.link.label),
        ),
      ),
    );
  }
}

class _FooterLink {
  const _FooterLink(this.label, this.route);
  final String label;
  final String route;
}
