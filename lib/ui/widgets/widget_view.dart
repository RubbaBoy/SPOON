import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spoon/service_locator.dart';

class WidgetView<T extends Model> extends StatefulWidget {
  final ScopedModelDescendantBuilder<T> _builder;
  final Function(T)? onModelReady;
  final Function(T)? onModelEnd;
  final Function(T)? fabAdd;

  const WidgetView(
      {required ScopedModelDescendantBuilder<T> builder,
      this.onModelReady,
      this.onModelEnd,
      this.fabAdd})
      : _builder = builder;

  @override
  _WidgetViewState<T> createState() => _WidgetViewState<T>();
}

class _WidgetViewState<T extends Model> extends State<WidgetView<T>> {
  final T _model = locator<T>();
  ScopedModelDescendantBuilder<T>? otherBuilder;

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady!(_model);
    }

    super.initState();
  }

  @override
  void dispose() {
    if (widget.onModelEnd != null) {
      widget.onModelEnd!(_model);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<T>(
      model: _model,
      child: ScopedModelDescendant<T>(
        builder: (context, child, model) => SafeArea(
          child: widget._builder(context, child, model),
        ),
      ),
    );
  }
}
