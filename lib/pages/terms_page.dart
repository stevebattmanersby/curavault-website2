import 'package:flutter/material.dart';

import 'package:curavault_website/site/marketing_page.dart';
import 'package:curavault_website/theme.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return MarketingPage(
      title: 'Terms of Service (Draft)',
      lead:
          'Placeholder terms for the static marketing site. Review and update before production use.',
      children: [
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Para(
                'CuraVault is intended as a personal document and record management tool. It is not a medical device or medical service, and it does not provide medical advice.',
              ),
              _Para(
                'This marketing website is provided “as-is” for informational purposes only. Features and pricing shown here may change.',
              ),
              _Para(
                'Do not upload or submit sensitive information via placeholder forms on this site. When the product is live, submission methods and security details will be clearly documented.',
              ),
              _Para(
                'By using this site, you agree not to misuse it, attempt unauthorized access, or interfere with its operation.',
              ),
              Text(
                'Disclaimer: This draft is not legal advice and is subject to review.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.70), height: 1.6),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Para extends StatelessWidget {
  const _Para(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurface.withValues(alpha: 0.78), height: 1.65)),
    );
  }
}
