import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../components/button.dart';
import '../components/input.dart';
import '../components/label.dart';
import '../utils/cn.dart';

/// Signup block 02 — Two-column layout with image.
class ShadSignupBlock02 extends StatelessComponent {
  final String? className;
  final void Function()? onSubmit;

  const ShadSignupBlock02({this.className, this.onSubmit, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [
        // Left: form
        div(
          [
            div(
              [
                h1([Component.text('Create an account')],
                    classes: 'text-2xl font-bold tracking-tight'),
                p([Component.text('Enter your details below to create your account')],
                    classes: 'text-muted-foreground text-sm mt-2'),
                div([
                  div([
                    ShadLabel([Component.text('Name')], htmlFor: 'signup02-name'),
                    ShadInput(
                      id: 'signup02-name',
                      placeholder: 'John Doe',
                    ),
                  ], classes: 'grid gap-2'),
                  div([
                    ShadLabel([Component.text('Email')], htmlFor: 'signup02-email'),
                    ShadInput(
                      id: 'signup02-email',
                      type: InputType.email,
                      placeholder: 'm@example.com',
                    ),
                  ], classes: 'grid gap-2'),
                  div([
                    ShadLabel([Component.text('Password')], htmlFor: 'signup02-password'),
                    ShadInput(
                      id: 'signup02-password',
                      type: InputType.password,
                    ),
                  ], classes: 'grid gap-2'),
                  ShadButton(
                    [Component.text('Sign Up')],
                    className: 'w-full',
                    onPressed: onSubmit,
                  ),
                  ShadButton(
                    [Component.text('Sign up with Google')],
                    variant: ButtonVariant.outline,
                    className: 'w-full',
                  ),
                ], classes: 'grid gap-4 mt-6'),
                p([
                  Component.text('Already have an account? '),
                  a([Component.text('Sign in')],
                      href: '#',
                      classes: 'underline underline-offset-4 hover:text-primary'),
                ], classes: 'text-sm text-center text-muted-foreground mt-4'),
              ],
              classes: 'w-full max-w-sm mx-auto',
            ),
          ],
          classes: 'flex items-center justify-center p-8',
        ),
        // Right: image placeholder
        div(
          [
            div(
              [Component.text('Image')],
              classes:
                  'flex h-full min-h-[400px] items-center justify-center rounded-xl bg-muted text-muted-foreground',
            ),
          ],
          classes: 'hidden lg:block p-8',
        ),
      ],
      classes: cn([
        'grid lg:grid-cols-2 min-h-[600px]',
        className,
      ]),
      attributes: {'data-slot': 'signup-block-02'},
    );
  }
}
