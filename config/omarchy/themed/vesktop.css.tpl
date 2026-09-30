/**
 * @name Omarchy
 * @author Omarchy
 * @description Follows the current Omarchy theme colors
 * @version 1.0.0
 */

:root,
.theme-dark,
.theme-light,
.visual-refresh {
  /* Backgrounds (classic variables) */
  --background-primary: {{ background }};
  --background-secondary: {{ dark_background }};
  --background-secondary-alt: {{ darker_background }};
  --background-tertiary: {{ darker_background }};
  --background-floating: {{ darker_background }};
  --background-nested-floating: {{ darker_background }};
  --background-mobile-primary: {{ background }};
  --background-mobile-secondary: {{ dark_background }};
  --channeltextarea-background: {{ lighter_background }};
  --modal-background: {{ background }};
  --modal-footer-background: {{ dark_background }};

  /* Backgrounds (visual refresh variables) */
  --background-base-lowest: {{ darker_background }};
  --background-base-lower: {{ dark_background }};
  --background-base-low: {{ dark_background }};
  --background-surface-high: {{ background }};
  --background-surface-higher: {{ lighter_background }};
  --background-surface-highest: {{ lighter_background }};
  --bg-base-primary: {{ background }};
  --bg-base-secondary: {{ dark_background }};
  --bg-base-tertiary: {{ darker_background }};
  --chat-background-default: {{ background }};
  --input-background: {{ lighter_background }};

  /* Hover / selection */
  --background-modifier-hover: color-mix(in srgb, {{ selection }} 40%, transparent);
  --background-modifier-active: color-mix(in srgb, {{ selection }} 60%, transparent);
  --background-modifier-selected: color-mix(in srgb, {{ selection }} 70%, transparent);
  --background-modifier-accent: color-mix(in srgb, {{ muted }} 50%, transparent);
  --border-subtle: color-mix(in srgb, {{ muted }} 40%, transparent);
  --border-faint: color-mix(in srgb, {{ muted }} 25%, transparent);

  /* Text */
  --text-normal: {{ foreground }};
  --text-default: {{ foreground }};
  --text-strong: {{ bright_foreground }};
  --text-muted: {{ dark_foreground }};
  --text-subtle: {{ dark_foreground }};
  --header-primary: {{ bright_foreground }};
  --header-secondary: {{ light_foreground }};
  --channels-default: {{ dark_foreground }};
  --channel-icon: {{ dark_foreground }};
  --text-link: {{ blue }};
  --text-brand: {{ accent }};

  /* Interactive elements */
  --interactive-normal: {{ light_foreground }};
  --interactive-hover: {{ bright_foreground }};
  --interactive-active: {{ bright_foreground }};
  --interactive-muted: {{ muted }};
  --icon-default: {{ light_foreground }};
  --icon-strong: {{ bright_foreground }};
  --icon-muted: {{ dark_foreground }};

  /* Accent */
  --brand-500: {{ accent }};
  --brand-560: {{ mix accent background 15% }};
  --brand-experiment: {{ accent }};
  --brand-experiment-560: {{ mix accent background 15% }};
  --button-filled-brand-background: {{ accent }};
  --button-filled-brand-background-hover: {{ mix accent background 15% }};
  --button-filled-brand-text: {{ background }};
  --control-brand-foreground: {{ accent }};
  --mention-foreground: {{ accent }};
  --mention-background: color-mix(in srgb, {{ accent }} 20%, transparent);

  /* Status */
  --status-positive: {{ green }};
  --status-warning: {{ yellow }};
  --status-danger: {{ red }};
  --text-positive: {{ green }};
  --text-warning: {{ yellow }};
  --text-danger: {{ red }};
}

::selection {
  background: {{ selection_background }};
}
