import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../components/button.dart';
import '../components/card.dart';
import '../components/input.dart';
import '../components/label.dart';
import '../utils/cn.dart';

/// Login block 03 — Card on muted background.
class ShadLoginBlock03 extends StatelessComponent {
  final String? className;
  final void Function()? onSubmit;

  const ShadLoginBlock03({this.className, this.onSubmit, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [
        div(
          [
            ShadCard([
              ShadCardHeader([
                ShadCardTitle([Component.text('Sign in')]),
                ShadCardDescription([
                  Component.text('Enter your email and password to continue'),
                ]),
              ]),
              ShadCardContent([
                div([
                  div([
                    ShadLabel([Component.text('Email')], htmlFor: 'login03-email'),
                    ShadInput(
                      id: 'login03-email',
                      type: InputType.email,
                      placeholder: 'you@example.com',
                    ),
                  ], classes: 'grid gap-2'),
                  div([
                    div([
                      ShadLabel([Component.text('Password')], htmlFor: 'login03-password'),
                      a([Component.text('Forgot password?')],
                          href: '#',
                          classes: 'text-sm underline-offset-4 hover:underline ml-auto'),
                    ], classes: 'flex items-center justify-between'),
                    ShadInput(
                      id: 'login03-password',
                      type: InputType.password,
                    ),
                  ], classes: 'grid gap-2'),
                  ShadButton(
                    [Component.text('Sign in')],
                    className: 'w-full',
                    onPressed: onSubmit,
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
          classes: 'w-full max-w-md',
        ),
      ],
      classes: cn([
        'flex min-h-[600px] items-center justify-center rounded-xl bg-muted/40 p-6',
        className,
      ]),
      attributes: {'data-slot': 'login-block-03'},
    );
  }
}
