# EmployAb Website — TODO

## Quick Wins
- [x] **Mobile hamburger menu** — Added `.nav-toggle` with hamburger icon and language switcher, visible on mobile. Toggle JS on all 18 pages.
- [x] **404 page** — Created branded `404.html` (EN) and `ga/404.html` (GA) with nav, footer, and language switcher.
- [x] **Homepage logo is a div, not a link** — Changed `<div class="logo">` to `<a href="/" class="logo">` on `index.html`.

## SEO & Performance
- [ ] **Add `og:locale` tags** — `og:locale="en_IE"` on EN pages, `og:locale="ga_IE"` on GA pages.
- [ ] **Remove unused font preconnect** — `index.html` preconnects to Google Fonts but never loads a font. Wasted connection.
- [ ] **Blog content** — Only one post. Thin content sections can hurt SEO. Add 2–3 more posts or demote blog in nav.

## Conversion & Trust
- [ ] **Social proof** — The Ireland blockquote cites "EmployAb Ireland pilot research" (self-referential). Add a named advisor, university logo, or attributed quote.
- [ ] **Contact form or booking link** — All CTAs go to `mailto:`. No form, no Calendly. Lowering friction would improve conversion.
- [ ] **Modelled figures labelling** — Hero stats (89%, 6:1 ROI) are projections but not clearly labelled as such on the homepage. A small "modelled" tag would build trust.

## Technical
- [ ] **Language switcher hidden on mobile** — It lives inside `.nav-links` which is `display:none` on mobile. Needs to be visible outside the nav collapse.
- [ ] **No `<noscript>` nav fallback** — Site is nav-less without JS on small screens.
- [ ] **CSS file size** — Single 1,600+ line file, now serving 18 pages. Consider splitting into `base.css` / `pages.css` or adding a build step.

## Content / Compliance
- [ ] **Privacy page vs GTM** — Privacy page says "no cookies" but GTM is loaded on every page. GTM typically sets cookies. Verify and update.
- [ ] **Cookie consent banner** — If GTM fires tracking, GDPR requires consent before non-essential cookies. Credibility gap given "GDPR-native" positioning.
