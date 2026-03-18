import 'package:jaspr/jaspr.dart';
import 'package:shadcn_jaspr/shadcn_jaspr.dart';

class ShowcasePage extends StatelessComponent {
  const ShowcasePage({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      [
        // Header
        div(
          [
            h1([text('shadcn_jaspr')], classes: 'text-4xl font-bold tracking-tight'),
            p([text('A Dart port of shadcn/ui for Jaspr')],
                classes: 'text-lg text-muted-foreground mt-2'),
          ],
          classes: 'mb-12',
        ),

        // Buttons
        _section('Button', [
          div(
            [
              ShadButton([text('Default')]),
              ShadButton([text('Destructive')], variant: ButtonVariant.destructive),
              ShadButton([text('Outline')], variant: ButtonVariant.outline),
              ShadButton([text('Secondary')], variant: ButtonVariant.secondary),
              ShadButton([text('Ghost')], variant: ButtonVariant.ghost),
              ShadButton([text('Link')], variant: ButtonVariant.link),
            ],
            classes: 'flex flex-wrap gap-3',
          ),
          div(
            [
              ShadButton([text('Small')], size: ButtonSize.sm),
              ShadButton([text('Default')]),
              ShadButton([text('Large')], size: ButtonSize.lg),
              ShadButton([text('Disabled')], isDisabled: true),
            ],
            classes: 'flex flex-wrap items-center gap-3 mt-4',
          ),
        ]),

        // Badge
        _section('Badge', [
          div(
            [
              ShadBadge([text('Default')]),
              ShadBadge([text('Secondary')], variant: BadgeVariant.secondary),
              ShadBadge([text('Destructive')], variant: BadgeVariant.destructive),
              ShadBadge([text('Outline')], variant: BadgeVariant.outline),
            ],
            classes: 'flex flex-wrap gap-3',
          ),
        ]),

        // Card
        _section('Card', [
          ShadCard([
            ShadCardHeader([
              ShadCardTitle([text('Card Title')]),
              ShadCardDescription([text('Card description goes here.')]),
            ]),
            ShadCardContent([
              p([text('Card content area. Put any components here.')]),
            ]),
            ShadCardFooter([
              ShadButton([text('Cancel')], variant: ButtonVariant.outline),
              ShadButton([text('Save')]),
            ]),
          ]),
        ]),

        // Input & Label
        _section('Input & Label', [
          div(
            [
              div(
                [
                  ShadLabel([text('Email')], htmlFor: 'email'),
                  ShadInput(id: 'email', type: InputType.email, placeholder: 'Enter your email'),
                ],
                classes: 'grid gap-2 max-w-sm',
              ),
              div(
                [
                  ShadLabel([text('Disabled')]),
                  ShadInput(placeholder: 'Disabled input', isDisabled: true),
                ],
                classes: 'grid gap-2 max-w-sm',
              ),
            ],
            classes: 'flex flex-wrap gap-8',
          ),
        ]),

        // Textarea
        _section('Textarea', [
          div(
            [
              ShadLabel([text('Message')]),
              ShadTextarea(placeholder: 'Type your message here...'),
            ],
            classes: 'grid gap-2 max-w-lg',
          ),
        ]),

        // Separator
        _section('Separator', [
          div(
            [
              p([text('Content above')]),
              ShadSeparator(),
              p([text('Content below')]),
            ],
            classes: 'space-y-4 max-w-sm',
          ),
        ]),

        // Checkbox
        _section('Checkbox', [
          div(
            [
              div(
                [ShadCheckbox(checked: true), ShadLabel([text('Accept terms and conditions')])],
                classes: 'flex items-center gap-2',
              ),
              div(
                [ShadCheckbox(isDisabled: true), ShadLabel([text('Disabled checkbox')])],
                classes: 'flex items-center gap-2',
              ),
            ],
            classes: 'space-y-4',
          ),
        ]),

        // Switch
        _section('Switch', [
          div(
            [
              div(
                [ShadSwitch(), ShadLabel([text('Airplane Mode')])],
                classes: 'flex items-center gap-2',
              ),
              div(
                [ShadSwitch(size: SwitchSize.sm), ShadLabel([text('Small switch')])],
                classes: 'flex items-center gap-2',
              ),
            ],
            classes: 'space-y-4',
          ),
        ]),

        // Select
        _section('Select', [
          ShadSelect(
            children: [
              ShadSelectTrigger(
                [ShadSelectValue(placeholder: 'Select a fruit')],
                className: 'w-[180px]',
              ),
              ShadSelectContent([
                ShadSelectItem(value: 'apple', children: [text('Apple')]),
                ShadSelectItem(value: 'banana', children: [text('Banana')]),
                ShadSelectItem(value: 'orange', children: [text('Orange')]),
                ShadSelectSeparator(),
                ShadSelectItem(value: 'grape', children: [text('Grape')]),
              ]),
            ],
          ),
        ]),

        // Radio Group
        _section('Radio Group', [
          ShadRadioGroup(
            value: 'comfortable',
            children: [
              div([ShadRadioGroupItem(value: 'default'), ShadLabel([text('Default')])],
                  classes: 'flex items-center gap-2'),
              div([ShadRadioGroupItem(value: 'comfortable'), ShadLabel([text('Comfortable')])],
                  classes: 'flex items-center gap-2'),
              div([ShadRadioGroupItem(value: 'compact'), ShadLabel([text('Compact')])],
                  classes: 'flex items-center gap-2'),
            ],
          ),
        ]),

        // Tabs
        _section('Tabs', [
          ShadTabs(
            defaultValue: 'account',
            children: [
              ShadTabsList([
                ShadTabsTrigger(value: 'account', children: [text('Account')]),
                ShadTabsTrigger(value: 'password', children: [text('Password')]),
              ]),
              ShadTabsContent(
                value: 'account',
                children: [
                  ShadCard([
                    ShadCardHeader([
                      ShadCardTitle([text('Account')]),
                      ShadCardDescription([text('Make changes to your account here.')]),
                    ]),
                    ShadCardContent([
                      div([ShadLabel([text('Name')]), ShadInput(placeholder: 'Your name')],
                          classes: 'grid gap-2'),
                    ]),
                    ShadCardFooter([ShadButton([text('Save changes')])]),
                  ]),
                ],
              ),
              ShadTabsContent(
                value: 'password',
                children: [
                  ShadCard([
                    ShadCardHeader([
                      ShadCardTitle([text('Password')]),
                      ShadCardDescription([text('Change your password here.')]),
                    ]),
                    ShadCardContent([
                      div(
                        [
                          ShadLabel([text('Current password')]),
                          ShadInput(type: InputType.password),
                          ShadLabel([text('New password')]),
                          ShadInput(type: InputType.password),
                        ],
                        classes: 'grid gap-2',
                      ),
                    ]),
                    ShadCardFooter([ShadButton([text('Save password')])]),
                  ]),
                ],
              ),
            ],
          ),
        ]),

        // Breadcrumb
        _section('Breadcrumb', [
          ShadBreadcrumb([
            ShadBreadcrumbList([
              ShadBreadcrumbItem([ShadBreadcrumbLink([text('Home')], href: '/')]),
              ShadBreadcrumbSeparator(),
              ShadBreadcrumbItem([ShadBreadcrumbLink([text('Components')], href: '/components')]),
              ShadBreadcrumbSeparator(),
              ShadBreadcrumbItem([ShadBreadcrumbPage([text('Breadcrumb')])]),
            ]),
          ]),
        ]),

        // Pagination
        _section('Pagination', [
          ShadPagination([
            ShadPaginationContent([
              ShadPaginationItem([ShadPaginationPrevious()]),
              ShadPaginationItem([ShadPaginationLink([text('1')], isActive: true)]),
              ShadPaginationItem([ShadPaginationLink([text('2')])]),
              ShadPaginationItem([ShadPaginationLink([text('3')])]),
              ShadPaginationItem([ShadPaginationEllipsis()]),
              ShadPaginationItem([ShadPaginationNext()]),
            ]),
          ]),
        ]),

        // Dialog
        _section('Dialog', [
          ShadDialog(
            children: [
              ShadDialogTrigger([
                ShadButton([text('Open Dialog')], variant: ButtonVariant.outline),
              ]),
              ShadDialogContent([
                ShadDialogHeader([
                  ShadDialogTitle([text('Are you sure?')]),
                  ShadDialogDescription([
                    text('This action cannot be undone. This will permanently delete your account.'),
                  ]),
                ]),
                ShadDialogFooter([
                  ShadButton([text('Cancel')], variant: ButtonVariant.outline),
                  ShadButton([text('Continue')]),
                ]),
              ]),
            ],
          ),
        ]),

        // Sheet
        _section('Sheet', [
          ShadSheet(
            children: [
              ShadSheetTrigger([
                ShadButton([text('Open Sheet')], variant: ButtonVariant.outline),
              ]),
              ShadSheetContent(
                [
                  ShadSheetHeader([
                    ShadSheetTitle([text('Edit profile')]),
                    ShadSheetDescription([text('Make changes to your profile here.')]),
                  ]),
                  div(
                    [
                      ShadLabel([text('Name')]),
                      ShadInput(placeholder: 'Your name'),
                      ShadLabel([text('Username')]),
                      ShadInput(placeholder: '@username'),
                    ],
                    classes: 'grid gap-4 p-4',
                  ),
                  ShadSheetFooter([ShadButton([text('Save changes')])]),
                ],
                side: SheetSide.right,
              ),
            ],
          ),
        ]),

        // Dropdown Menu
        _section('Dropdown Menu', [
          ShadDropdownMenu(
            children: [
              ShadDropdownMenuTrigger([
                ShadButton([text('Open Menu')], variant: ButtonVariant.outline),
              ]),
              ShadDropdownMenuContent([
                ShadDropdownMenuLabel([text('My Account')]),
                ShadDropdownMenuSeparator(),
                ShadDropdownMenuItem([text('Profile')]),
                ShadDropdownMenuItem([text('Billing')]),
                ShadDropdownMenuItem([text('Settings')]),
                ShadDropdownMenuSeparator(),
                ShadDropdownMenuItem([text('Log out')],
                    variant: DropdownMenuItemVariant.destructive),
              ]),
            ],
          ),
        ]),

        // Tooltip
        _section('Tooltip', [
          ShadTooltip(
            children: [
              ShadTooltipTrigger([
                ShadButton([text('Hover me')], variant: ButtonVariant.outline),
              ]),
              ShadTooltipContent([text('This is a tooltip')], side: TooltipSide.top),
            ],
          ),
        ]),

        // Popover
        _section('Popover', [
          ShadPopover(
            children: [
              ShadPopoverTrigger([
                ShadButton([text('Open Popover')], variant: ButtonVariant.outline),
              ]),
              ShadPopoverContent([
                div(
                  [
                    h4([text('Dimensions')], classes: 'font-medium leading-none'),
                    p([text('Set the dimensions for the layer.')],
                        classes: 'text-sm text-muted-foreground'),
                  ],
                  classes: 'grid gap-2',
                ),
              ]),
            ],
          ),
        ]),
      ],
      classes: 'container mx-auto max-w-4xl py-12 px-4',
    );
  }
}

Component _section(String title, List<Component> children) {
  return div(
    [
      h2([text(title)], classes: 'text-2xl font-semibold tracking-tight mb-4'),
      ...children,
    ],
    classes: 'mb-12',
  );
}
