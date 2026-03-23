import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../components/button.dart';
import '../components/card.dart';
import '../components/input.dart';
import '../components/label.dart';
import '../components/separator.dart';
import '../utils/cn.dart';

/// Signup block 05 — Simple form with social OAuth buttons.
class ShadSignupBlock05 extends StatelessComponent {
  final String? className;
  final void Function()? onSubmit;

  const ShadSignupBlock05({this.className, this.onSubmit, super.key});

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
                  Component.text('Choose your preferred sign up method'),
                ]),
              ]),
              ShadCardContent([
                div([
                  div([
                    ShadButton(
                      [Component.text('Continue with Google')],
                      variant: ButtonVariant.outline,
                      className: 'w-full',
                    ),
                    ShadButton(
                      [Component.text('Continue with GitHub')],
                      variant: ButtonVariant.outline,
                      className: 'w-full',
                    ),
                  ], classes: 'grid gap-2'),
                  div([
                    ShadSeparator(),
                  ], classes: 'relative my-2'),
                  div([
                    div([
                      ShadLabel([Component.text('Email')], htmlFor: 'signup05-email'),
                      ShadInput(
                        id: 'signup05-email',
                        type: InputType.email,
                        placeholder: 'm@example.com',
                      ),
                    ], classes: 'grid gap-2'),
                    div([
                      ShadLabel([Component.text('Password')],
                          htmlFor: 'signup05-password'),
                      ShadInput(
                        id: 'signup05-password',
                        type: InputType.password,
                      ),
                    ], classes: 'grid gap-2'),
                    ShadButton(
                      [Component.text('Create Account')],
                      className: 'w-full',
                      onPressed: onSubmit,
                    ),
                  ], classes: 'grid gap-4'),
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
      attributes: {'data-slot': 'signup-block-05'},
    );
  }
}
