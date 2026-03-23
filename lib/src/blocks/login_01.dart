import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../components/button.dart';
import '../components/card.dart';
import '../components/input.dart';
import '../components/label.dart';
import '../components/separator.dart';
import '../utils/cn.dart';

/// Login block 01 — Simple centered card login form.
class ShadLoginBlock01 extends StatelessComponent {
  final String? className;
  final void Function()? onSubmit;

  const ShadLoginBlock01({this.className, this.onSubmit, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [
        div(
          [
            ShadCard([
              ShadCardHeader([
                ShadCardTitle([Component.text('Login')]),
                ShadCardDescription([
                  Component.text('Enter your credentials to access your account'),
                ]),
              ]),
              ShadCardContent([
                div([
                  div([
                    ShadLabel([Component.text('Email')], htmlFor: 'login01-email'),
                    ShadInput(
                      id: 'login01-email',
                      type: InputType.email,
                      placeholder: 'm@example.com',
                    ),
                  ], classes: 'grid gap-2'),
                  div([
                    ShadLabel([Component.text('Password')], htmlFor: 'login01-password'),
                    ShadInput(
                      id: 'login01-password',
                      type: InputType.password,
                      placeholder: 'Enter your password',
                    ),
                  ], classes: 'grid gap-2'),
                  ShadButton(
                    [Component.text('Sign In')],
                    className: 'w-full',
                    onPressed: onSubmit,
                  ),
                  div([
                    ShadSeparator(),
                  ], classes: 'relative my-2'),
                  ShadButton(
                    [Component.text('Sign in with Google')],
                    variant: ButtonVariant.outline,
                    className: 'w-full',
                  ),
                ], classes: 'grid gap-4'),
              ]),
              ShadCardFooter([
                p([
                  Component.text("Don't have an account? "),
                  a([Component.text('Sign up')],
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
      attributes: {'data-slot': 'login-block-01'},
    );
  }
}
