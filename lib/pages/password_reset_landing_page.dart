import 'package:flutter/material.dart';

import 'package:curavault_website/recovery/password_recovery_browser.dart';
import 'package:curavault_website/recovery/password_recovery_handoff.dart';
import 'package:curavault_website/site/marketing_page.dart';
import 'package:curavault_website/theme.dart';

class PasswordResetLandingPage extends StatefulWidget {
  const PasswordResetLandingPage({
    super.key,
    required this.recoveryUri,
    this.browser,
  });

  final Uri recoveryUri;
  final PasswordRecoveryBrowser? browser;

  @override
  State<PasswordResetLandingPage> createState() =>
      _PasswordResetLandingPageState();
}

class _PasswordResetLandingPageState extends State<PasswordResetLandingPage> {
  late final PasswordRecoveryBrowser _browser;
  late final PasswordRecoveryHandoff _handoff;
  bool _handoffAttempted = false;

  @override
  void initState() {
    super.initState();
    _browser = widget.browser ?? createPasswordRecoveryBrowser();
    _handoff = PasswordRecoveryHandoff.fromUri(widget.recoveryUri);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _browser.clearRecoveryLocation();
    });
  }

  void _openApp() {
    final appUri = _handoff.appUri;
    if (appUri == null) return;
    setState(() => _handoffAttempted = true);
    _browser.openApp(appUri);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isReady = _handoff.canOpenApp;

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
                  child: Icon(
                    isReady ? Icons.lock_reset : Icons.link_off_outlined,
                    color: scheme.primary,
                    size: 34,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  isReady ? 'Continue in CuraVault' : 'Reset link unavailable',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  isReady
                      ? 'Open the CuraVault app to choose a new password. Your recovery details stay on this device.'
                      : 'This password reset link is missing, invalid, expired, or has already been used. Return to the CuraVault app and request a new link.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.76),
                        height: 1.55,
                      ),
                  textAlign: TextAlign.center,
                ),
                if (isReady) ...[
                  const SizedBox(height: AppSpacing.lg),
                  FilledButton.icon(
                    key: const ValueKey('password-recovery-open-app'),
                    onPressed: _openApp,
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Open CuraVault'),
                  ),
                  if (_handoffAttempted) ...[
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'If CuraVault did not open, make sure the app is installed, then request a new password reset email from the app.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: scheme.onSurface.withValues(alpha: 0.68),
                            height: 1.45,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
