import 'package:expenses_off/core/configs/dependency_injection.dart';
import 'package:expenses_off/features/expense/presentation/state_manager/expenses/expenses_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final _scrollController = ScrollController();
  final bloc = di<ExpensesCubit>();
  final _scrollThreshold = 200.0;
  int page = 1;
  bool noMoreExpenses = false;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    bloc.getExpenses(page: page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            title: const Text('Expenses'),
            expandedHeight: 200,
            pinned: true,
            forceElevated: innerBoxIsScrolled,
          )
        ];
      },
      body: BlocConsumer<ExpensesCubit, ExpensesState>(
        listenWhen: (previous, current) => current is ExpensesWarning,
        listener: (BuildContext context, ExpensesState state) {
          if (state is ExpensesWarning) {
            final snackBar = SnackBar(
              content: Text(state.message),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        buildWhen: (previous, current) =>
            current is ExpensesLoaded ||
            current is ExpensesLoading ||
            current is ExpensesEmpty ||
            current is ExpensesError,
        builder: (BuildContext context, ExpensesState state) {
          switch (state.runtimeType) {
            case ExpensesLoaded:
              final expenses = (state as ExpensesLoaded).expenses;
              return ListView.custom(
                physics: const AlwaysScrollableScrollPhysics(),
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final expense = expenses.elementAt(index);
                    return ExpansionTile(
                      key: Key(expense.id),
                      title: Text(expense.description),
                    );
                  },
                  childCount: expenses.length,
                  findChildIndexCallback: (key) {
                    return expenses.indexWhere((e) => Key(e.id) == key);
                  },
                ),
              );
            case ExpensesLoading:
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  color: Colors.grey,
                ),
              );
            case ExpensesEmpty:
              return const Center(
                child: Text("You don't have expenses at the moment"),
              );
            case ExpensesError:
              return Center(
                child: Text((state as ExpensesError).message),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      page++;
      bloc.getExpenses(page: page);
    }
  }
}
