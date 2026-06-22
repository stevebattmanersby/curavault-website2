import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:curavault_website/site/marketing_page.dart';
import 'package:curavault_website/theme.dart';

class DataRequestPage extends StatefulWidget {
  const DataRequestPage({super.key});

  @override
  State<DataRequestPage> createState() => _DataRequestPageState();
}

class _DataRequestPageState extends State<DataRequestPage> {
  final _email = TextEditingController();
  final _details = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _email.dispose();
    _details.dispose();
    super.dispose();
  }

  void _submit() {
    debugPrint('Data request submitted (static placeholder): email=${_email.text}');
    setState(() => _submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return MarketingPage(
      title: 'Data Requests / Privacy Rights (Draft)',
      lead:
          'Use this page to describe how users can request access, correction, export, or deletion of their data. This is a static placeholder for now.',
      children: [
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Request types', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              const _Bullet('Access: what data we have about you (when applicable).'),
              const _Bullet('Correction: fix inaccurate details.'),
              const _Bullet('Export: receive a copy of your data (format TBD).'),
              const _Bullet('Deletion: remove your account data (where applicable).'),
              const SizedBox(height: 14),
              Text(
                'Disclaimer: This is not legal advice. Final processes and timelines must be defined and reviewed.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.72), height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SubtleTintPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Request form (placeholder)', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              if (_submitted)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    color: scheme.primary.withValues(alpha: 0.10),
                    border: Border.all(color: scheme.primary.withValues(alpha: 0.20)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: scheme.primary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Submitted (placeholder). No request was actually sent.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              if (_submitted) const SizedBox(height: 12),
              TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email'), keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 12),
              TextField(
                controller: _details,
                minLines: 4,
                maxLines: 8,
                decoration: const InputDecoration(labelText: 'Request details (type, country/region, context)'),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.send, color: Colors.white),
                  label: const Text('Submit request'),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                kIsWeb ? 'Static web placeholder.' : 'Static placeholder.',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.65)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 8, color: scheme.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.55))),
        ],
      ),
    );
  }
}
