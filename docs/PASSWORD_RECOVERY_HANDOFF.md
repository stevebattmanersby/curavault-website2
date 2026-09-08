# Password Recovery Handoff

## Current flow

CuraVault requests password recovery through Supabase Auth with
`https://www.curavault.io/reset-password` as the redirect destination. The
consumer app uses Supabase's PKCE flow, so the website receives a short-lived,
single-use authorization code after Supabase verifies the email link.

The landing page:

1. accepts only the Supabase recovery fields needed by the consumer app;
2. removes query and fragment material from the visible browser URL;
3. keeps the accepted values in memory only;
4. offers a handoff to the existing `curavault://reset-password` app route; and
5. shows a generic failure state for missing, malformed, expired, or used links.

The page does not initialize Supabase, exchange credentials, store a browser
session, collect a new password, or send recovery material to analytics.
Netlify serves the route with `Cache-Control: no-store` and
`Referrer-Policy: no-referrer`.

## Required external configuration

- Add `https://www.curavault.io/reset-password` to the Supabase Auth allowed
  redirect URLs.
- Keep the app's `curavault://reset-password` handler while it is required as a
  fallback.
- For Android App Links, add a verified HTTPS intent filter for
  `www.curavault.io/reset-password` and host the matching
  `/.well-known/assetlinks.json` file.
- For iOS Universal Links, add `applinks:www.curavault.io` to Associated Domains
  and host the matching `/.well-known/apple-app-site-association` file.

Until the Android and iOS verified-link configuration is deployed and tested,
the website's explicit **Open CuraVault** action performs the custom-scheme
handoff. Verified HTTPS links should become the primary mobile handoff when the
platform configuration is available.
