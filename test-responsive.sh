#!/bin/bash
SITE_DIR="C:/Users/jonat/Documents/Tech/employab"
CSS="$SITE_DIR/styles.css"
PASS=0
FAIL=0

pass() { PASS=$((PASS+1)); echo "  [PASS] $1"; }
fail() { FAIL=$((FAIL+1)); echo "  [FAIL] $1"; }

echo "=============================================="
echo "  EmployAb Responsive Design Test Report"
echo "  $(date '+%Y-%m-%d %H:%M:%S')"
echo "=============================================="
echo ""

# ──────────────────────────────────────
# 1. All 5 breakpoints exist
# ──────────────────────────────────────
echo "-- 1. Breakpoint Existence --"
for bp in 1024 768 576 375; do
  count=$(grep -c "@media (max-width: ${bp}px)" "$CSS")
  if [ "$count" -ge 1 ]; then
    pass "Breakpoint ${bp}px exists ($count occurrence(s))"
  else
    fail "Breakpoint ${bp}px MISSING"
  fi
done
echo ""

# ──────────────────────────────────────
# 2. Breakpoints are in correct order (large → small)
# ──────────────────────────────────────
echo "-- 2. Breakpoint Order --"
prev_line=0
all_ordered=true
for bp in 1024 768 576 375; do
  line=$(grep -n "@media (max-width: ${bp}px)" "$CSS" | tail -1 | cut -d: -f1)
  if [ -n "$line" ] && [ "$line" -gt "$prev_line" ]; then
    pass "${bp}px at line $line (after previous)"
    prev_line=$line
  elif [ -n "$line" ]; then
    fail "${bp}px at line $line — out of order (should be after line $prev_line)"
    all_ordered=false
  fi
done
echo ""

# ──────────────────────────────────────
# 3. Nav toggle: hidden desktop, visible mobile
# ──────────────────────────────────────
echo "-- 3. Mobile Nav Toggle --"
if grep -q '\.nav-toggle' "$CSS" && grep -q 'display: none' <(grep -A2 '\.nav-toggle {' "$CSS" | head -5); then
  pass ".nav-toggle hidden by default (desktop)"
else
  fail ".nav-toggle not hidden by default"
fi

if grep -A5 '@media (max-width: 768px)' "$CSS" | grep -q '\.nav-toggle'; then
  pass ".nav-toggle displayed at 768px"
else
  fail ".nav-toggle not activated at 768px"
fi

if grep -q '\.nav-links.open' "$CSS"; then
  pass ".nav-links.open styles exist"
else
  fail ".nav-links.open styles missing"
fi
echo ""

# ──────────────────────────────────────
# 4. Nav-links hidden on mobile
# ──────────────────────────────────────
echo "-- 4. Nav Links Hidden on Mobile --"
# Check that .nav-links display:none exists inside 768px media query
found=$(awk '/@media.*768px/,/^}/' "$CSS" | grep -c '\.nav-links' )
if [ "$found" -ge 1 ]; then
  pass ".nav-links targeted in 768px breakpoint"
else
  fail ".nav-links not targeted in 768px breakpoint"
fi
echo ""

# ──────────────────────────────────────
# 5. Hero responsive — font sizes reduce at each breakpoint
# ──────────────────────────────────────
echo "-- 5. Hero Font Size Cascade --"

# Default hero h1 = 52px
default_hero=$(grep -A3 '\.hero h1 {' "$CSS" | grep 'font-size' | head -1 | grep -o '[0-9]*')

# 768px hero h1
hero_768=$(awk '/@media.*768px/,/^}/' "$CSS" | grep -A3 '\.hero h1' | grep 'font-size' | head -1 | grep -o '[0-9]*')

# 576px hero h1
hero_576=$(awk '/@media.*576px/,/^}/' "$CSS" | grep -A3 '\.hero h1' | grep 'font-size' | head -1 | grep -o '[0-9]*')

# 375px hero h1
hero_375=$(awk '/@media.*375px/,/^}/' "$CSS" | grep -A3 '\.hero h1' | grep 'font-size' | head -1 | grep -o '[0-9]*')

if [ -n "$default_hero" ]; then pass "Default hero h1: ${default_hero}px"; else fail "Default hero h1 not found"; fi
if [ -n "$hero_768" ]; then pass "768px hero h1: ${hero_768}px"; else fail "768px hero h1 not found"; fi
if [ -n "$hero_576" ]; then pass "576px hero h1: ${hero_576}px"; else fail "576px hero h1 not found"; fi
if [ -n "$hero_375" ]; then pass "375px hero h1: ${hero_375}px"; else fail "375px hero h1 not found"; fi

if [ -n "$default_hero" ] && [ -n "$hero_768" ] && [ -n "$hero_576" ] && [ -n "$hero_375" ]; then
  if [ "$default_hero" -gt "$hero_768" ] && [ "$hero_768" -gt "$hero_576" ] && [ "$hero_576" -gt "$hero_375" ]; then
    pass "Hero h1 sizes cascade: ${default_hero} > ${hero_768} > ${hero_576} > ${hero_375}"
  else
    fail "Hero h1 sizes don't cascade correctly: ${default_hero}, ${hero_768}, ${hero_576}, ${hero_375}"
  fi
fi
echo ""

# ──────────────────────────────────────
# 6. Section padding reduces on mobile
# ──────────────────────────────────────
echo "-- 6. Section Padding Reduction --"
for section in ".problem" ".solution" ".how-it-works" ".final-cta" ".universities"; do
  in_576=$(awk '/@media.*576px/,/^}/' "$CSS" | grep -c "$section")
  if [ "$in_576" -ge 1 ]; then
    pass "$section has 576px overrides"
  else
    fail "$section missing 576px padding override"
  fi
done
echo ""

# ──────────────────────────────────────
# 7. Grid layouts collapse on small screens
# ──────────────────────────────────────
echo "-- 7. Grid Collapse --"

# problem-grid should be 1fr at 768px
if awk '/@media.*768px/,/^}/' "$CSS" | grep -q '\.problem-grid'; then
  pass ".problem-grid collapses at 768px"
else
  fail ".problem-grid doesn't collapse at 768px"
fi

# solution-grid should be 1fr at 768px
if awk '/@media.*768px/,/^}/' "$CSS" | grep -q '\.solution-grid'; then
  pass ".solution-grid collapses at 768px"
else
  fail ".solution-grid doesn't collapse at 768px"
fi

# steps should be single column at 576px
if awk '/@media.*576px/,/^}/' "$CSS" | grep -q '\.steps'; then
  pass ".steps collapses at 576px"
else
  fail ".steps doesn't collapse at 576px"
fi

# trust-grid at 1024px
if awk '/@media.*1024px/,/^}/' "$CSS" | grep -q '\.trust-grid'; then
  pass ".trust-grid reduces at 1024px"
else
  fail ".trust-grid doesn't reduce at 1024px"
fi

# trust-grid at 576px
if awk '/@media.*576px/,/^}/' "$CSS" | grep -q '\.trust-grid'; then
  pass ".trust-grid reduces at 576px"
else
  fail ".trust-grid doesn't reduce at 576px"
fi

# uni-grid at 1024px
if awk '/@media.*1024px/,/^}/' "$CSS" | grep -q '\.uni-grid'; then
  pass ".uni-grid collapses at 1024px"
else
  fail ".uni-grid doesn't collapse at 1024px"
fi

# footer-grid at 768px
if awk '/@media.*768px/,/^}/' "$CSS" | grep -q '\.footer-grid'; then
  pass ".footer-grid collapses at 768px"
else
  fail ".footer-grid doesn't collapse at 768px"
fi

# ireland-grid at 768px
if awk '/@media.*768px/,/^}/' "$CSS" | grep -q '\.ireland-grid'; then
  pass ".ireland-grid collapses at 768px"
else
  fail ".ireland-grid doesn't collapse at 768px"
fi
echo ""

# ──────────────────────────────────────
# 8. Button and CTA responsive
# ──────────────────────────────────────
echo "-- 8. Button Sizing --"
if awk '/@media.*576px/,/^}/' "$CSS" | grep -q '\.btn'; then
  pass ".btn resized at 576px"
else
  fail ".btn not resized at 576px"
fi

if awk '/@media.*375px/,/^}/' "$CSS" | grep -q '\.btn'; then
  pass ".btn resized at 375px"
else
  fail ".btn not resized at 375px"
fi

if awk '/@media.*768px/,/^}/' "$CSS" | grep -q '\.hero-buttons'; then
  pass ".hero-buttons stacks at 768px"
else
  fail ".hero-buttons doesn't stack at 768px"
fi
echo ""

# ──────────────────────────────────────
# 9. Typography scales at 375px
# ──────────────────────────────────────
echo "-- 9. Small Screen Typography (375px) --"
for selector in ".hero h1" ".hero p" ".problem-card .stat" ".icp-content h3" ".trust-item h3" ".blog-hero h1" ".blog-post-header h1"; do
  escaped=$(echo "$selector" | sed 's/\./\\./g')
  if awk '/@media.*375px/,/^}/' "$CSS" | grep -q "$selector"; then
    pass "$selector sized at 375px"
  else
    fail "$selector not sized at 375px"
  fi
done
echo ""

# ──────────────────────────────────────
# 10. Container padding tightens at 375px
# ──────────────────────────────────────
echo "-- 10. Container Padding --"
if awk '/@media.*375px/,/^}/' "$CSS" | grep -q '\.container'; then
  pass ".container padding reduced at 375px"
else
  fail ".container padding not reduced at 375px"
fi
echo ""

# ──────────────────────────────────────
# 11. ICP metric cards stack on small screens
# ──────────────────────────────────────
echo "-- 11. ICP Visual Metrics --"
if awk '/@media.*768px/,/^}/' "$CSS" | grep -q '\.icp-section'; then
  pass ".icp-section collapses at 768px"
else
  fail ".icp-section doesn't collapse at 768px"
fi

if awk '/@media.*375px/,/^}/' "$CSS" | grep -q '\.icp-visual .metric'; then
  pass ".icp-visual .metric stacks at 375px"
else
  fail ".icp-visual .metric doesn't stack at 375px"
fi
echo ""

# ──────────────────────────────────────
# 12. Language switcher scales at 375px
# ──────────────────────────────────────
echo "-- 12. Language Switcher Scaling --"
if awk '/@media.*375px/,/^}/' "$CSS" | grep -q '\.lang-switcher'; then
  pass ".lang-switcher scaled at 375px"
else
  fail ".lang-switcher not scaled at 375px"
fi

if awk '/@media.*375px/,/^}/' "$CSS" | grep -q '\.nav-toggle'; then
  pass ".nav-toggle scaled at 375px"
else
  fail ".nav-toggle not scaled at 375px"
fi
echo ""

# ──────────────────────────────────────
# 13. Blog responsive
# ──────────────────────────────────────
echo "-- 13. Blog Responsive --"
for bp in 768 576 375; do
  if awk "/@media.*${bp}px/,/^}/" "$CSS" | grep -q 'blog'; then
    pass "Blog elements styled at ${bp}px"
  else
    fail "Blog elements missing at ${bp}px"
  fi
done
echo ""

# ──────────────────────────────────────
# 14. Apprenticeship section responsive
# ──────────────────────────────────────
echo "-- 14. Apprenticeship Responsive --"
if awk '/@media.*768px/,/^}/' "$CSS" | grep -q '\.apprenticeship-inner'; then
  pass ".apprenticeship-inner collapses at 768px"
else
  fail ".apprenticeship-inner doesn't collapse at 768px"
fi

if awk '/@media.*576px/,/^}/' "$CSS" | grep -q '\.apprenticeship'; then
  pass ".apprenticeship sized at 576px"
else
  fail ".apprenticeship not sized at 576px"
fi

if awk '/@media.*375px/,/^}/' "$CSS" | grep -q '\.apprenticeship-stat'; then
  pass ".apprenticeship-stat sized at 375px"
else
  fail ".apprenticeship-stat not sized at 375px"
fi
echo ""

# ──────────────────────────────────────
# 15. Hamburger on all pages
# ──────────────────────────────────────
echo "-- 15. Hamburger Menu on All Pages --"
ALL_PAGES="index.html for-universities.html for-employers.html how-it-works.html graduate-employability-ireland.html blog.html privacy.html terms.html blog/the-missing-connection-layer.html"
for page in $ALL_PAGES; do
  en="$SITE_DIR/$page"
  ga="$SITE_DIR/ga/$page"
  if grep -q 'nav-toggle' "$en" 2>/dev/null; then
    pass "$page has nav-toggle"
  else
    fail "$page missing nav-toggle"
  fi
  if [ -f "$ga" ] && grep -q 'nav-toggle' "$ga"; then
    pass "ga/$page has nav-toggle"
  elif [ -f "$ga" ]; then
    fail "ga/$page missing nav-toggle"
  fi
done

# 404 pages
for f in "$SITE_DIR/404.html" "$SITE_DIR/ga/404.html"; do
  name=$(echo "$f" | sed "s|$SITE_DIR/||")
  if [ -f "$f" ] && grep -q 'nav-toggle' "$f"; then
    pass "$name has nav-toggle"
  elif [ -f "$f" ]; then
    fail "$name missing nav-toggle"
  fi
done
echo ""

# ──────────────────────────────────────
# 16. Toggle script on all pages
# ──────────────────────────────────────
echo "-- 16. Toggle Script on All Pages --"
for page in $ALL_PAGES; do
  en="$SITE_DIR/$page"
  ga="$SITE_DIR/ga/$page"
  if grep -q 'classList.toggle' "$en" 2>/dev/null; then
    pass "$page has toggle script"
  else
    fail "$page missing toggle script"
  fi
  if [ -f "$ga" ] && grep -q 'classList.toggle' "$ga"; then
    pass "ga/$page has toggle script"
  elif [ -f "$ga" ]; then
    fail "ga/$page missing toggle script"
  fi
done

for f in "$SITE_DIR/404.html" "$SITE_DIR/ga/404.html"; do
  name=$(echo "$f" | sed "s|$SITE_DIR/||")
  if [ -f "$f" ] && grep -q 'classList.toggle' "$f"; then
    pass "$name has toggle script"
  elif [ -f "$f" ]; then
    fail "$name missing toggle script"
  fi
done
echo ""

# ──────────────────────────────────────
# SUMMARY
# ──────────────────────────────────────
TOTAL=$((PASS+FAIL))
echo "=============================================="
echo "  SUMMARY"
echo "=============================================="
echo "  Total:   $TOTAL"
echo "  Passed:  $PASS"
echo "  Failed:  $FAIL"
echo ""
if [ "$FAIL" -eq 0 ]; then
  echo "  ALL TESTS PASSED"
else
  echo "  $FAIL TEST(S) FAILED"
fi
echo "=============================================="
