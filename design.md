# Zustand DevTools design system

The site is a product workbench with a poster-like opening. Its identity is calm
precision: the page makes one state transition feel visible and understandable.

## Palette

- Midnight canvas `#0d0b1f`; dark raised surfaces `#17132f` and `#100d24`.
- Violet is the single brand signal: solid `#4f46e5`, readable accent `#a89cff`.
- Off-white `#f8f7fc`, secondary lavender-grey `#d7d3e4`, fine violet rules.
- Green and red appear only in semantic added/removed state values.

## Type

- Display: self-hosted Bricolage Grotesque, upright, tightly tracked. Short,
  oversized statements are the architecture of the marketing page.
- Body and controls: platform system sans for Apple-like legibility and restraint.
- Technical labels, code, state paths and timestamps: self-hosted JetBrains Mono.

## Composition

- Marketing: monumental opening statement, then an interactive product workbench
  spanning the page. Lower chapters vary between open editorial layouts, a wide
  dark-violet Trace Session field, and compact practical setup/support content.
- Guides: restrained single-column reading layout using the same palette, display
  face and control style. The sample app is a practical workbench, not an ad.
- No fabricated metrics, testimonials, random gradients, fake browser chrome, or
  ambient motion.

## Interaction

- Violet highlights the changed path and the active action. Motion shows cause
  and effect, never decorates idle content.
- Controls have visible keyboard focus, immediate pressed states and 44px touch
  targets. Reduced-motion users see the full page without reveal dependencies.
- Preserve working demo controls, setup copy actions, pricing, privacy copy,
  guide routes, legal pages, and the existing free/Pro distinction.

## CTA voice

- Primary: solid violet, rectangular with a small radius, direct action language.
- Secondary: clear text or an outlined surface. Every CTA names its destination.

## Responsive behavior

- At 320/375/414px the hero becomes a short statement followed by the interactive
  app and panel stacked in causal order. Navigation remains accessible. Code
  scrolls inside its own region; the page itself never scrolls horizontally.
