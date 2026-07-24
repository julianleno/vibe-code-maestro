# Singular Studio Criativo — Design System

> Sistema visual para site, landing pages, propostas, catálogos, formulários de orçamento, dashboards comerciais e campanhas digitais da Singular Studio Criativo.

## 1. Brand foundation

### Brand
- **Name:** Singular Studio Criativo
- **Market:** B2B corporate gifts, personalized kits, corporate stationery and branded materials
- **Region:** Fortaleza, Ceará, with service and shipping across Brazil
- **Language:** Brazilian Portuguese (`pt-BR`)
- **Positioning:** A creative B2B studio that transforms personalized products into professional brand experiences.
- **Core promise:** Everything delivered by Singular must look intentional, polished and ready to represent the client’s brand.
- **Brand idea:** Menos brinde. Mais marca.

### Personality
- Creative
- Precise
- Confident
- Commercial
- Slightly bold
- Colorful without looking childish
- Premium without becoming cold or inaccessible

### Brand principles
1. **Criatividade aplicada:** visual impact must support a real commercial objective.
2. **Personalização com estratégia:** the client’s brand is the protagonist.
3. **Execução profissional:** finish, organization and delivery quality must be visible.
4. **Clareza comercial:** each page or piece should have one main message and one main CTA.
5. **Cuidado percebido:** details, packaging and presentation increase perceived value.

## 2. Visual direction

### Creative direction
Use a vibrant editorial identity with corporate precision. Combine large serif headlines, clean sans-serif UI typography, strong color blocks, generous negative space, asymmetrical compositions and controlled graphic accents.

The visual result should feel like a brand campaign, not a generic promotional-products catalog.

### Keywords
`vibrant` · `editorial` · `corporate` · `bold` · `clean` · `premium` · `human` · `conversion-focused`

## 3. Color system

### Proprietary colors

| Token | Hex | Role |
|---|---:|---|
| `brand-blue` | `#0060E6` | Primary brand color; trust, impact, technology |
| `brand-pink` | `#FF4DB7` | Creative energy, campaigns and expressive accents |
| `brand-yellow` | `#FFD900` | Highlight, signature detail and controlled accent |
| `brand-obsidian` | `#050505` | Contrast, premium foundation and strong CTA |
| `brand-white` | `#FFFFFF` | Space, clarity and contrast |

### Supporting UI neutrals

| Token | Hex | Role |
|---|---:|---|
| `surface-warm` | `#F7F3EC` | Warm editorial background |
| `surface-soft` | `#F5F5F3` | Secondary surface |
| `border-light` | `#DEDEDA` | Dividers and input borders |
| `text-muted` | `#686868` | Secondary text |
| `text-strong` | `#151515` | Main text on light surfaces |
| `blue-dark` | `#004DB8` | Hover and active state for blue |
| `pink-dark` | `#D92E91` | Hover and dark accent state |

### Color usage rule
Use the **70 / 20 / 10 rule**:
- 70% clean base or one dominant color
- 20% contrast
- 10% pink or yellow accent

Never give blue, pink and yellow equal visual weight in the same composition. Yellow is a signature accent, not the main background for an entire interface.

### Preferred combinations
- Blue + White + Yellow
- Obsidian + Blue + Pink
- Warm surface + Blue + Pink
- White + Obsidian + Blue

### Accessibility combinations
- White text on Blue
- White text on Obsidian
- Obsidian text on Yellow
- Obsidian text on Pink
- Obsidian text on White or warm surfaces

Avoid small white text on Pink. Maintain WCAG AA contrast for interface text and controls.

## 4. Typography

### Font families

#### Display / campaign typography
- **Primary:** `Fraunces`
- **Weights:** 700, 800, 900
- **Fallback:** `Georgia`, serif
- **Use:** H1, campaign headlines, editorial openings, short statements

#### UI / body typography
- **Primary:** `Inter`
- **Weights:** 400, 500, 600, 700, 800
- **Fallback:** system-ui, sans-serif
- **Use:** body copy, forms, navigation, cards, buttons, tables and dashboards

### Type scale

| Token | Size | Line height | Weight | Font |
|---|---:|---:|---:|---|
| `display-xl` | clamp(3.5rem, 7vw, 7.5rem) | 0.92 | 900 | Fraunces |
| `display-lg` | clamp(2.75rem, 5vw, 5.5rem) | 0.96 | 800 | Fraunces |
| `h1` | clamp(2.5rem, 4vw, 4.5rem) | 1.00 | 800 | Fraunces |
| `h2` | clamp(2rem, 3vw, 3.25rem) | 1.05 | 800 | Fraunces or Inter |
| `h3` | 1.75rem | 1.15 | 700 | Inter |
| `h4` | 1.25rem | 1.25 | 700 | Inter |
| `body-lg` | 1.125rem | 1.65 | 400 | Inter |
| `body` | 1rem | 1.60 | 400 | Inter |
| `body-sm` | 0.875rem | 1.50 | 400 | Inter |
| `label` | 0.8125rem | 1.30 | 700 | Inter |
| `button` | 0.875rem | 1.00 | 800 | Inter |

### Typography rules
- Use large serif headlines in short blocks.
- Use sans-serif for clarity, conversion and dense information.
- Buttons should use bold or extra-bold sans-serif.
- Uppercase is allowed for short labels, eyebrow text and CTAs, not long paragraphs.
- Do not imitate the logo typography in every heading.
- Avoid more than two font families in one product.

## 5. Layout system

### Grid
- Desktop: 12-column grid
- Tablet: 8-column grid
- Mobile: 4-column grid
- Maximum content width: `1280px`
- Standard reading width: `720px`
- Wide campaign section: up to `1440px`

### Page gutters
- Mobile: `20px`
- Tablet: `32px`
- Desktop: `48px`
- Large desktop: `64px`

### Section spacing
- Mobile: `64px` to `88px`
- Desktop: `96px` to `144px`
- Hero sections may use `160px` vertical spacing on large screens

### Composition rules
- Prefer asymmetrical layouts with deliberate balance.
- Use generous margins and visible breathing room.
- Align content to a clear grid.
- Use centered layouts only for institutional signatures, simple confirmations or focused CTA sections.
- Avoid centering every section by default.
- One section should communicate one main idea.

## 6. Spacing tokens

Use a 4px base unit.

| Token | Value |
|---|---:|
| `space-1` | 4px |
| `space-2` | 8px |
| `space-3` | 12px |
| `space-4` | 16px |
| `space-5` | 20px |
| `space-6` | 24px |
| `space-8` | 32px |
| `space-10` | 40px |
| `space-12` | 48px |
| `space-16` | 64px |
| `space-20` | 80px |
| `space-24` | 96px |
| `space-32` | 128px |

## 7. Shape, borders and elevation

### Radius
| Token | Value | Use |
|---|---:|---|
| `radius-sm` | 8px | tags, compact inputs |
| `radius-md` | 12px | buttons and controls |
| `radius-lg` | 20px | cards and media |
| `radius-xl` | 28px | hero cards and campaign blocks |
| `radius-pill` | 999px | badges and pills |

### Borders
- Standard border: `1px solid #DEDEDA`
- Strong border: `1px solid #151515`
- Brand border: `2px solid #0060E6`
- Avoid decorative borders without a functional or compositional reason.

### Shadows
Use shadows only to create physical depth in UI or product imagery.

- `shadow-sm`: `0 4px 14px rgba(5, 5, 5, 0.08)`
- `shadow-md`: `0 16px 40px rgba(5, 5, 5, 0.12)`
- `shadow-product`: realistic, soft and directional

Never apply shadow, bevel, glow or outline to the logo.

## 8. Graphic language

### Core elements
- Solid color blocks
- Circular accent inspired by the brand punctuation mark
- Small yellow signature details
- Editorial serif headlines at large scale
- Strong, simple CTA bars
- Controlled lines, frames and crop marks

### Brand signal
The punctuation/accent symbol may appear as:
- Bullet
- Sticker
- Quality seal
- Section marker
- Hover detail
- Loading or progress indicator
- Short motion accent

Do not turn the symbol into a mascot or repeat it until it becomes visual noise.

## 9. Logo rules

### Clear space
- Minimum clear space: `1.5X` on all sides
- Premium applications: `2X`
- `X` equals the height of the brand accent/punctuation mark

### Minimum size
- Complete logo with descriptor: minimum `220px` wide in digital
- Print: minimum `45mm` wide
- Below this size, use the Singular wordmark without “Studio Criativo”

### Approved behavior
- Use the full-color version on clear or neutral surfaces.
- Use the reversed white version on Blue or Obsidian.
- Use the Pink version only in expressive campaign contexts.
- Protect the logo when placed over photography.

### Forbidden behavior
- No stretching, condensing, rotation or skewing
- No shadows, bevels, glows or outlines
- No random recoloring
- No recreation of the descriptor with another font
- No placement over cluttered photography without a solid protection area

## 10. Photography direction

### Desired photography
- Real products and real kits
- Macro texture and material detail
- Hands in action when useful
- Finished kit and packaging
- Production volume and organized repetition
- Side lighting and real shadows
- Solid backgrounds from the brand palette
- Clean framing with visible finishing quality

### Commercial objective
Images must prove:
- Organization
- Scale
- Standardization
- Material quality
- Finish quality
- Presentation readiness

### Avoid
- Generic stock photography
- Product floating without scale or context
- Old-fashioned catalog layouts
- Messy workspaces
- Excess decorative props
- Inconsistent mockup shadows
- Filters that distort real product colors

## 11. Iconography

- Use simple outline icons with consistent stroke width.
- Prefer rounded geometric construction.
- Use icons to clarify actions, not to decorate every title.
- Default size: 20px or 24px.
- Use Blue or Obsidian as default icon colors.
- Use Pink or Yellow only as controlled highlights.

## 12. Components

### Buttons

#### Primary button
- Background: `brand-blue`
- Text: White
- Height: 48px minimum
- Radius: 12px or pill for campaign CTAs
- Font: Inter 800
- Hover: `blue-dark`
- Focus: visible 3px focus ring

#### Dark button
- Background: `brand-obsidian`
- Text: White or Yellow for short campaign CTAs
- Hover: Blue

#### Secondary button
- Transparent or White background
- Text and border: Obsidian
- Hover background: `surface-soft`

#### Accent button
- Background: Yellow
- Text: Obsidian
- Use sparingly for one high-priority action

#### Button copy
Prefer:
- Solicitar cotação
- Chamar no WhatsApp
- Montar meu kit
- Pedir sugestão
- Falar com atendimento corporativo

Avoid vague labels such as “Saiba mais” when a specific action is possible.

### Inputs and forms
- Label always visible above the field
- Input height: 48px to 52px
- Textarea minimum height: 120px
- Radius: 12px
- Border: light neutral; Blue focus state
- Error message directly below the field
- Do not rely on placeholder as the only label
- Group long forms into logical steps
- Show progress when more than one step is required

### Cards
- Use clear hierarchy: eyebrow, title, short description, action
- Default padding: 24px to 32px
- Use White or warm surface backgrounds
- Use one brand accent per card, not all colors at once
- Product cards should prioritize the image and product context
- Avoid excessive shadow and glassmorphism

### Badges and tags
- Pill shape
- Compact padding
- Inter 700, 12px to 13px
- Use Blue, Obsidian or neutral variants by default
- Pink and Yellow are reserved for highlights

### Navigation
- Keep the top navigation simple and commercially focused.
- Main CTA should remain visible on desktop.
- Mobile menu must preserve a direct WhatsApp or quotation action.
- Avoid mega menus unless product complexity requires them.

### Tables
- Use Inter for all table content.
- Keep headers high-contrast and sticky when useful.
- Use zebra striping only for dense operational tables.
- Prices, quantities and totals must align consistently.
- Highlight totals using Blue or Obsidian, not multiple accent colors.

### Alerts and status
- Success: Blue or dark neutral with a clear success icon
- Warning: Yellow with Obsidian text
- Error: use a dedicated accessible red, not Pink
- Information: light Blue surface with Blue text

## 13. Page patterns

### Commercial landing page
1. Navigation with primary CTA
2. Hero with one strong promise
3. Trust and proof
4. Solutions by business objective
5. Real portfolio or kit gallery
6. Differentiators
7. Process
8. Testimonials
9. Quote CTA
10. FAQ
11. Footer with direct contact

### Hero pattern
- Eyebrow in Inter bold
- Large Fraunces headline
- Short supporting paragraph
- One primary CTA and one optional secondary CTA
- Real product image or clean campaign composition
- One controlled Pink or Yellow accent

### Quote flow
- Ask only the information needed to qualify the project.
- Prioritize company, objective, product, quantity, deadline and destination.
- Keep WhatsApp as a direct continuation of the process.
- Make the next step explicit.

### Proposal and catalog
- Editorial cover
- Project summary
- Kit or product options
- Clear price table
- Timeline and commercial terms
- Strong final CTA
- Use real photography whenever available

## 14. Voice and copy

### Voice
- Direct
- Consultative
- Confident
- Professional
- Human
- Commercially clear

### Writing principles
- Lead with the business result, not the manufacturing technique.
- Use short sentences and concrete claims.
- Explain value before price.
- Make quantity, deadline and next action clear.
- Avoid exaggerated adjectives without proof.
- Avoid childish language and generic motivational copy.

### Recommended messages
- Kits corporativos com acabamento profissional.
- Brindes para eventos, equipes e clientes.
- Personalizados B2B com suporte de arte.
- Sua marca impressa com presença.
- Brinde genérico não gera memória. Experiência bem feita gera conexão.
- Menos brinde. Mais marca.

## 15. Motion

### UI motion
- Duration: 150ms to 220ms
- Easing: `cubic-bezier(0.2, 0.8, 0.2, 1)`
- Use motion for hierarchy, feedback and orientation.
- Respect `prefers-reduced-motion`.

### Brand motion sequence
Standard sequence, approximately 3 seconds:
1. Blue block enters
2. Yellow accent appears
3. Serif headline reveals
4. CTA and logo close the sequence

Avoid random template transitions, excessive bouncing or decorative animation without purpose.

## 16. Responsive behavior

### Breakpoints
- `sm`: 480px
- `md`: 768px
- `lg`: 1024px
- `xl`: 1280px
- `2xl`: 1536px

### Rules
- Preserve hierarchy before decorative composition.
- Stack asymmetric layouts cleanly on mobile.
- Keep CTAs at least 44px high.
- Avoid tiny serif headlines on mobile; reduce scale but preserve weight.
- Product images should remain large enough to show finish and detail.
- Horizontal tables should become cards or scroll containers.

## 17. Accessibility

- Target WCAG 2.2 AA.
- All interactive elements require visible focus states.
- Minimum touch target: 44 × 44px.
- Do not communicate meaning through color alone.
- Provide alt text for product and process images.
- Use semantic headings in order.
- Form errors must be announced and associated with fields.
- Never place important copy over busy photography without a protected surface.

## 18. Do / Don’t

### Do
- Use bold color with discipline
- Create visual hierarchy through scale and contrast
- Show real product quality
- Keep layouts spacious and commercially focused
- Use one main CTA per section
- Use the brand accent as a controlled signature

### Don’t
- Use Blue, Pink and Yellow with equal weight
- Fill every empty area with decoration
- Center everything by default
- Use generic mockups as the main visual proof
- Turn the identity into a playful children’s brand
- Use weak pastel backgrounds as the dominant system
- Make the logo compete with the sales message

## 19. Design review checklist

Before approving a page or asset, confirm:
- Is the main message understood in five seconds?
- Is there one clear primary action?
- Does the composition feel intentional rather than template-based?
- Is the product or service shown with real commercial proof?
- Is the color hierarchy controlled?
- Is the typography readable and consistent?
- Does the asset look B2B, premium and operationally credible?
- Does it feel like Singular, not a generic gift shop?
