import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../components/button.dart';
import '../components/card.dart';
import '../components/input.dart';
import '../components/label.dart';
import '../utils/cn.dart';

/// Signup block 01 — Simple centered card signup form.
class ShadSignupBlock01 extends StatelessComponent {
  final String? className;
  final void Function()? onSubmit;

  const ShadSignupBlock01({this.className, this.onSubmit, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [
        div(
          [
            ShadCard([
              ShadCardHeader([
                ShadCardTitle([Component.text('Create an account')]),
                ShadCardDescription([
                  Component.text('Enter your information to get started'),
                ]),
              ]),
              ShadCardContent([
                div([
                  div([
                    ShadLabel([Component.text('Name')], htmlFor: 'signup01-name'),
                    ShadInput(
                      id: 'signup01-name',
                      placeholder: 'John Doe',
                    ),
                  ], classes: 'grid gap-2'),
                  div([
                    ShadLabel([Component.text('Email')], htmlFor: 'signup01-email'),
                    ShadInput(
                      id: 'signup01-email',
                      type: InputType.email,
                      placeholder: 'm@example.com',
                    ),
                  ], classes: 'grid gap-2'),
                  div([
                    ShadLabel([Component.text('Password')], htmlFor: 'signup01-password'),
                    ShadInput(
                      id: 'signup01-password',
                      type: InputType.password,
                    ),
                  ], classes: 'grid gap-2'),
                  div([
                    ShadLabel([Component.text('Confirm Password')],
                        htmlFor: 'signup01-confirm'),
                    ShadInput(
                      id: 'signup01-confirm',
                      type: InputType.password,
                    ),
                  ], classes: 'grid gap-2'),
                  ShadButton(
                    [Component.text('Create Account')],
                    className: 'w-full',
                    onPressed: onSubmit,
                  ),
                ], classes: 'grid gap-4'),
              ]),
              ShadCardFooter([
                p([
                  Component.text('Already have an account? '),
                  a([Component.text('Sign in')],
                      href: '#',
                      classes: 'underline underline-offset-4 hover:text-primary'),
                ], classes: 'text-sm text-center text-muted-foreground w-full'),
              ]),
            ]),
          ],
          classes: 'w-full max-w-sm',
        ),
      ],
      classes: cn([
        'flex min-h-[600px] items-center justify-center p-6',
        className,
      ]),
      attributes: {'data-slot': 'signup-block-01'},
    );
  }
}
