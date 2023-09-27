import 'package:expenses_off/core/configs/dependency_injection.dart';
import 'package:expenses_off/features/expense/presentation/pages/expense_detail_page.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ExpenseDetailPage(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocConsumer<ExpensesCubit, ExpensesState>(
        bloc: bloc,
        listenWhen: (previous, current) => current is ExpensesWarning,
        listener: (BuildContext context, ExpensesState state) {
          if (state is ExpensesWarning) {
            final snackBar = SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 2),
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
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12.0), // Borda arredondada
                        ),
                        child: ExpansionTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12.0), // Borda arredondada
                          ),
                          key: Key(expense.id),
                          title: Text(expense.description),
                          subtitle: Text(expense.amount.toString()),
                          leading: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ExpenseDetailPage(
                                      expense: expense,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit)),
                          onExpansionChanged: (value) {
                            if (expense.paymentReceipt == null) {
                              bloc.getPaymentReceipt(expenseId: expense.id);
                            }
                          },
                          children: [
                            BlocListener<ExpensesCubit, ExpensesState>(
                              bloc: bloc,
                              listenWhen: (previous, current) =>
                                  current is ExpensePaymentReceiptLoaded,
                              listener: (context, state) {
                                if (state is ExpensePaymentReceiptLoaded) {
                                  expense.copyWith(
                                      paymentReceipt: state.paymentReceipt);
                                }
                              },
                              child: SizedBox(
                                  height: 250,
                                  width: 300,
                                  child: expense.paymentReceipt != null
                                      ? Image.network(expense.paymentReceipt!)
                                      : const CircularProgressIndicator()),
                            ),
                          ],
                        ),
                      ),
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
