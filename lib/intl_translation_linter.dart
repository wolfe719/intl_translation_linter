import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

PluginBase createPlugin() => _ExampleLinter();

/// A plugin class is used to list all the assists/lints defined by a plugin.
class _ExampleLinter extends PluginBase {
  /// We list all the custom warnings/infos/errors
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        IntlTranslationLintRule(),
      ];
}

class IntlTranslationLintRule extends DartLintRule {
  IntlTranslationLintRule() : super(code: _code);

  /// Metadata about the warning that will show-up in the IDE.
  /// This is used for `// ignore: code` and enabling/disabling the lint
  static final _code = LintCode(
    name: 'intl_translation_linter_use_s_role',
    problemMessage: 'Use S.of(context).xxxx or S.current.xxxx to access internationalized strings',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addArgumentList((node) {
      for (final argument in node.arguments) {
        if (getArguments(argument) &&
            argument.staticParameterElement?.type
                    .getDisplayString(withNullability: false) ==
                'String') {
          if (!argument.toSource().contains('S.of(context)') &&
              !argument.toSource().contains('S.current')) {
            reporter.atToken(argument.beginToken, _code, arguments: [], contextMessages: []);
            // reporter.reportErrorForToken(
            //   _code,
            //   argument.beginToken,
            //   [],
            // );
          }
        }
      }
    });
    context.registry.addInstanceCreationExpression((node) {
      final constructorName = node.constructorName;
      if ((constructorName.type.element?.name == 'Text' ||
          constructorName.type.element?.name == 'AutoSizeText')) {
        if (!node.argumentList.toString().contains('S.of(context)') &&
            !node.argumentList.toString().contains('S.current')) {
          reporter.atNode(node, _code, arguments: []);
          // reporter.reportErrorForNode(
          //   _code,
          //   node,
          //   [],
          // );
        }
      }
    });
  }

  bool getArguments(Expression argument) {
    return argument.staticParameterElement?.name == 'label' ||
        argument.staticParameterElement?.name == 'hintText' ||
        argument.staticParameterElement?.name == 'tooltip' ||
        argument.staticParameterElement?.name == 'title' ||
        argument.staticParameterElement?.name == 'text' ||
        argument.staticParameterElement?.name == 'placeholder' ||
        argument.staticParameterElement?.name == 'labelText';
  }
}
