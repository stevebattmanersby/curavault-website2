import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:curavault_website/nav.dart';
import 'package:curavault_website/site/marketing_page.dart';
import 'package:curavault_website/site/widgets.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketingPage(
      title: 'FAQ',
      lead: 'Practical answers about scope, privacy wording, and what’s live on this static site.',
      children: [
        const SizedBox(height: 6),
        const _FaqList(),
        const SizedBox(height: 18),
        SectionCard(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Still have questions?', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text('Send us a message — forms are placeholders for now, but we can refine the copy and flow.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.55)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: () => context.go(AppRoutes.contact),
                child: const Text('Contact'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FaqList extends StatelessWidget {
  const _FaqList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        FaqItem(
          question: 'Is CuraVault a medical service?',
          answer:
              'No. CuraVault is intended as a personal document and record management tool. It does not diagnose conditions, recommend treatment, or replace professional advice.',
        ),
        SizedBox(height: 12),
        FaqItem(
          question: 'Do you claim HIPAA compliance?',
          answer:
              'We avoid unverified compliance claims. Wording like “privacy-first” and “designed with security in mind” is intentional, and any compliance statements should be reviewed by qualified professionals.',
        ),
        SizedBox(height: 12),
        FaqItem(
          question: 'Is there a backend, login, or billing connected?',
          answer:
              'Not yet. This marketing site is static: no Firebase/Supabase, no Stripe, no newsletter backend, and no authentication is connected.',
        ),
        SizedBox(height: 12),
        FaqItem(
          question: 'Can I request deletion of my account data?',
          answer:
              'Yes — see the Account Deletion page for the intended process. As the product evolves, this will be updated to match the actual data flows.',
        ),
      ],
    );
  }
}
