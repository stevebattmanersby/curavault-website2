import 'package:flutter/material.dart';

import 'package:curavault_website/site/marketing_page.dart';
import 'package:curavault_website/theme.dart';

enum BillingReturnState { success, cancel }

class BillingReturnPage extends StatelessWidget {
  const BillingReturnPage({super.key, required this.state});

  final BillingReturnState state;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isSuccess = state == BillingReturnState.success;
    final title = isSuccess ? 'Subscription activated' : 'No changes were made';
    final message = isSuccess
        ? 'Your CuraVault subscription has been activated. You can close this page and return to the CuraVault app.'
        : 'Your checkout was cancelled and your CuraVault subscription was not changed. You can close this page and return to the CuraVault app.';
    final icon = isSuccess ? Icons.check_circle_outline : Icons.cancel_outlined;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: FrostedPanel(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
            borderRadius: AppRadius.xl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: scheme.primary.withValues(alpha: 0.30),
                    ),
                  ),
                  child: Icon(icon, color: scheme.primary, size: 34),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.76),
                        height: 1.55,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
