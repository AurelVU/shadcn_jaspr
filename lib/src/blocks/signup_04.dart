import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../components/button.dart';
import '../components/card.dart';
import '../components/input.dart';
import '../components/label.dart';
import '../utils/cn.dart';

/// Signup block 04 — Card with side image.
class ShadSignupBlock04 extends StatelessComponent {
  final String? className;
  final void Function()? onSubmit;

  const ShadSignupBlock04({this.className, this.onSubmit, super.key});

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
                    ShadCardTitle([Component.text('Sign Up')]),
                    ShadCardDescription([
                      Component.text('Create a new account'),
                    ]),
                  ]),
                  ShadCardContent([
                    div([
                      div([
                        ShadLabel([Component.text('Name')], htmlFor: 'signup04-name'),
                        ShadInput(
                          id: 'signup04-name',
                          placeholder: 'John Doe',
                        ),
                      ], classes: 'grid gap-2'),
                      div([
                        ShadLabel([Component.text('Email')], htmlFor: 'signup04-email'),
                        ShadInput(
                          id: 'signup04-email',
                          type: InputType.email,
                          placeholder: 'm@example.com',
                        ),
                      ], classes: 'grid gap-2'),
                      div([
                        ShadLabel([Component.text('Password')],
                            htmlFor: 'signup04-password'),
                        ShadInput(
                          id: 'signup04-password',
                          type: InputType.password,
                        ),
                      ], classes: 'grid gap-2'),
                      ShadButton(
                        [Component.text('Create Account')],
                        className: 'w-full',
                        onPressed: onSubmit,
                      ),
                      ShadButton(
                        [Component.text('Sign up with Google')],
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
      attributes: {'data-slot': 'signup-block-04'},
    );
  }
}
