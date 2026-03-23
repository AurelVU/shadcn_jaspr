import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../components/button.dart';
import '../components/card.dart';
import '../components/input.dart';
import '../components/label.dart';
import '../utils/cn.dart';

/// Login block 04 — Card with side image.
class ShadLoginBlock04 extends StatelessComponent {
  final String? className;
  final void Function()? onSubmit;

  const ShadLoginBlock04({this.className, this.onSubmit, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [
        ShadCard([
          div(
            [
              // Left: image placeholder
              div(
                [
                  div(
                    [Component.text('Image')],
                    classes:
                        'flex h-full min-h-[300px] items-center justify-center rounded-lg bg-muted text-muted-foreground',
                  ),
                ],
                classes: 'hidden md:block',
              ),
              // Right: form
              div(
                [
                  ShadCardHeader([
                    ShadCardTitle([Component.text('Login')]),
                    ShadCardDescription([
                      Component.text('Enter your credentials below'),
                    ]),
                  ]),
                  ShadCardContent([
                    div([
                      div([
                        ShadLabel([Component.text('Email')], htmlFor: 'login04-email'),
                        ShadInput(
                          id: 'login04-email',
                          type: InputType.email,
                          placeholder: 'm@example.com',
                        ),
                      ], classes: 'grid gap-2'),
                      div([
                        ShadLabel([Component.text('Password')], htmlFor: 'login04-password'),
                        ShadInput(
                          id: 'login04-password',
                          type: InputType.password,
                        ),
                      ], classes: 'grid gap-2'),
                      ShadButton(
                        [Component.text('Login')],
                        className: 'w-full',
                        onPressed: onSubmit,
                      ),
                      ShadButton(
                        [Component.text('Login with Google')],
                        variant: ButtonVariant.outline,
                        className: 'w-full',
                      ),
                    ], classes: 'grid gap-4'),
                  ]),
                ],
                classes: 'flex flex-col justify-center',
              ),
            ],
            classes: 'grid md:grid-cols-2 gap-6 p-6',
          ),
        ], className: 'overflow-hidden max-w-3xl w-full'),
      ],
      classes: cn([
        'flex min-h-[600px] items-center justify-center p-6',
        className,
      ]),
      attributes: {'data-slot': 'login-block-04'},
    );
  }
}
