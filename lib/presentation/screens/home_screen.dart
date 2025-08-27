import 'package:double_v_partners_tt/domain/models/user_model.dart';
import 'package:double_v_partners_tt/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:double_v_partners_tt/presentation/cubits/user_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _rowsPerPage = 5;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  late UserDataSource _dataTableSource;

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().fetchAllUsers().then((_) {
      final state = context.read<UserCubit>().state;
      state.maybeMap(
        loadedAll: (loadedAll) {
          _dataTableSource = UserDataSource(loadedAll.users);
        },
        orElse: () {},
      );
    });
  }

  void _sort<T>(
    Comparable<T> Function(User user) getField,
    int columnIndex,
    bool ascending,
  ) {
    _dataTableSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registered Users'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return state.maybeMap(
            loading: (_) => const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            ),
            loadedAll: (loadedAll) {
              _dataTableSource.updateUsers(loadedAll.users);
              return SingleChildScrollView(
                child: PaginatedDataTable(
                  headingRowColor: WidgetStateProperty.all(
                    AppColors.lowGradientColor.withAlpha(160),
                  ),
                  rowsPerPage: _rowsPerPage,
                  availableRowsPerPage: const [5, 10, 20],
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  onRowsPerPageChanged: (value) {
                    setState(() {
                      _rowsPerPage = value!;
                    });
                  },
                  columns: [
                    DataColumn(
                      label: const Text(
                        'First Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onSort: (colIndex, asc) =>
                          _sort<String>((u) => u.firstName, colIndex, asc),
                    ),
                    DataColumn(
                      label: const Text(
                        'Last Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onSort: (colIndex, asc) =>
                          _sort<String>((u) => u.lastName, colIndex, asc),
                    ),
                    DataColumn(
                      label: const Text(
                        'Email',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onSort: (colIndex, asc) =>
                          _sort<String>((u) => u.email, colIndex, asc),
                    ),
                    DataColumn(
                      label: const Text(
                        'Birthdate',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onSort: (colIndex, asc) =>
                          _sort<DateTime>((u) => u.birthdate, colIndex, asc),
                    ),
                  ],
                  source: _dataTableSource,
                ),
              );
            },
            error: (error) => Center(
              child: Text(
                error.message,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
            orElse: () => const Center(
              child: Text('No users available', style: TextStyle(fontSize: 18)),
            ),
          );
        },
      ),
    );
  }

  void _logout() {}
}

class UserDataSource extends DataTableSource {
  List<User> _users = [];

  UserDataSource(List<User> users) : _users = List.of(users);

  void updateUsers(List<User> users) {
    _users = users;
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _users.length) return null;
    final user = _users[index];
    return DataRow(
      cells: [
        DataCell(Text(user.firstName)),
        DataCell(Text(user.lastName)),
        DataCell(Text(user.email)),
        DataCell(Text(user.birthdate.toIso8601String().split('T')[0])),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _users.length;

  @override
  int get selectedRowCount => 0;

  @override
  void sort<T>(Comparable<T> Function(User user) getField, bool ascending) {
    final sortedUsers = List<User>.from(_users);
    sortedUsers.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }
}
