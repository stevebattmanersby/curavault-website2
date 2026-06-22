import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:curavault_website/nav.dart';
import 'package:curavault_website/site/site_footer.dart';
import 'package:curavault_website/site/site_header.dart';
import 'package:curavault_website/theme.dart';

/// Shared marketing layout: responsive header + footer + scrollable body.
class SiteShell extends StatefulWidget {
  const SiteShell({super.key, required this.child});
  final Widget child;

  @override
  State<SiteShell> createState() => _SiteShellState();
}

class _SiteShellState extends State<SiteShell> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    scheme.surfaceContainerHighest.withValues(alpha: isDark ? 0.34 : 0.60),
                    scheme.surface.withValues(alpha: 0.00),
                    scheme.surface.withValues(alpha: 0.00),
                    scheme.tertiary.withValues(alpha: isDark ? 0.08 : 0.16),
                  ],
                ),
              ),
            ),
          ),
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: SiteHeader(
                  activePath: GoRouterState.of(context).uri.path,
                  onLogoTap: () {
                    if (GoRouterState.of(context).uri.path == AppRoutes.home) {
                      _scrollToTop();
                    } else {
                      context.go(AppRoutes.home);
                    }
                  },
                  onNavTap: (route) {
                    if (route == GoRouterState.of(context).uri.path) {
                      _scrollToTop();
                      return;
                    }
                    context.go(route);
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 240),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  child: KeyedSubtree(key: ValueKey(GoRouterState.of(context).uri.path), child: widget.child),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
              const SliverToBoxAdapter(child: SiteFooter()),
            ],
          ),
        ],
      ),
      floatingActionButton: MediaQuery.sizeOf(context).width >= 700
          ? null
          : FloatingActionButton.small(
              onPressed: _scrollToTop,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: isDark ? 0.85 : 1.0),
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              child: const Icon(Icons.arrow_upward),
            ),
    );
  }
}
