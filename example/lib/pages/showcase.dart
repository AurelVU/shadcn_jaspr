import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:universal_web/web.dart' as web;
import 'package:shadcn_jaspr/shadcn_jaspr.dart';

class ShowcasePage extends StatefulComponent {
  const ShowcasePage({super.key});

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  bool _isDark = false;

  void _toggleTheme() {
    setState(() {
      _isDark = !_isDark;
    });
    web.document.documentElement?.classList.toggle('dark');
  }

  @override
  Component build(BuildContext context) {
    return div(
      [
        // Header
        div(
          [
            div(
              [
                div(
                  [
                    h1([Component.text('shadcn_jaspr')],
                        classes: 'text-4xl font-bold tracking-tight'),
                    ShadBadge([Component.text('70+ components')],
                        variant: BadgeVariant.secondary),
                  ],
                  classes: 'flex items-center gap-3',
                ),
                ShadButton(
                  [
                    Component.element(
                      tag: 'svg',
                      attributes: {
                        'xmlns': 'http://www.w3.org/2000/svg',
                        'width': '16',
                        'height': '16',
                        'viewBox': '0 0 24 24',
                        'fill': 'none',
                        'stroke': 'currentColor',
                        'stroke-width': '2',
                        'stroke-linecap': 'round',
                        'stroke-linejoin': 'round',
                      },
                      children: _isDark
                          ? [
                              Component.element(tag: 'circle', attributes: {
                                'cx': '12',
                                'cy': '12',
                                'r': '4',
                              }),
                              Component.element(
                                  tag: 'path', attributes: {'d': 'M12 2v2'}),
                              Component.element(
                                  tag: 'path', attributes: {'d': 'M12 20v2'}),
                              Component.element(
                                  tag: 'path',
                                  attributes: {'d': 'm4.93 4.93 1.41 1.41'}),
                              Component.element(
                                  tag: 'path',
                                  attributes: {'d': 'm17.66 17.66 1.41 1.41'}),
                              Component.element(
                                  tag: 'path', attributes: {'d': 'M2 12h2'}),
                              Component.element(
                                  tag: 'path', attributes: {'d': 'M20 12h2'}),
                              Component.element(
                                  tag: 'path',
                                  attributes: {'d': 'm6.34 17.66-1.41 1.41'}),
                              Component.element(
                                  tag: 'path',
                                  attributes: {'d': 'm19.07 4.93-1.41 1.41'}),
                            ]
                          : [
                              Component.element(tag: 'path', attributes: {
                                'd': 'M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z',
                              }),
                            ],
                    ),
                    Component.text(_isDark ? 'Light' : 'Dark'),
                  ],
                  variant: ButtonVariant.outline,
                  size: ButtonSize.sm,
                  onPressed: _toggleTheme,
                ),
              ],
              classes: 'flex items-center justify-between',
            ),
            p([
              Component.text(
                  'A Dart port of shadcn/ui for Jaspr — 60 components + 4 chart types + 10 auth blocks')
            ], classes: 'text-lg text-muted-foreground mt-2'),
          ],
          classes: 'mb-8',
        ),

        // Tabs navigation
        ShadTabs(
          defaultValue: 'inputs',
          children: [
            ShadTabsList([
              ShadTabsTrigger(
                  value: 'inputs', children: [Component.text('Inputs')]),
              ShadTabsTrigger(
                  value: 'display', children: [Component.text('Display')]),
              ShadTabsTrigger(
                  value: 'navigation',
                  children: [Component.text('Navigation')]),
              ShadTabsTrigger(
                  value: 'overlays', children: [Component.text('Overlays')]),
              ShadTabsTrigger(
                  value: 'layout', children: [Component.text('Layout')]),
              ShadTabsTrigger(
                  value: 'feedback', children: [Component.text('Feedback')]),
              ShadTabsTrigger(
                  value: 'charts', children: [Component.text('Charts')]),
              ShadTabsTrigger(
                  value: 'blocks', children: [Component.text('Blocks')]),
            ], className: 'flex-wrap'),

            // ═══════════════════════════════════
            // INPUTS TAB
            // ═══════════════════════════════════
            ShadTabsContent(
              value: 'inputs',
              children: [
                div(_buildInputs(), classes: 'space-y-8 pt-6'),
              ],
            ),

            // ═══════════════════════════════════
            // DISPLAY TAB
            // ═══════════════════════════════════
            ShadTabsContent(
              value: 'display',
              children: [
                div(_buildDisplay(), classes: 'space-y-8 pt-6'),
              ],
            ),

            // ═══════════════════════════════════
            // NAVIGATION TAB
            // ═══════════════════════════════════
            ShadTabsContent(
              value: 'navigation',
              children: [
                div(_buildNavigation(), classes: 'space-y-8 pt-6'),
              ],
            ),

            // ═══════════════════════════════════
            // OVERLAYS TAB
            // ═══════════════════════════════════
            ShadTabsContent(
              value: 'overlays',
              children: [
                div(_buildOverlays(), classes: 'space-y-8 pt-6'),
              ],
            ),

            // ═══════════════════════════════════
            // LAYOUT TAB
            // ═══════════════════════════════════
            ShadTabsContent(
              value: 'layout',
              children: [
                div(_buildLayout(), classes: 'space-y-8 pt-6'),
              ],
            ),

            // ═══════════════════════════════════
            // FEEDBACK TAB
            // ═══════════════════════════════════
            ShadTabsContent(
              value: 'feedback',
              children: [
                div(_buildFeedback(), classes: 'space-y-8 pt-6'),
              ],
            ),

            // ═══════════════════════════════════
            // CHARTS TAB
            // ═══════════════════════════════════
            ShadTabsContent(
              value: 'charts',
              children: [
                div(_buildCharts(), classes: 'space-y-8 pt-6'),
              ],
            ),

            // ═══════════════════════════════════
            // BLOCKS TAB
            // ═══════════════════════════════════
            ShadTabsContent(
              value: 'blocks',
              children: [
                div(_buildBlocks(), classes: 'space-y-8 pt-6'),
              ],
            ),
          ],
        ),

        // Footer
        div(
          [
            ShadSeparator(),
            p(
              [
                Component.text(
                    'shadcn_jaspr — 60 components + charts + blocks. Built with Jaspr + Tailwind CSS.')
              ],
              classes: 'text-sm text-muted-foreground mt-6 text-center',
            ),
          ],
          classes: 'mt-8 pb-12',
        ),
      ],
      classes: 'container mx-auto max-w-5xl py-12 px-4',
    );
  }

  // ═══════════════════════════════════════════
  // INPUTS (11)
  // ═══════════════════════════════════════════
  List<Component> _buildInputs() {
    return [
      // Button
      _section('Button', 'Actions and form submissions', [
        div(
          [
            ShadButton([Component.text('Default')]),
            ShadButton([Component.text('Destructive')],
                variant: ButtonVariant.destructive),
            ShadButton([Component.text('Outline')],
                variant: ButtonVariant.outline),
            ShadButton([Component.text('Secondary')],
                variant: ButtonVariant.secondary),
            ShadButton([Component.text('Ghost')],
                variant: ButtonVariant.ghost),
            ShadButton([Component.text('Link')], variant: ButtonVariant.link),
          ],
          classes: 'flex flex-wrap gap-3',
        ),
        div(
          [
            ShadButton([Component.text('Small')], size: ButtonSize.sm),
            ShadButton([Component.text('Default')]),
            ShadButton([Component.text('Large')], size: ButtonSize.lg),
            ShadButton([Component.text('Disabled')], isDisabled: true),
          ],
          classes: 'flex flex-wrap items-center gap-3 mt-4',
        ),
      ]),

      // Input & Label
      _section('Input & Label', 'Text input fields with labels', [
        div(
          [
            div(
              [
                ShadLabel([Component.text('Email')], htmlFor: 'email'),
                ShadInput(
                    id: 'email',
                    type: InputType.email,
                    placeholder: 'Enter your email'),
              ],
              classes: 'grid gap-2 max-w-sm',
            ),
            div(
              [
                ShadLabel([Component.text('Disabled')]),
                ShadInput(placeholder: 'Disabled input', isDisabled: true),
              ],
              classes: 'grid gap-2 max-w-sm',
            ),
          ],
          classes: 'flex flex-wrap gap-8',
        ),
      ]),

      // Textarea
      _section('Textarea', 'Multi-line text input', [
        div(
          [
            ShadLabel([Component.text('Message')]),
            ShadTextarea(placeholder: 'Type your message here...'),
          ],
          classes: 'grid gap-2 max-w-lg',
        ),
      ]),

      // Checkbox
      _section('Checkbox', 'Boolean toggle controls', [
        div(
          [
            div(
              [
                ShadCheckbox(checked: true),
                ShadLabel([Component.text('Accept terms and conditions')])
              ],
              classes: 'flex items-center gap-2',
            ),
            div(
              [
                ShadCheckbox(isDisabled: true),
                ShadLabel([Component.text('Disabled checkbox')])
              ],
              classes: 'flex items-center gap-2',
            ),
          ],
          classes: 'space-y-4',
        ),
      ]),

      // Switch
      _section('Switch', 'Toggle between two states', [
        div(
          [
            div(
              [
                ShadSwitch(),
                ShadLabel([Component.text('Airplane Mode')])
              ],
              classes: 'flex items-center gap-2',
            ),
            div(
              [
                ShadSwitch(size: SwitchSize.sm),
                ShadLabel([Component.text('Small switch')])
              ],
              classes: 'flex items-center gap-2',
            ),
          ],
          classes: 'space-y-4',
        ),
      ]),

      // Select
      _section('Select', 'Dropdown selection control', [
        ShadSelect(
          children: [
            ShadSelectTrigger(
              [ShadSelectValue(placeholder: 'Select a fruit')],
              className: 'w-[180px]',
            ),
            ShadSelectContent([
              ShadSelectItem(
                  value: 'apple', children: [Component.text('Apple')]),
              ShadSelectItem(
                  value: 'banana', children: [Component.text('Banana')]),
              ShadSelectItem(
                  value: 'orange', children: [Component.text('Orange')]),
              ShadSelectSeparator(),
              ShadSelectItem(
                  value: 'grape', children: [Component.text('Grape')]),
            ]),
          ],
        ),
      ]),

      // Radio Group
      _section('Radio Group', 'Single selection from multiple options', [
        ShadRadioGroup(
          value: 'comfortable',
          children: [
            div([
              ShadRadioGroupItem(value: 'default'),
              ShadLabel([Component.text('Default')])
            ], classes: 'flex items-center gap-2'),
            div([
              ShadRadioGroupItem(value: 'comfortable'),
              ShadLabel([Component.text('Comfortable')])
            ], classes: 'flex items-center gap-2'),
            div([
              ShadRadioGroupItem(value: 'compact'),
              ShadLabel([Component.text('Compact')])
            ], classes: 'flex items-center gap-2'),
          ],
        ),
      ]),

      // Native Select
      _section('Native Select', 'Browser-native select element', [
        div(
          [
            ShadNativeSelect(
              children: [
                ShadNativeSelectOption(
                    value: '',
                    children: [Component.text('Select a fruit...')]),
                ShadNativeSelectOption(
                    value: 'apple', children: [Component.text('Apple')]),
                ShadNativeSelectOption(
                    value: 'banana', children: [Component.text('Banana')]),
                ShadNativeSelectOptGroup(
                  label: 'Citrus',
                  children: [
                    ShadNativeSelectOption(
                        value: 'orange',
                        children: [Component.text('Orange')]),
                    ShadNativeSelectOption(
                        value: 'lemon', children: [Component.text('Lemon')]),
                  ],
                ),
              ],
            ),
          ],
          classes: 'max-w-xs',
        ),
      ]),

      // Slider
      _section('Slider', 'Range selection control', [
        div(
          [
            ShadSlider(value: 33),
            div([], classes: 'h-6'),
            ShadSlider(value: 66, max: 100),
          ],
          classes: 'max-w-sm',
        ),
      ]),

      // Input OTP
      _section('Input OTP', 'One-time password input', [
        ShadInputOTP(
          maxLength: 6,
          children: [
            ShadInputOTPGroup([
              ShadInputOTPSlot(index: 0),
              ShadInputOTPSlot(index: 1),
              ShadInputOTPSlot(index: 2),
            ]),
            ShadInputOTPSeparator(),
            ShadInputOTPGroup([
              ShadInputOTPSlot(index: 3),
              ShadInputOTPSlot(index: 4),
              ShadInputOTPSlot(index: 5),
            ]),
          ],
        ),
      ]),

      // Field
      _section('Field', 'Structured form field layout', [
        ShadFieldSet([
          ShadFieldLegend([Component.text('User Information')]),
          ShadFieldGroup([
            ShadField([
              ShadFieldLabel([Component.text('Name')], htmlFor: 'name'),
              ShadFieldContent([
                ShadInput(id: 'name', placeholder: 'Enter your name'),
              ]),
            ]),
            ShadField([
              ShadFieldLabel([Component.text('Email')], htmlFor: 'femail'),
              ShadFieldContent([
                ShadInput(id: 'femail', placeholder: 'Enter your email'),
                ShadFieldDescription(
                    [Component.text('We will never share your email.')]),
              ]),
            ]),
            ShadField([
              ShadFieldLabel([Component.text('Bio')], htmlFor: 'bio'),
              ShadFieldContent([
                ShadTextarea(
                    id: 'bio', placeholder: 'Tell us about yourself'),
                ShadFieldError(['Bio must be at least 10 characters.']),
              ]),
            ]),
          ]),
        ], className: 'max-w-md'),
      ]),
    ];
  }

  // ═══════════════════════════════════════════
  // DISPLAY (11)
  // ═══════════════════════════════════════════
  List<Component> _buildDisplay() {
    return [
      // Badge
      _section('Badge', 'Status indicators and labels', [
        div(
          [
            ShadBadge([Component.text('Default')]),
            ShadBadge([Component.text('Secondary')],
                variant: BadgeVariant.secondary),
            ShadBadge([Component.text('Destructive')],
                variant: BadgeVariant.destructive),
            ShadBadge([Component.text('Outline')],
                variant: BadgeVariant.outline),
          ],
          classes: 'flex flex-wrap gap-3',
        ),
      ]),

      // Avatar
      _section('Avatar', 'User profile images with fallbacks', [
        div(
          [
            ShadAvatar([
              ShadAvatarImage(
                  src: 'https://github.com/shadcn.png', alt: 'shadcn'),
              ShadAvatarFallback([Component.text('CN')]),
            ]),
            ShadAvatar([
              ShadAvatarFallback([Component.text('JD')]),
            ]),
            ShadAvatar([
              ShadAvatarFallback([Component.text('AB')]),
            ], className: 'size-12'),
          ],
          classes: 'flex items-center gap-4',
        ),
      ]),

      // Skeleton
      _section('Skeleton', 'Loading placeholder animations', [
        div(
          [
            ShadSkeleton(className: 'size-12 rounded-full'),
            div(
              [
                ShadSkeleton(className: 'h-4 w-[250px]'),
                ShadSkeleton(className: 'h-4 w-[200px]'),
              ],
              classes: 'space-y-2',
            ),
          ],
          classes: 'flex items-center gap-4',
        ),
      ]),

      // Aspect Ratio
      _section('Aspect Ratio', 'Maintain element proportions', [
        div(
          [
            ShadAspectRatio(
              ratio: 16 / 9,
              children: [
                div(
                  [Component.text('16:9')],
                  classes:
                      'flex items-center justify-center bg-muted rounded-md text-muted-foreground text-sm h-full',
                ),
              ],
            ),
          ],
          classes: 'max-w-[400px]',
        ),
      ]),

      // Alert
      _section('Alert', 'Contextual feedback messages', [
        div(
          [
            ShadAlert([
              Component.element(
                tag: 'svg',
                attributes: {
                  'xmlns': 'http://www.w3.org/2000/svg',
                  'width': '16',
                  'height': '16',
                  'viewBox': '0 0 24 24',
                  'fill': 'none',
                  'stroke': 'currentColor',
                  'stroke-width': '2',
                  'stroke-linecap': 'round',
                  'stroke-linejoin': 'round',
                },
                children: [
                  Component.element(
                      tag: 'circle',
                      attributes: {'cx': '12', 'cy': '12', 'r': '10'}),
                  Component.element(
                      tag: 'path', attributes: {'d': 'M12 16v-4'}),
                  Component.element(
                      tag: 'path', attributes: {'d': 'M12 8h.01'}),
                ],
              ),
              ShadAlertTitle([Component.text('Heads up!')]),
              ShadAlertDescription([
                Component.text(
                    'You can add components to your app using the CLI.')
              ]),
            ]),
            div([], classes: 'h-4'),
            ShadAlert([
              ShadAlertTitle([Component.text('Error')]),
              ShadAlertDescription([
                Component.text(
                    'Your session has expired. Please log in again.')
              ]),
            ], variant: AlertVariant.destructive),
          ],
          classes: 'max-w-lg space-y-4',
        ),
      ]),

      // Typography
      _section('Typography', 'Text styling system', [
        div(
          [
            ShadTypographyH1([Component.text('Heading 1')]),
            ShadTypographyH2([Component.text('Heading 2')]),
            ShadTypographyH3([Component.text('Heading 3')]),
            ShadTypographyH4([Component.text('Heading 4')]),
            ShadTypographyP(
                [Component.text('This is a paragraph with leading text.')]),
            ShadTypographyBlockquote(
                [Component.text('This is a blockquote.')]),
            ShadTypographyCode([Component.text('inline code')]),
            ShadTypographyLead([Component.text('A lead paragraph.')]),
            ShadTypographyLarge([Component.text('Large text')]),
            ShadTypographySmall([Component.text('Small text')]),
            ShadTypographyMuted([Component.text('Muted text')]),
          ],
          classes: 'flex flex-col gap-2',
        ),
      ]),

      // Spinner
      _section('Spinner', 'Loading indicators', [
        div(
          [
            ShadSpinner(),
            ShadSpinner(className: 'size-6'),
            ShadSpinner(className: 'size-8 text-primary'),
          ],
          classes: 'flex items-center gap-4',
        ),
      ]),

      // Kbd
      _section('Kbd', 'Keyboard shortcut indicators', [
        div(
          [
            ShadKbd([Component.text('⌘')]),
            ShadKbd([Component.text('K')]),
            ShadKbdGroup([
              ShadKbd([Component.text('⌘')]),
              ShadKbd([Component.text('C')]),
            ]),
            ShadKbdGroup([
              ShadKbd([Component.text('Ctrl')]),
              ShadKbd([Component.text('Shift')]),
              ShadKbd([Component.text('P')]),
            ]),
          ],
          classes: 'flex items-center gap-3',
        ),
      ]),

      // Empty
      _section('Empty', 'Empty state placeholder', [
        ShadEmpty([
          ShadEmptyMedia([
            Component.element(
              tag: 'svg',
              attributes: {
                'xmlns': 'http://www.w3.org/2000/svg',
                'width': '24',
                'height': '24',
                'viewBox': '0 0 24 24',
                'fill': 'none',
                'stroke': 'currentColor',
                'stroke-width': '2',
                'stroke-linecap': 'round',
                'stroke-linejoin': 'round',
              },
              children: [
                Component.element(tag: 'path', attributes: {
                  'd':
                      'M15 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7Z'
                }),
                Component.element(
                    tag: 'path',
                    attributes: {'d': 'M14 2v4a2 2 0 0 0 2 2h4'}),
              ],
            ),
          ]),
          ShadEmptyTitle([Component.text('No files found')]),
          ShadEmptyDescription(
              [Component.text('Upload your first file to get started.')]),
          ShadEmptyContent([
            ShadButton([Component.text('Upload File')], size: ButtonSize.sm),
          ]),
        ]),
      ]),

      // Item
      _section('Item', 'List item with media and content', [
        div(
          [
            ShadItem([
              ShadItemMedia([
                Component.element(
                  tag: 'svg',
                  attributes: {
                    'xmlns': 'http://www.w3.org/2000/svg',
                    'width': '20',
                    'height': '20',
                    'viewBox': '0 0 24 24',
                    'fill': 'none',
                    'stroke': 'currentColor',
                    'stroke-width': '2',
                  },
                  children: [
                    Component.element(tag: 'path', attributes: {
                      'd':
                          'M15 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7Z'
                    }),
                    Component.element(
                        tag: 'path',
                        attributes: {'d': 'M14 2v4a2 2 0 0 0 2 2h4'}),
                  ],
                ),
              ]),
              ShadItemContent([
                ShadItemTitle([Component.text('Document.pdf')]),
                ShadItemDescription(
                    [Component.text('2.4 MB · Updated 2 hours ago')]),
              ]),
            ]),
            ShadItem([
              ShadItemMedia([
                Component.element(
                  tag: 'svg',
                  attributes: {
                    'xmlns': 'http://www.w3.org/2000/svg',
                    'width': '20',
                    'height': '20',
                    'viewBox': '0 0 24 24',
                    'fill': 'none',
                    'stroke': 'currentColor',
                    'stroke-width': '2',
                  },
                  children: [
                    Component.element(tag: 'rect', attributes: {
                      'width': '18',
                      'height': '18',
                      'x': '3',
                      'y': '3',
                      'rx': '2',
                      'ry': '2'
                    }),
                    Component.element(
                        tag: 'circle',
                        attributes: {'cx': '9', 'cy': '9', 'r': '2'}),
                    Component.element(tag: 'path', attributes: {
                      'd': 'm21 15-3.086-3.086a2 2 0 0 0-2.828 0L6 21'
                    }),
                  ],
                ),
              ]),
              ShadItemContent([
                ShadItemTitle([Component.text('Photo.jpg')]),
                ShadItemDescription(
                    [Component.text('1.2 MB · Updated yesterday')]),
              ]),
            ], variant: ItemVariant.outline),
          ],
          classes: 'flex flex-col gap-3 max-w-sm',
        ),
      ]),

      // Progress
      _section('Progress', 'Visual progress indicators', [
        div(
          [
            ShadProgress(value: 33),
            div([], classes: 'h-4'),
            ShadProgress(value: 66),
            div([], classes: 'h-4'),
            ShadProgress(value: 100),
          ],
          classes: 'max-w-lg',
        ),
      ]),
    ];
  }

  // ═══════════════════════════════════════════
  // NAVIGATION (5)
  // ═══════════════════════════════════════════
  List<Component> _buildNavigation() {
    return [
      // Tabs
      _section('Tabs', 'Tabbed content navigation', [
        ShadTabs(
          defaultValue: 'account',
          children: [
            ShadTabsList([
              ShadTabsTrigger(
                  value: 'account', children: [Component.text('Account')]),
              ShadTabsTrigger(
                  value: 'password', children: [Component.text('Password')]),
            ]),
            ShadTabsContent(
              value: 'account',
              children: [
                ShadCard([
                  ShadCardHeader([
                    ShadCardTitle([Component.text('Account')]),
                    ShadCardDescription([
                      Component.text('Make changes to your account here.')
                    ]),
                  ]),
                  ShadCardContent([
                    div([
                      ShadLabel([Component.text('Name')]),
                      ShadInput(placeholder: 'Your name')
                    ], classes: 'grid gap-2'),
                  ]),
                  ShadCardFooter([
                    ShadButton([Component.text('Save changes')])
                  ]),
                ]),
              ],
            ),
            ShadTabsContent(
              value: 'password',
              children: [
                ShadCard([
                  ShadCardHeader([
                    ShadCardTitle([Component.text('Password')]),
                    ShadCardDescription(
                        [Component.text('Change your password here.')]),
                  ]),
                  ShadCardContent([
                    div(
                      [
                        ShadLabel([Component.text('Current password')]),
                        ShadInput(type: InputType.password),
                        ShadLabel([Component.text('New password')]),
                        ShadInput(type: InputType.password),
                      ],
                      classes: 'grid gap-2',
                    ),
                  ]),
                  ShadCardFooter([
                    ShadButton([Component.text('Save password')])
                  ]),
                ]),
              ],
            ),
          ],
        ),
      ]),

      // Breadcrumb
      _section('Breadcrumb', 'Page hierarchy navigation', [
        ShadBreadcrumb([
          ShadBreadcrumbList([
            ShadBreadcrumbItem([
              ShadBreadcrumbLink([Component.text('Home')], href: '/')
            ]),
            ShadBreadcrumbSeparator(),
            ShadBreadcrumbItem([
              ShadBreadcrumbLink([Component.text('Components')],
                  href: '/components')
            ]),
            ShadBreadcrumbSeparator(),
            ShadBreadcrumbItem([
              ShadBreadcrumbPage([Component.text('Breadcrumb')])
            ]),
          ]),
        ]),
      ]),

      // Pagination
      _section('Pagination', 'Page-based navigation', [
        ShadPagination([
          ShadPaginationContent([
            ShadPaginationItem([ShadPaginationPrevious()]),
            ShadPaginationItem([
              ShadPaginationLink([Component.text('1')], isActive: true)
            ]),
            ShadPaginationItem([
              ShadPaginationLink([Component.text('2')])
            ]),
            ShadPaginationItem([
              ShadPaginationLink([Component.text('3')])
            ]),
            ShadPaginationItem([ShadPaginationEllipsis()]),
            ShadPaginationItem([ShadPaginationNext()]),
          ]),
        ]),
      ]),

      // Navigation Menu
      _section('Navigation Menu', 'Site-wide navigation with dropdowns', [
        ShadNavigationMenu(
          children: [
            ShadNavigationMenuList([
              ShadNavigationMenuItem(
                value: 'getting-started',
                children: [
                  ShadNavigationMenuTrigger(
                      [Component.text('Getting Started')]),
                  ShadNavigationMenuContent([
                    div(
                      [
                        ShadNavigationMenuLink(
                          href: '#',
                          children: [
                            div([Component.text('Introduction')],
                                classes: 'text-sm font-medium leading-none'),
                            p([
                              Component.text(
                                  'Re-usable components built using Jaspr and Tailwind CSS.')
                            ],
                                classes:
                                    'text-sm leading-snug text-muted-foreground line-clamp-2'),
                          ],
                        ),
                        ShadNavigationMenuLink(
                          href: '#',
                          children: [
                            div([Component.text('Installation')],
                                classes: 'text-sm font-medium leading-none'),
                            p([
                              Component.text(
                                  'How to install dependencies and structure your app.')
                            ],
                                classes:
                                    'text-sm leading-snug text-muted-foreground line-clamp-2'),
                          ],
                        ),
                      ],
                      classes: 'grid w-[400px] gap-3 p-4 md:grid-cols-2',
                    ),
                  ]),
                ],
              ),
              ShadNavigationMenuItem(
                value: 'components',
                children: [
                  ShadNavigationMenuTrigger([Component.text('Components')]),
                  ShadNavigationMenuContent([
                    div(
                      [
                        ShadNavigationMenuLink(
                          href: '#',
                          children: [
                            div([Component.text('Alert Dialog')],
                                classes: 'text-sm font-medium leading-none'),
                            p([
                              Component.text(
                                  'A modal dialog that interrupts the user.')
                            ],
                                classes:
                                    'text-sm leading-snug text-muted-foreground line-clamp-2'),
                          ],
                        ),
                        ShadNavigationMenuLink(
                          href: '#',
                          children: [
                            div([Component.text('Hover Card')],
                                classes: 'text-sm font-medium leading-none'),
                            p([
                              Component.text(
                                  'For sighted users to preview content behind a link.')
                            ],
                                classes:
                                    'text-sm leading-snug text-muted-foreground line-clamp-2'),
                          ],
                        ),
                      ],
                      classes: 'grid w-[400px] gap-3 p-4 md:grid-cols-2',
                    ),
                  ]),
                ],
              ),
            ]),
          ],
        ),
      ]),

      // Sidebar
      _section('Sidebar', 'Application sidebar navigation', [
        div(
          [
            p([
              Component.text(
                  'SidebarProvider, Sidebar, SidebarContent, SidebarMenu, SidebarMenuItem, SidebarMenuButton, SidebarTrigger, SidebarRail, SidebarInset — all available.')
            ], classes: 'text-sm text-muted-foreground'),
            div([], classes: 'h-3'),
            div(
              [
                div(
                  [
                    div(
                      [Component.text('Sidebar Demo')],
                      classes:
                          'px-3 py-2 text-xs font-medium text-muted-foreground uppercase tracking-wider',
                    ),
                    for (final item in [
                      'Dashboard',
                      'Projects',
                      'Settings',
                      'Help'
                    ])
                      div(
                        [Component.text(item)],
                        classes:
                            'flex items-center gap-2 rounded-md px-3 py-2 text-sm hover:bg-accent hover:text-accent-foreground cursor-pointer',
                      ),
                  ],
                  classes: 'w-[220px] border rounded-lg bg-sidebar p-2',
                ),
              ],
            ),
          ],
        ),
      ]),
    ];
  }

  // ═══════════════════════════════════════════
  // OVERLAYS (10)
  // ═══════════════════════════════════════════
  List<Component> _buildOverlays() {
    return [
      // Dialog
      _section('Dialog', 'Modal dialog window', [
        ShadDialog(
          children: [
            ShadDialogTrigger([
              ShadButton([Component.text('Open Dialog')],
                  variant: ButtonVariant.outline),
            ]),
            ShadDialogContent([
              ShadDialogHeader([
                ShadDialogTitle([Component.text('Are you sure?')]),
                ShadDialogDescription([
                  Component.text(
                      'This action cannot be undone. This will permanently delete your account.'),
                ]),
              ]),
              ShadDialogFooter([
                ShadButton([Component.text('Cancel')],
                    variant: ButtonVariant.outline),
                ShadButton([Component.text('Continue')]),
              ]),
            ]),
          ],
        ),
      ]),

      // Sheet
      _section('Sheet', 'Slide-out panel from screen edge', [
        ShadSheet(
          children: [
            ShadSheetTrigger([
              ShadButton([Component.text('Open Sheet')],
                  variant: ButtonVariant.outline),
            ]),
            ShadSheetContent(
              [
                ShadSheetHeader([
                  ShadSheetTitle([Component.text('Edit profile')]),
                  ShadSheetDescription(
                      [Component.text('Make changes to your profile here.')]),
                ]),
                div(
                  [
                    ShadLabel([Component.text('Name')]),
                    ShadInput(placeholder: 'Your name'),
                    ShadLabel([Component.text('Username')]),
                    ShadInput(placeholder: '@username'),
                  ],
                  classes: 'grid gap-4 p-4',
                ),
                ShadSheetFooter([
                  ShadButton([Component.text('Save changes')])
                ]),
              ],
              side: SheetSide.right,
            ),
          ],
        ),
      ]),

      // Dropdown Menu
      _section('Dropdown Menu', 'Contextual action menu', [
        ShadDropdownMenu(
          children: [
            ShadDropdownMenuTrigger([
              ShadButton([Component.text('Open Menu')],
                  variant: ButtonVariant.outline),
            ]),
            ShadDropdownMenuContent([
              ShadDropdownMenuLabel([Component.text('My Account')]),
              ShadDropdownMenuSeparator(),
              ShadDropdownMenuItem([Component.text('Profile')]),
              ShadDropdownMenuItem([Component.text('Billing')]),
              ShadDropdownMenuItem([Component.text('Settings')]),
              ShadDropdownMenuSeparator(),
              ShadDropdownMenuItem([Component.text('Log out')],
                  variant: DropdownMenuItemVariant.destructive),
            ]),
          ],
        ),
      ]),

      // Tooltip
      _section('Tooltip', 'Informational popup on hover', [
        ShadTooltip(
          children: [
            ShadTooltipTrigger([
              ShadButton([Component.text('Hover me')],
                  variant: ButtonVariant.outline),
            ]),
            ShadTooltipContent([Component.text('This is a tooltip')],
                side: TooltipSide.top),
          ],
        ),
      ]),

      // Popover
      _section('Popover', 'Floating content panel', [
        ShadPopover(
          children: [
            ShadPopoverTrigger([
              ShadButton([Component.text('Open Popover')],
                  variant: ButtonVariant.outline),
            ]),
            ShadPopoverContent([
              div(
                [
                  h4([Component.text('Dimensions')],
                      classes: 'font-medium leading-none'),
                  p([Component.text('Set the dimensions for the layer.')],
                      classes: 'text-sm text-muted-foreground'),
                ],
                classes: 'grid gap-2',
              ),
            ]),
          ],
        ),
      ]),

      // Hover Card
      _section('Hover Card', 'Preview content on hover', [
        ShadHoverCard(
          children: [
            ShadHoverCardTrigger([
              Component.element(
                tag: 'a',
                attributes: {
                  'href': '#',
                  'class':
                      'text-sm font-medium underline underline-offset-4',
                },
                children: [Component.text('@nextjs')],
              ),
            ]),
            ShadHoverCardContent([
              div(
                [
                  ShadAvatar([
                    ShadAvatarFallback([Component.text('NJ')])
                  ]),
                  div(
                    [
                      h4([Component.text('Next.js')],
                          classes: 'text-sm font-semibold'),
                      p([
                        Component.text(
                            'The React Framework – created and maintained by @vercel.')
                      ], classes: 'text-sm'),
                    ],
                    classes: 'space-y-1',
                  ),
                ],
                classes: 'flex gap-4',
              ),
            ]),
          ],
        ),
      ]),

      // Alert Dialog
      _section('Alert Dialog', 'Confirmation dialog with actions', [
        ShadAlertDialog(
          children: [
            ShadAlertDialogTrigger([
              ShadButton([Component.text('Delete Account')],
                  variant: ButtonVariant.destructive),
            ]),
            ShadAlertDialogContent([
              ShadAlertDialogHeader([
                ShadAlertDialogTitle(
                    [Component.text('Are you absolutely sure?')]),
                ShadAlertDialogDescription([
                  Component.text(
                      'This action cannot be undone. This will permanently delete your account and remove your data from our servers.'),
                ]),
              ]),
              ShadAlertDialogFooter([
                ShadAlertDialogCancel([
                  ShadButton([Component.text('Cancel')],
                      variant: ButtonVariant.outline),
                ]),
                ShadAlertDialogAction([
                  ShadButton([Component.text('Continue')],
                      variant: ButtonVariant.destructive),
                ]),
              ]),
            ]),
          ],
        ),
      ]),

      // Drawer
      _section('Drawer', 'Bottom sheet drawer', [
        ShadDrawer(
          children: [
            ShadDrawerTrigger([
              ShadButton([Component.text('Open Drawer')],
                  variant: ButtonVariant.outline),
            ]),
            ShadDrawerContent([
              ShadDrawerHeader([
                ShadDrawerTitle([Component.text('Move Goal')]),
                ShadDrawerDescription(
                    [Component.text('Set your daily activity goal.')]),
              ]),
              div(
                [
                  p([Component.text('Drag to adjust or use buttons.')],
                      classes:
                          'text-center text-muted-foreground text-sm'),
                ],
                classes: 'p-4',
              ),
              ShadDrawerFooter([
                ShadButton([Component.text('Submit')]),
                ShadDrawerClose([
                  ShadButton([Component.text('Cancel')],
                      variant: ButtonVariant.outline),
                ]),
              ]),
            ]),
          ],
        ),
      ]),

      // Context Menu
      _section('Context Menu', 'Right-click context menu', [
        ShadContextMenu(
          children: [
            ShadContextMenuTrigger(
              [
                div(
                  [Component.text('Right click here')],
                  classes:
                      'flex h-[150px] w-[300px] items-center justify-center rounded-md border border-dashed text-sm',
                ),
              ],
            ),
            ShadContextMenuContent([
              ShadContextMenuItem([Component.text('Back')]),
              ShadContextMenuItem([Component.text('Forward')],
                  isDisabled: true),
              ShadContextMenuItem([Component.text('Reload')]),
              ShadContextMenuSeparator(),
              ShadContextMenuLabel([Component.text('More Tools')]),
              ShadContextMenuItem([Component.text('Save Page As...')]),
              ShadContextMenuItem([Component.text('View Page Source')]),
              ShadContextMenuItem([Component.text('Inspect')]),
            ]),
          ],
        ),
      ]),

      // Menubar
      _section('Menubar', 'Application menu bar', [
        ShadMenubar(
          children: [
            ShadMenubarMenu(
              value: 'file',
              children: [
                ShadMenubarTrigger([Component.text('File')]),
                ShadMenubarContent([
                  ShadMenubarItem([
                    Component.text('New Tab'),
                    ShadMenubarShortcut([Component.text('⌘T')]),
                  ]),
                  ShadMenubarItem([
                    Component.text('New Window'),
                    ShadMenubarShortcut([Component.text('⌘N')]),
                  ]),
                  ShadMenubarSeparator(),
                  ShadMenubarItem([Component.text('Share')]),
                  ShadMenubarSeparator(),
                  ShadMenubarItem([Component.text('Print')]),
                ]),
              ],
            ),
            ShadMenubarMenu(
              value: 'edit',
              children: [
                ShadMenubarTrigger([Component.text('Edit')]),
                ShadMenubarContent([
                  ShadMenubarItem([
                    Component.text('Undo'),
                    ShadMenubarShortcut([Component.text('⌘Z')]),
                  ]),
                  ShadMenubarItem([
                    Component.text('Redo'),
                    ShadMenubarShortcut([Component.text('⌘Y')]),
                  ]),
                  ShadMenubarSeparator(),
                  ShadMenubarItem([Component.text('Cut')]),
                  ShadMenubarItem([Component.text('Copy')]),
                  ShadMenubarItem([Component.text('Paste')]),
                ]),
              ],
            ),
            ShadMenubarMenu(
              value: 'view',
              children: [
                ShadMenubarTrigger([Component.text('View')]),
                ShadMenubarContent([
                  ShadMenubarCheckboxItem(
                      [Component.text('Always Show Bookmarks Bar')],
                      checked: true),
                  ShadMenubarCheckboxItem(
                      [Component.text('Always Show Full URLs')]),
                  ShadMenubarSeparator(),
                  ShadMenubarItem([Component.text('Reload')]),
                  ShadMenubarItem([Component.text('Toggle Fullscreen')]),
                ]),
              ],
            ),
          ],
        ),
      ]),
    ];
  }

  // ═══════════════════════════════════════════
  // LAYOUT (13)
  // ═══════════════════════════════════════════
  List<Component> _buildLayout() {
    return [
      // Card
      _section('Card', 'Container with header, content, footer', [
        ShadCard([
          ShadCardHeader([
            ShadCardTitle([Component.text('Card Title')]),
            ShadCardDescription(
                [Component.text('Card description goes here.')]),
          ]),
          ShadCardContent([
            p([
              Component.text('Card content area. Put any components here.')
            ]),
          ]),
          ShadCardFooter([
            ShadButton([Component.text('Cancel')],
                variant: ButtonVariant.outline),
            ShadButton([Component.text('Save')]),
          ]),
        ]),
      ]),

      // Separator
      _section('Separator', 'Visual divider between content', [
        div(
          [
            p([Component.text('Content above')]),
            ShadSeparator(),
            p([Component.text('Content below')]),
          ],
          classes: 'space-y-4 max-w-sm',
        ),
      ]),

      // Scroll Area
      _section('Scroll Area', 'Custom scrollable container', [
        ShadScrollArea(
          [
            div(
              [
                for (var i = 1; i <= 20; i++)
                  div(
                    [Component.text('Item $i')],
                    classes: 'py-2 border-b text-sm',
                  ),
              ],
              classes: 'p-4',
            ),
          ],
          className: 'h-48 w-48 rounded-md border',
        ),
      ]),

      // Accordion
      _section('Accordion', 'Collapsible content sections', [
        ShadAccordion(
          type: AccordionType.single,
          defaultValue: 'item-1',
          className: 'max-w-lg',
          children: [
            ShadAccordionItem(
              value: 'item-1',
              children: [
                ShadAccordionTrigger([Component.text('Is it accessible?')]),
                ShadAccordionContent([
                  Component.text(
                      'Yes. It adheres to the WAI-ARIA design pattern.'),
                ]),
              ],
            ),
            ShadAccordionItem(
              value: 'item-2',
              children: [
                ShadAccordionTrigger([Component.text('Is it styled?')]),
                ShadAccordionContent([
                  Component.text(
                      'Yes. It comes with default styles that match the other components\' aesthetic.'),
                ]),
              ],
            ),
            ShadAccordionItem(
              value: 'item-3',
              children: [
                ShadAccordionTrigger([Component.text('Is it animated?')]),
                ShadAccordionContent([
                  Component.text(
                      'Yes. It\'s animated by default, but you can disable it if you prefer.'),
                ]),
              ],
            ),
          ],
        ),
      ]),

      // Collapsible
      _section('Collapsible', 'Toggle content visibility', [
        ShadCollapsible(
          className: 'max-w-sm',
          children: [
            div(
              [
                span([Component.text('@peduarte starred 3 repositories')],
                    classes: 'text-sm font-semibold'),
                ShadCollapsibleTrigger([
                  ShadButton([Component.text('Toggle')],
                      variant: ButtonVariant.ghost, size: ButtonSize.sm),
                ]),
              ],
              classes: 'flex items-center justify-between',
            ),
            div(
              [Component.text('@radix-ui/primitives')],
              classes: 'rounded-md border px-4 py-2 text-sm mt-2',
            ),
            ShadCollapsibleContent([
              div(
                [Component.text('@radix-ui/colors')],
                classes: 'rounded-md border px-4 py-2 text-sm mt-2',
              ),
              div(
                [Component.text('@stitches/react')],
                classes: 'rounded-md border px-4 py-2 text-sm mt-2',
              ),
            ]),
          ],
        ),
      ]),

      // Table
      _section('Table', 'Data table with headers and rows', [
        ShadTable([
          ShadTableHeader([
            ShadTableRow([
              ShadTableHead([Component.text('Invoice')]),
              ShadTableHead([Component.text('Status')]),
              ShadTableHead([Component.text('Method')]),
              ShadTableHead([Component.text('Amount')],
                  className: 'text-right'),
            ]),
          ]),
          ShadTableBody([
            ShadTableRow([
              ShadTableCell([Component.text('INV001')],
                  className: 'font-medium'),
              ShadTableCell([Component.text('Paid')]),
              ShadTableCell([Component.text('Credit Card')]),
              ShadTableCell([Component.text('\$250.00')],
                  className: 'text-right'),
            ]),
            ShadTableRow([
              ShadTableCell([Component.text('INV002')],
                  className: 'font-medium'),
              ShadTableCell([Component.text('Pending')]),
              ShadTableCell([Component.text('PayPal')]),
              ShadTableCell([Component.text('\$150.00')],
                  className: 'text-right'),
            ]),
            ShadTableRow([
              ShadTableCell([Component.text('INV003')],
                  className: 'font-medium'),
              ShadTableCell([Component.text('Unpaid')]),
              ShadTableCell([Component.text('Bank Transfer')]),
              ShadTableCell([Component.text('\$350.00')],
                  className: 'text-right'),
            ]),
          ]),
          ShadTableFooter([
            ShadTableRow([
              ShadTableCell([Component.text('Total')],
                  className: 'font-bold'),
              ShadTableCell([]),
              ShadTableCell([]),
              ShadTableCell([Component.text('\$750.00')],
                  className: 'text-right font-bold'),
            ]),
          ]),
        ]),
      ]),

      // Resizable
      _section('Resizable', 'Resizable panel layout', [
        ShadResizablePanelGroup(
          className: 'max-w-md rounded-lg border h-[200px]',
          children: [
            ShadResizablePanel(
              defaultSize: 50,
              children: [
                div(
                  [Component.text('Panel One')],
                  classes: 'flex h-full items-center justify-center p-6',
                ),
              ],
            ),
            ShadResizableHandle(withHandle: true),
            ShadResizablePanel(
              defaultSize: 50,
              children: [
                div(
                  [Component.text('Panel Two')],
                  classes: 'flex h-full items-center justify-center p-6',
                ),
              ],
            ),
          ],
        ),
      ]),

      // Carousel
      _section('Carousel', 'Content slideshow with navigation', [
        div(
          [
            ShadCarousel(
              className: 'w-full max-w-xs',
              children: [
                ShadCarouselContent([
                  for (var i = 1; i <= 5; i++)
                    ShadCarouselItem([
                      div(
                        [
                          ShadCard([
                            ShadCardContent([
                              div(
                                [Component.text('$i')],
                                classes:
                                    'flex items-center justify-center p-6 text-4xl font-semibold',
                              ),
                            ]),
                          ]),
                        ],
                        classes: 'p-1',
                      ),
                    ]),
                ]),
                ShadCarouselPrevious(),
                ShadCarouselNext(),
              ],
            ),
          ],
          classes: 'flex justify-center',
        ),
      ]),

      // Toggle
      _section('Toggle', 'Binary state toggle button', [
        div(
          [
            ShadToggle(
              children: [
                Component.element(
                  tag: 'svg',
                  attributes: {
                    'xmlns': 'http://www.w3.org/2000/svg',
                    'width': '16',
                    'height': '16',
                    'viewBox': '0 0 24 24',
                    'fill': 'none',
                    'stroke': 'currentColor',
                    'stroke-width': '2',
                  },
                  children: [
                    Component.element(tag: 'path', attributes: {
                      'd': 'M6 4h8a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z'
                    }),
                    Component.element(tag: 'path', attributes: {
                      'd': 'M6 12h9a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z'
                    }),
                  ],
                ),
              ],
            ),
            ShadToggle(
              variant: ToggleVariant.outline,
              children: [
                Component.element(
                  tag: 'svg',
                  attributes: {
                    'xmlns': 'http://www.w3.org/2000/svg',
                    'width': '16',
                    'height': '16',
                    'viewBox': '0 0 24 24',
                    'fill': 'none',
                    'stroke': 'currentColor',
                    'stroke-width': '2',
                  },
                  children: [
                    Component.element(
                        tag: 'path', attributes: {'d': 'M4 12h16'}),
                    Component.element(
                        tag: 'path', attributes: {'d': 'M4 18h16'}),
                    Component.element(
                        tag: 'path', attributes: {'d': 'M4 6h16'}),
                  ],
                ),
              ],
            ),
            ShadToggle(
              isDisabled: true,
              children: [Component.text('Disabled')],
            ),
          ],
          classes: 'flex items-center gap-3',
        ),
      ]),

      // Toggle Group
      _section('Toggle Group', 'Grouped toggle buttons', [
        ShadToggleGroup(
          type: ToggleGroupType.single,
          variant: ToggleGroupVariant.outline,
          children: [
            ShadToggleGroupItem(
                value: 'left', children: [Component.text('L')]),
            ShadToggleGroupItem(
                value: 'center', children: [Component.text('C')]),
            ShadToggleGroupItem(
                value: 'right', children: [Component.text('R')]),
          ],
        ),
      ]),

      // Button Group
      _section('Button Group', 'Grouped action buttons', [
        div(
          [
            ShadButtonGroup([
              ShadButton([Component.text('Left')],
                  variant: ButtonVariant.outline),
              ShadButton([Component.text('Center')],
                  variant: ButtonVariant.outline),
              ShadButton([Component.text('Right')],
                  variant: ButtonVariant.outline),
            ]),
            ShadButtonGroup([
              ShadButton([Component.text('Top')],
                  variant: ButtonVariant.outline),
              ShadButton([Component.text('Middle')],
                  variant: ButtonVariant.outline),
              ShadButton([Component.text('Bottom')],
                  variant: ButtonVariant.outline),
            ], variant: ButtonGroupVariant.vertical),
          ],
          classes: 'flex items-start gap-6',
        ),
      ]),

      // Input Group
      _section('Input Group', 'Composite input with addons', [
        div(
          [
            ShadInputGroup([
              ShadInputGroupAddon([Component.text('https://')]),
              ShadInputGroupInput(placeholder: 'example.com'),
            ]),
            ShadInputGroup([
              ShadInputGroupAddon([Component.text('\$')]),
              ShadInputGroupInput(
                  placeholder: '0.00', type: InputType.number),
              ShadInputGroupAddon([Component.text('USD')],
                  align: InputGroupAddonAlign.right),
            ]),
          ],
          classes: 'flex flex-col gap-3 max-w-sm',
        ),
      ]),
    ];
  }

  // ═══════════════════════════════════════════
  // FEEDBACK (4)
  // ═══════════════════════════════════════════
  List<Component> _buildFeedback() {
    return [
      // Toast
      _section('Toast', 'Notification messages', [
        div(
          [
            ShadToast([
              div(
                [
                  ShadToastTitle([Component.text('Scheduled: Catch up')]),
                  ShadToastDescription([
                    Component.text('Friday, February 10, 2024 at 5:57 PM')
                  ]),
                ],
                classes: 'grid gap-1',
              ),
            ]),
            div([], classes: 'h-3'),
            ShadToast(
              [
                div(
                  [
                    ShadToastTitle(
                        [Component.text('Uh oh! Something went wrong.')]),
                    ShadToastDescription([
                      Component.text(
                          'There was a problem with your request.')
                    ]),
                  ],
                  classes: 'grid gap-1',
                ),
              ],
              variant: ToastVariant.destructive,
            ),
          ],
          classes: 'max-w-sm space-y-3',
        ),
      ]),

      // Sonner
      _section('Sonner', 'Alternative toast with CSS variable styling', [
        div(
          [
            p([
              Component.text(
                  'ShadSonner provides an alternative toast container with CSS variable-based styling.')
            ], classes: 'text-sm text-muted-foreground'),
            div([], classes: 'h-3'),
            div(
              [
                ShadSonnerToast([
                  div(
                    [
                      div([Component.text('Event has been created')],
                          classes: 'text-sm font-semibold'),
                      div([Component.text('Monday, January 1, 2024')],
                          classes: 'text-sm opacity-90'),
                    ],
                  ),
                ]),
              ],
              classes: 'max-w-[360px]',
            ),
          ],
        ),
      ]),

      // Form
      _section('Form', 'Form validation and submission', [
        ShadForm(
          className: 'max-w-sm space-y-4',
          children: [
            ShadFormField(
              name: 'username',
              children: [
                ShadFormItem([
                  ShadFormLabel([Component.text('Username')]),
                  ShadFormControl([
                    ShadInput(placeholder: 'shadcn'),
                  ]),
                  ShadFormDescription(
                      [Component.text('This is your public display name.')]),
                  ShadFormMessage(),
                ]),
              ],
            ),
            ShadButton([Component.text('Submit')]),
          ],
        ),
      ]),

      // Direction
      _section('Direction', 'RTL/LTR content direction', [
        div(
          [
            ShadDirectionProvider(
              direction: DirectionValue.ltr,
              children: [
                p([Component.text('Left-to-right content (default)')],
                    classes: 'text-sm'),
              ],
            ),
            ShadDirectionProvider(
              direction: DirectionValue.rtl,
              children: [
                p([Component.text('Right-to-left content')],
                    classes: 'text-sm'),
              ],
            ),
          ],
          classes: 'flex flex-col gap-2',
        ),
      ]),
    ];
  }

  // ═══════════════════════════════════════════
  // CHARTS (6)
  // ═══════════════════════════════════════════
  List<Component> _buildCharts() {
    final chartData = <Map<String, num>>[
      {'desktop': 186, 'mobile': 80},
      {'desktop': 305, 'mobile': 200},
      {'desktop': 237, 'mobile': 120},
      {'desktop': 73, 'mobile': 190},
      {'desktop': 209, 'mobile': 130},
    ];

    final chartConfig = ChartConfig({
      'desktop':
          ChartConfigEntry(label: 'Desktop', color: 'var(--chart-1)'),
      'mobile':
          ChartConfigEntry(label: 'Mobile', color: 'var(--chart-2)'),
    });

    return [
      // Bar Chart
      _section('Bar Chart', 'Vertical bar chart visualization', [
        ShadChartContainer(
          config: chartConfig,
          children: [
            div(
              [
                ShadBarChart(
                  data: chartData,
                  dataKeys: ['desktop', 'mobile'],
                  width: 500,
                  height: 250,
                ),
                div([], classes: 'h-4'),
                ShadChartLegendContent(config: chartConfig),
              ],
              classes: 'w-full',
            ),
          ],
          className: 'max-w-lg',
        ),
      ]),

      // Line Chart
      _section('Line Chart', 'Data trend line visualization', [
        ShadChartContainer(
          config: chartConfig,
          children: [
            div(
              [
                ShadLineChart(
                  data: chartData,
                  dataKeys: ['desktop', 'mobile'],
                  width: 500,
                  height: 250,
                ),
                div([], classes: 'h-4'),
                ShadChartLegendContent(config: chartConfig),
              ],
              classes: 'w-full',
            ),
          ],
          className: 'max-w-lg',
        ),
      ]),

      // Area Chart
      _section('Area Chart', 'Filled area under line chart', [
        ShadChartContainer(
          config: chartConfig,
          children: [
            div(
              [
                ShadAreaChart(
                  data: chartData,
                  dataKeys: ['desktop', 'mobile'],
                  width: 500,
                  height: 250,
                ),
                div([], classes: 'h-4'),
                ShadChartLegendContent(config: chartConfig),
              ],
              classes: 'w-full',
            ),
          ],
          className: 'max-w-lg',
        ),
      ]),

      // Pie Chart
      _section('Pie Chart', 'Proportional data visualization', [
        ShadChartContainer(
          config: ChartConfig({
            'visitors': ChartConfigEntry(
                label: 'Visitors', color: 'var(--chart-1)'),
          }),
          children: [
            div(
              [
                div([Component.text('Pie Chart')],
                    classes: 'text-sm font-medium mb-2'),
                ShadPieChart(
                  data: [
                    {'visitors': 275},
                    {'visitors': 200},
                    {'visitors': 187},
                    {'visitors': 173},
                    {'visitors': 90},
                  ],
                  dataKeys: ['visitors'],
                  width: 250,
                  height: 250,
                ),
                div([], classes: 'h-4'),
                div([Component.text('Donut Chart')],
                    classes: 'text-sm font-medium mb-2'),
                ShadPieChart(
                  data: [
                    {'visitors': 275},
                    {'visitors': 200},
                    {'visitors': 187},
                    {'visitors': 173},
                    {'visitors': 90},
                  ],
                  dataKeys: ['visitors'],
                  width: 250,
                  height: 250,
                  innerRadius: 60,
                ),
              ],
              classes: 'w-full flex flex-col items-center',
            ),
          ],
          className: 'max-w-md',
        ),
      ]),

      // Radar Chart
      _section('Radar Chart', 'Spider/web multi-axis chart', [
        ShadChartContainer(
          config: ChartConfig({
            'desktop':
                ChartConfigEntry(label: 'Desktop', color: 'var(--chart-1)'),
            'mobile':
                ChartConfigEntry(label: 'Mobile', color: 'var(--chart-2)'),
          }),
          children: [
            div(
              [
                ShadRadarChart(
                  data: [
                    {'category': 'Jan', 'desktop': 186, 'mobile': 80},
                    {'category': 'Feb', 'desktop': 305, 'mobile': 200},
                    {'category': 'Mar', 'desktop': 237, 'mobile': 120},
                    {'category': 'Apr', 'desktop': 73, 'mobile': 190},
                    {'category': 'May', 'desktop': 209, 'mobile': 130},
                    {'category': 'Jun', 'desktop': 214, 'mobile': 140},
                  ],
                  dataKeys: ['desktop', 'mobile'],
                  categoryKey: 'category',
                  width: 350,
                  height: 350,
                ),
                div([], classes: 'h-4'),
                ShadChartLegendContent(config: chartConfig),
              ],
              classes: 'w-full flex flex-col items-center',
            ),
          ],
          className: 'max-w-md',
        ),
      ]),

      // Radial Chart
      _section('Radial Chart', 'Circular gauge/progress rings', [
        ShadChartContainer(
          config: ChartConfig({
            'chrome':
                ChartConfigEntry(label: 'Chrome', color: 'var(--chart-1)'),
            'safari':
                ChartConfigEntry(label: 'Safari', color: 'var(--chart-2)'),
            'firefox':
                ChartConfigEntry(label: 'Firefox', color: 'var(--chart-3)'),
          }),
          children: [
            div(
              [
                ShadRadialChart(
                  data: [
                    {'chrome': 78, 'safari': 56, 'firefox': 42},
                  ],
                  dataKeys: ['chrome', 'safari', 'firefox'],
                  width: 250,
                  height: 250,
                  maxValue: 100,
                ),
                div([], classes: 'h-4'),
                ShadChartLegendContent(
                  config: ChartConfig({
                    'chrome': ChartConfigEntry(
                        label: 'Chrome', color: 'var(--chart-1)'),
                    'safari': ChartConfigEntry(
                        label: 'Safari', color: 'var(--chart-2)'),
                    'firefox': ChartConfigEntry(
                        label: 'Firefox', color: 'var(--chart-3)'),
                  }),
                ),
              ],
              classes: 'w-full flex flex-col items-center',
            ),
          ],
          className: 'max-w-md',
        ),
      ]),
    ];
  }

  // ═══════════════════════════════════════════
  // BLOCKS (10)
  // ═══════════════════════════════════════════
  List<Component> _buildBlocks() {
    return [
      _section('Login 01', 'Simple centered card login', [
        div([ShadLoginBlock01()],
            classes: 'border rounded-lg overflow-hidden max-h-[500px]'),
      ]),
      _section('Login 02', 'Two-column layout with image', [
        div([ShadLoginBlock02()],
            classes: 'border rounded-lg overflow-hidden max-h-[500px]'),
      ]),
      _section('Login 03', 'Card on muted background', [
        div([ShadLoginBlock03()],
            classes: 'border rounded-lg overflow-hidden max-h-[500px]'),
      ]),
      _section('Login 04', 'Card with side image', [
        div([ShadLoginBlock04()],
            classes: 'border rounded-lg overflow-hidden max-h-[500px]'),
      ]),
      _section('Login 05', 'Email-only magic link', [
        div([ShadLoginBlock05()],
            classes: 'border rounded-lg overflow-hidden max-h-[500px]'),
      ]),
      _section('Signup 01', 'Simple centered card signup', [
        div([ShadSignupBlock01()],
            classes: 'border rounded-lg overflow-hidden max-h-[500px]'),
      ]),
      _section('Signup 02', 'Two-column layout with image', [
        div([ShadSignupBlock02()],
            classes: 'border rounded-lg overflow-hidden max-h-[500px]'),
      ]),
      _section('Signup 03', 'Card on muted background', [
        div([ShadSignupBlock03()],
            classes: 'border rounded-lg overflow-hidden max-h-[500px]'),
      ]),
      _section('Signup 04', 'Card with side image', [
        div([ShadSignupBlock04()],
            classes: 'border rounded-lg overflow-hidden max-h-[500px]'),
      ]),
      _section('Signup 05', 'Social OAuth providers', [
        div([ShadSignupBlock05()],
            classes: 'border rounded-lg overflow-hidden max-h-[500px]'),
      ]),
    ];
  }
}

Component _section(String title, String description, List<Component> children) {
  return div(
    [
      div(
        [
          h3([Component.text(title)],
              classes: 'text-lg font-semibold tracking-tight'),
          p([Component.text(description)],
              classes: 'text-sm text-muted-foreground'),
        ],
        classes: 'mb-4',
      ),
      div(
        children,
        classes: 'rounded-lg border p-6',
      ),
    ],
    attributes: {'data-slot': 'demo-section'},
  );
}
