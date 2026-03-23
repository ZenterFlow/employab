# EmployAb Website - TODO

## Done
- [x] **Mobile hamburger menu** - Nav-toggle with hamburger icon and language switcher on all 20 pages.
- [x] **404 page** - Branded `404.html` (EN) and `ga/404.html` (GA).
- [x] **Homepage logo clickable** - Changed `<div>` to `<a href="/">`.
- [x] **Bilingual (ga-IE)** - Full Irish translation of all 9 pages under `/ga/`, hreflang tags, language switcher, sitemap updated.
- [x] **Responsive breakpoints** - Added 576px and 375px breakpoints (now 5 total: 1024/768/576/375 + default).
- [x] **Language switcher visible on mobile** - Switcher sits inside nav-toggle, visible outside the collapsed nav.
- [x] **Cookie consent banner** - GDPR-compliant banner on all 20 pages. GTM only loads after acceptance. Bilingual (EN/GA). Consent stored in localStorage.
- [x] **og:locale tags** - `en_IE` on all EN pages, `ga_IE` on all GA pages.
- [x] **Remove unused font preconnect** - Removed from index.html.
- [x] **Skip-to-content link** - Added to all 20 pages (EN: "Skip to content", GA: "Scipeail chuig an bpriomhabhar").
- [x] **Hamburger accessibility** - aria-expanded, Escape-to-close on all 20 pages.
- [x] **Privacy page vs GTM** - Updated cookies section to describe consent-based GTM loading. Both EN and GA pages updated.

## SEO & Performance
- [ ] **Blog content** - Only one post. Thin content hurts SEO. Add 2-3 more posts or demote blog in nav until there's more.
- [ ] **Image optimisation** - No images on the site beyond favicons/OG. Adding hero images or illustrations would improve engagement and OG card appearance.
- [ ] **Structured data for Irish pages** - Schema.org JSON-LD is English-only. Consider adding `inLanguage: "ga"` to GA page schemas.

## Conversion & Trust
- [ ] **Social proof** - Ireland blockquote cites "EmployAb Ireland pilot research" (self-referential). Add a named advisor, university logo, or attributed quote.
- [ ] **Contact form or booking link** - All CTAs go to `mailto:`. No form, no Calendly. A booking link or embedded form would lower friction.
- [ ] **Modelled figures labelling** - Hero stats (89%, 6:1 ROI) are projections but not labelled as such on the homepage hero. A small "modelled" or "projected" tag builds trust.
- [ ] **Testimonials section** - No real testimonials anywhere. Even early-stage quotes from pilot conversations would add credibility.
- [ ] **Lead magnet** - No way to capture interest beyond email. A "Get our Ireland Graduate Report" PDF download or newsletter signup would build a list.

## Technical
- [ ] **CSS file size** - Now 2,000+ lines serving 20 pages. Consider splitting into `base.css` / `components.css` or adding a build step.
- [ ] **Minification** - No CSS or HTML minification. A build step (even a simple one) would reduce payload.
- [ ] **Cache headers** - `vercel.json` has security headers but no explicit cache-control for static assets (CSS, images, favicons).
- [ ] **Accessibility audit** - Run Lighthouse/axe. Check colour contrast on dark sections and focus management.

## Content / Compliance
- [ ] **Irish translation review** - Machine-assisted translations should be reviewed by a native Irish speaker for natural phrasing, especially legal pages.

## Nice to Have
- [ ] **FostAb branding** - Consider using "FostAb" as the Irish brand name on `/ga/` pages (see memory: gaelic brand wordplay).
- [ ] **Dark mode** - `prefers-color-scheme` support. The navy/teal palette adapts well to dark.
- [ ] **Page transitions** - Smooth scroll and subtle fade-in animations on section entry.
- [ ] **RSS feed** - For the blog, once there's more content.
- [ ] **Open Graph images per page** - All pages share one OG image. Unique images per page improve social sharing.
