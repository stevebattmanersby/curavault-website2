import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:curavault_website/site/marketing_page.dart';
import 'package:curavault_website/theme.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  void _submit() {
    debugPrint('Contact form submitted (static placeholder): name=${_name.text}, email=${_email.text}');
    setState(() => _submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return MarketingPage(
      title: 'Contact',
      lead: 'This form is a static placeholder — it does not send messages yet. We can wire it later to an email service or backend.',
      children: [
        LayoutBuilder(
          builder: (context, c) {
            final twoCol = c.maxWidth >= 980;
            return twoCol
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _ContactForm(submitted: _submitted, name: _name, email: _email, message: _message, onSubmit: _submit)),
                      const SizedBox(width: 14),
                      const Expanded(child: _ContactAside()),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ContactForm(submitted: _submitted, name: _name, email: _email, message: _message, onSubmit: _submit),
                      const SizedBox(height: 14),
                      const _ContactAside(),
                    ],
                  );
          },
        ),
        const SizedBox(height: 18),
        Text(
          'If you need a data request or privacy rights request, use the dedicated page instead.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.70)),
        ),
      ],
    );
  }
}

class _ContactForm extends StatelessWidget {
  const _ContactForm({
    required this.submitted,
    required this.name,
    required this.email,
    required this.message,
    required this.onSubmit,
  });

  final bool submitted;
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController message;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Send a message', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          if (submitted)
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
                      'Submitted (placeholder). No message was actually sent.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          if (submitted) const SizedBox(height: 12),
          TextField(
            controller: name,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: message,
            minLines: 5,
            maxLines: 8,
            decoration: const InputDecoration(labelText: 'Message'),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onSubmit,
              icon: const Icon(Icons.send, color: Colors.white),
              label: const Text('Submit'),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Don’t include highly sensitive information in this placeholder form.',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.65)),
          ),
        ],
      ),
    );
  }
}

class _ContactAside extends StatelessWidget {
  const _ContactAside();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SubtleTintPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Support', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(
            'When connected, this area can include response times, support channels, or a help center link.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurface.withValues(alpha: 0.72), height: 1.55),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(AppRadius.xl),
              border: Border.all(color: scheme.outline.withValues(alpha: 0.18)),
            ),
            child: Row(
              children: [
                Icon(Icons.schedule, color: scheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Typical response time: TBD',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            kIsWeb ? 'You’re viewing the web build.' : 'You’re viewing a Flutter build.',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: scheme.onSurface.withValues(alpha: 0.65)),
          ),
        ],
      ),
    );
  }
}
