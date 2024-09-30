import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos_bloc/edit_todo/bloc/edit_todo_bloc.dart';
import 'package:flutter_todos_bloc/l10n/l10n.dart';
import 'package:todos_repository/todos_repository.dart';

class EditTodoPage extends StatelessWidget {
  const EditTodoPage({super.key});

  static Route<void> route({Todo? initialTodo}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (ctx) => BlocProvider(
        create: (ctx) => EditTodoBloc(
          todoRepository: ctx.read<TodosRepository>(),
          initialTodo: initialTodo,
        ),
        child: const EditTodoPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTodoBloc, EditTodoState>(
      listenWhen: (previous, current) {
        return previous.status != current.status &&
            current.status == EditTodoStatus.success;
      },
      listener: (context, state) {
        return Navigator.of(context).pop();
      },
      child: const EditTodoPageView(),
    );
  }
}

class EditTodoPageView extends StatelessWidget {
  const EditTodoPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final status = context.select((EditTodoBloc bloc) => bloc.state.status);
    final isNewTodo = context.select(
      (EditTodoBloc bloc) => bloc.state.isNewTodo,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewTodo
              ? l10n.editTodoAddAppBarTitle
              : l10n.editTodoEditAppBarTitle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => context.read<EditTodoBloc>().add(
                  const EditTodoSubmitted(),
                ),
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.checkroom_rounded),
      ),
      body: const CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [_TitleField(), _DescriptionField()],
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<EditTodoBloc>().state;

    return TextFormField(
      key: const Key('EditTodo_tittleKey'),
      initialValue: state.tittle,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: l10n.editTodoTitleLabel,
        hintText: state.initialTodo?.title ?? '',
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) => context.read<EditTodoBloc>().add(
            EditTodoTittleChanged(tittle: value),
          ),
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<EditTodoBloc>().state;
    return TextFormField(
      key: const Key('EditTodo_descriptionKey'),
      initialValue: state.description,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: l10n.editTodoDescriptionLabel,
        hintText: state.initialTodo?.description ?? '',
      ),
      maxLength: 50,
      maxLines: 6,
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
      ],
      onChanged: (value) => context
          .read<EditTodoBloc>()
          .add(EditTodoDescriptionChanged(description: value)),
    );
  }
}
