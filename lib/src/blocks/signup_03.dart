import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../components/button.dart';
import '../components/card.dart';
import '../components/input.dart';
import '../components/label.dart';
import '../utils/cn.dart';

/// Signup block 03 — Card on muted background.
class ShadSignupBlock03 extends StatelessComponent {
  final String? className;
  final void Function()? onSubmit;

  const ShadSignupBlock03({this.className, this.onSubmit, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [
        div(
          [
            ShadCard([
              ShadCardHeader([
                ShadCardTitle([Component.text('Sign Up')]),
                ShadCardDescription([
                  Component.text('Create your account to get started'),
                ]),
              ]),
              ShadCardContent([
                div([
                  div([
                    ShadLabel([Component.text('Name')], htmlFor: 'signup03-name'),
                    ShadInput(
                      id: 'signup03-name',
                      placeholder: 'John Doe',
                    ),
                  ], classes: 'grid gap-2'),
                  div([
                    ShadLabel([Component.text('Email')], htmlFor: 'signup03-email'),
                    ShadInput(
                      id: 'signup03-email',
                      type: InputType.email,
                      placeholder: 'you@example.com',
                    ),
                  ], classes: 'grid gap-2'),
                  div([
                    ShadLabel([Component.text('Password')], htmlFor: 'signup03-password'),
                    ShadInput(
                      id: 'signup03-password',
                      type: InputType.password,
                    ),
                  ], classes: 'grid gap-2'),
                  div([
                    ShadLabel([Component.text('Confirm Password')],
                        htmlFor: 'signup03-confirm'),
                    ShadInput(
                      id: 'signup03-confirm',
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
          classes: 'w-full max-w-md',
        ),
      ],
      classes: cn([
        'flex min-h-[600px] items-center justify-center rounded-xl bg-muted/40 p-6',
        className,
      ]),
      attributes: {'data-slot': 'signup-block-03'},
    );
  }
}
