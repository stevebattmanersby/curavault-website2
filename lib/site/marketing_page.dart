import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:curavault_website/theme.dart';

/// Standard page wrapper that keeps content width comfortable.
class MarketingPage extends StatelessWidget {
  const MarketingPage({super.key, required this.title, required this.children, this.lead});
  final String title;
  final String? lead;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(letterSpacing: -0.4)),
              if (lead != null) ...[
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Text(lead!, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: scheme.onSurface.withValues(alpha: 0.75), height: 1.55)),
                ),
              ],
              const SizedBox(height: 18),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FrostedPanel(
      padding: const EdgeInsets.all(18),
      borderRadius: AppRadius.xl,
      child: child,
    );
  }
}

class SubtleTintPanel extends StatelessWidget {
  const SubtleTintPanel({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FrostedPanel(
      padding: const EdgeInsets.all(18),
      borderRadius: AppRadius.xl,
      tint: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: child,
    );
  }
}

/// A soft, app-like container used across the site.
///
/// In dark mode we add a subtle blur (frosted glass) and a translucent fill,
/// matching the mobile UI references.
class FrostedPanel extends StatelessWidget {
  const FrostedPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = AppRadius.xl,
    this.tint,
  });

  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final fill = (tint ?? scheme.surface).withValues(alpha: isDark ? 0.72 : 0.92);

    Widget body = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: scheme.outline.withValues(alpha: isDark ? 0.50 : 0.18)),
      ),
      child: child,
    );

    if (!isDark) return body;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: body,
      ),
    );
  }
}
