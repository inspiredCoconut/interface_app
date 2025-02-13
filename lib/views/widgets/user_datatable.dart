import 'package:flutter/material.dart';
import 'package:interface_app/data/models/user_model.dart';

class UserDataTable extends StatefulWidget {
  final List<User> users;

  const UserDataTable({super.key, required this.users});

  @override
  _UserDataTableState createState() => _UserDataTableState();
}

class _UserDataTableState extends State<UserDataTable> {
  final TextEditingController _searchController = TextEditingController();
  List<User> _filteredUsers = [];
  int _sortColumnIndex = 0;
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _filteredUsers = widget.users;
    _searchController.addListener(_filterUsers);
  }

  void _filterUsers() {
    setState(() {
      _filteredUsers = widget.users
          .where((user) => user.name
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _sort<T>(Comparable<T> Function(User user) getField, int columnIndex, bool ascending) {
    _filteredUsers.sort((a, b) {
      if (!ascending) {
        final User c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _isAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search by name',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: const Text('Name'),
                  onSort: (columnIndex, ascending) =>
                      _sort<String>((user) => user.name, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Age'),
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((user) => user.age, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text('Role'),
                  onSort: (columnIndex, ascending) =>
                      _sort<String>((user) => user.role, columnIndex, ascending),
                ),
              ],
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _isAscending,
              rows: List<DataRow>.generate(
                _filteredUsers.length,
                (index) => DataRow(
                  cells: <DataCell>[
                    DataCell(Text(_filteredUsers[index].name)),
                    DataCell(Text(_filteredUsers[index].age.toString())),
                    DataCell(Text(_filteredUsers[index].role)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}