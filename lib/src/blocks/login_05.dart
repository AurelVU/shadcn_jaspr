import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../components/button.dart';
import '../components/card.dart';
import '../components/input.dart';
import '../components/label.dart';
import '../utils/cn.dart';

/// Login block 05 — Email-only minimal form.
class ShadLoginBlock05 extends StatelessComponent {
  final String? className;
  final void Function()? onSubmit;

  const ShadLoginBlock05({this.className, this.onSubmit, super.key});

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
                  Component.text("We'll send you a magic link to sign in"),
                ]),
              ]),
              ShadCardContent([
                div([
                  div([
                    ShadLabel([Component.text('Email')], htmlFor: 'login05-email'),
                    ShadInput(
                      id: 'login05-email',
                      type: InputType.email,
                      placeholder: 'you@example.com',
                    ),
                  ], classes: 'grid gap-2'),
                  ShadButton(
                    [Component.text('Send Magic Link')],
                    className: 'w-full',
                    onPressed: onSubmit,
                  ),
                ], classes: 'grid gap-4'),
              ]),
              ShadCardFooter([
                p([
                  Component.text('Back to '),
                  a([Component.text('sign in with password')],
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
      attributes: {'data-slot': 'login-block-05'},
    );
  }
}
