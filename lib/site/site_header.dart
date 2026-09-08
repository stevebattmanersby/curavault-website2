import 'package:flutter/material.dart';

import 'package:curavault_website/nav.dart';
import 'package:curavault_website/site/site_link.dart';
import 'package:curavault_website/theme.dart';

class SiteHeader extends StatelessWidget {
  const SiteHeader({
    super.key,
    required this.activePath,
    required this.onLogoTap,
    required this.onNavTap,
  });

  final String activePath;
  final VoidCallback onLogoTap;
  final ValueChanged<String> onNavTap;

  static const _primaryNav = <_NavItem>[
    _NavItem('Features', AppRoutes.features),
    _NavItem('How it works', AppRoutes.howItWorks),
    _NavItem('Security', AppRoutes.security),
    _NavItem('Pricing', AppRoutes.pricing),
    _NavItem('FAQ', AppRoutes.faq),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isCompact = width < 1400;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: (isDark ? scheme.surfaceContainerHighest : scheme.surface)
            .withValues(alpha: isDark ? 0.72 : 0.92),
        border: Border(
            bottom: BorderSide(
                color: scheme.outline.withValues(alpha: isDark ? 0.70 : 0.16))),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1440),
              child: Row(
                children: [
                  if (isCompact)
                    Flexible(child: _BrandMark(onTap: onLogoTap))
                  else
                    _BrandMark(onTap: onLogoTap),
                  const Spacer(),
                  if (!isCompact) ...[
                    for (final item in _primaryNav)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SiteLink(
                          label: item.label,
                          isActive: activePath == item.route,
                          onTap: () => onNavTap(item.route),
                        ),
                      ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      key: const ValueKey('site-header-contact'),
                      onPressed: () => onNavTap(AppRoutes.contact),
                      icon: const Icon(Icons.mail_outline),
                      label: const Text('Contact'),
                    ),
                    const SizedBox(width: 10),
                    FilledButton.icon(
                      key: const ValueKey('site-header-login'),
                      onPressed: () => onNavTap(AppRoutes.login),
                      icon: Icon(Icons.login_rounded, color: scheme.onPrimary),
                      label: const Text('Log in'),
                    ),
                  ] else ...[
                    _MobileMenuButton(
                        activePath: activePath, onNavTap: onNavTap),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: scheme.primary.withValues(alpha: 0.28)),
              boxShadow: [
                BoxShadow(
                  color: scheme.primary.withValues(alpha: 0.22),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Image.asset(
                'assets/icons/curavault_logo.png',
                key: const ValueKey('site-brand-logo'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CuraVault',
                    style: context.textStyles.titleMedium?.copyWith(
                        letterSpacing: -0.1, fontWeight: FontWeight.w700)),
                Text(
                  'Personal health records',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: context.textStyles.labelSmall?.copyWith(
                      color: scheme.onSurface.withValues(alpha: 0.65)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  const _MobileMenuButton({required this.activePath, required this.onNavTap});
  final String activePath;
  final ValueChanged<String> onNavTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () async {
        final route = await showModalBottomSheet<String>(
          context: context,
          showDragHandle: true,
          isScrollControlled: true,
          backgroundColor: scheme.surfaceContainerHighest,
          builder: (context) => _MobileMenuSheet(activePath: activePath),
        );
        if (route != null) onNavTap(route);
      },
      icon: Icon(Icons.menu, color: scheme.onSurface),
      tooltip: 'Menu',
    );
  }
}

class _MobileMenuSheet extends StatelessWidget {
  const _MobileMenuSheet({required this.activePath});
  final String activePath;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final items = <_NavItem>[
      const _NavItem('Home', AppRoutes.home),
      ...SiteHeader._primaryNav,
      const _NavItem('Support', AppRoutes.support),
      const _NavItem('Contact', AppRoutes.contact),
      const _NavItem('Log in', AppRoutes.login),
      const _NavItem('Privacy Policy', AppRoutes.privacy),
    ];
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Navigate',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            for (final item in items)
              _MobileMenuRow(
                key: ValueKey('mobile-nav-${item.route}'),
                label: item.label,
                isActive: activePath == item.route,
                isPrimary: item.route == AppRoutes.login,
                onTap: () => Navigator.of(context).pop(item.route),
              ),
            const SizedBox(height: 6),
            Text(
              'Privacy-first • Security-minded',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: scheme.onSurface.withValues(alpha: 0.65)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileMenuRow extends StatefulWidget {
  const _MobileMenuRow(
      {super.key,
      required this.label,
      required this.isActive,
      required this.isPrimary,
      required this.onTap});
  final String label;
  final bool isActive;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  State<_MobileMenuRow> createState() => _MobileMenuRowState();
}

class _MobileMenuRowState extends State<_MobileMenuRow> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: widget.isActive || widget.isPrimary
                ? scheme.primary.withValues(alpha: 0.10)
                : scheme.surfaceContainerHighest
                    .withValues(alpha: _pressed ? 0.50 : 0.30),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: scheme.outline.withValues(alpha: 0.20)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: widget.isPrimary ? scheme.primary : null,
                        fontWeight: widget.isPrimary ? FontWeight.w700 : null,
                      ),
                ),
              ),
              Icon(
                widget.isPrimary ? Icons.login_rounded : Icons.chevron_right,
                color: widget.isPrimary
                    ? scheme.primary
                    : scheme.onSurface.withValues(alpha: 0.70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.label, this.route);
  final String label;
  final String route;
}
