import 'package:flutter/material.dart';

import 'package:curavault_website/theme.dart';

/// A subtle, non-splash navigation link.
class SiteLink extends StatefulWidget {
  const SiteLink({super.key, required this.label, required this.onTap, this.isActive = false});
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  @override
  State<SiteLink> createState() => _SiteLinkState();
}

class _SiteLinkState extends State<SiteLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = widget.isActive ? scheme.primary : scheme.onSurface.withValues(alpha: 0.78);
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: (_hover && !widget.isActive) ? scheme.surfaceContainerHighest.withValues(alpha: 0.35) : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            widget.label,
            style: context.textStyles.labelLarge?.copyWith(color: fg, fontWeight: widget.isActive ? FontWeight.w700 : FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
