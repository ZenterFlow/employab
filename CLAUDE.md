# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Static marketing website for **EmployAb** - a white-label graduate employability platform for European universities. Bilingual (English + Irish/Gaeilge). Deployed on Vercel.

## Tech Stack

Vanilla HTML/CSS/JavaScript - no frameworks, no package.json, no bundler. Three JS modules:
- `theme.js` - dark/light mode toggle with localStorage + system preference detection
- `animations.js` - scroll fade-in via Intersection Observer, respects prefers-reduced-motion
- `consent.js` - GDPR cookie consent, loads GTM only after acceptance

## Build & Deploy

Hosted on Vercel. Build command (from vercel.json):
```
npx -y clean-css-cli -o styles.css styles.css && npx -y terser consent.js -o consent.js -c -m
```
Source files stay readable in git; minification happens at deploy time. No local build step needed for development.

## Bilingual Architecture

Every page exists in two versions:
- English: root (`/index.html`, `/for-universities.html`, etc.)
- Irish: `/ga/` directory mirrors root (`/ga/index.html`, `/ga/for-universities.html`, etc.)

**When editing any page, the corresponding translation must also be updated.** All pages have hreflang tags linking EN/GA variants. HTML `lang` attribute is `en` at root, `ga` under `/ga/`.

Total: 20 pages (9 main pages x 2 languages + 1 blog post x 2 + 404 x 2).

## Styling

Single `styles.css` file. Dark mode uses `html.dark` selector. Five responsive breakpoints: 1024px, 768px, 576px, 375px, and default. Mobile navigation uses a hamburger toggle with aria-expanded and Escape-to-close.

## Accessibility

WCAG 2.1 AA compliant. All pages have: skip-to-content link, semantic HTML, aria-labels, keyboard navigation, structured data (JSON-LD). Dark mode colours have been contrast-audited.

## SEO

Each page has JSON-LD structured data (Organization, WebSite, BreadcrumbList). Irish pages use `inLanguage: "ga"`. Sitemap at `/sitemap.xml`, robots at `/robots.txt`. Vercel config uses `cleanUrls: true` (no .html in URLs).

## External Integrations

- **Google Tag Manager**: GTM-MJNQLPJT, consent-gated via consent.js
- **Calendly**: All CTA buttons link to calendly.com/meet-employab
- **Beehiiv**: Newsletter signup forms (form action placeholder)
