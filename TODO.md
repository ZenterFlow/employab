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
- [x] **Structured data for Irish pages** - Added `inLanguage: "ga"` to all 7 GA page JSON-LD blocks. Fixed mispointed URLs.

## Conversion & Trust
- [ ] **Social proof** - Ireland blockquote cites "EmployAb Ireland pilot research" (self-referential). Add a named advisor, university logo, or attributed quote.
- [x] **Contact form or booking link** - All CTA buttons now link to calendly.com/meet-employab (opens new tab). Footer emails kept as mailto.
- [ ] **Modelled figures labelling** - Hero stats (89%, 6:1 ROI) are projections but not labelled as such on the homepage hero. A small "modelled" or "projected" tag builds trust.
- [ ] **Testimonials section** - No real testimonials anywhere. Even early-stage quotes from pilot conversations would add credibility.
- [x] **Lead magnet** - Newsletter signup section on 10 main pages (EN + GA). Beehiiv form action placeholder ready to update.

## Technical
- [x] **Cache headers** - Added cache-control headers in vercel.json: immutable for CSS/JS/images, must-revalidate for HTML.
- [x] **Minification** - Vercel build command minifies CSS (clean-css) and JS (terser) during deployment. Source stays readable in git.
- [x] **CSS file size** - Kept as single file (2,177 lines). Splitting adds maintenance overhead for marginal benefit at this scale. Well-organised with section comments.
- [x] **Accessibility audit** - Ran WCAG 2.1 contrast audit on all 19 colour pairs. Fixed 2 failures: red stat text (#dc2626 to #c81e1e), light gray text (#9ca3af to #6b7280). All 19 pairs now pass AA.

## Content / Compliance
- [ ] **Irish translation review** - Machine-assisted translations should be reviewed by a native Irish speaker for natural phrasing, especially legal pages.

## Nice to Have
- [ ] **FostAb branding** - Consider using "FostAb" as the Irish brand name on `/ga/` pages (see memory: gaelic brand wordplay).
- [x] **Dark mode** - Full prefers-color-scheme support. All sections, cards, text, forms styled for dark backgrounds.
- [x] **Page transitions** - Scroll fade-in animations on all sections. Smooth scroll. Respects prefers-reduced-motion.
- [ ] **RSS feed** - For the blog, once there's more content.
- [ ] **Open Graph images per page** - All pages share one OG image. Unique images per page improve social sharing.
