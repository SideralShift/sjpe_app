import 'package:app/models/user.dart';
import 'package:app/utils/filter.dart';
import 'package:flutter/material.dart';

import 'radio_filter_list.dart';

import 'package:flutter/material.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext context, T item);
typedef ItemFilter<T> = bool Function(T item, String query);

class DataList<T> extends StatefulWidget {
  final List<T> items;
  final ItemBuilder<T> itemBuilder;
  final ItemFilter<T> itemFilter;
  final List<RadioFilterList<T>>? filters;
  final List<UIFilter<T>> selectedFilters; // New parameter


  DataList({
    Key? key,
    required this.items,
    required this.itemBuilder,
    required this.itemFilter,
    required this.selectedFilters,
    this.filters,
  }) : super(key: key);

  @override
  _DataListState<T> createState() => _DataListState<T>();
}

class _DataListState<T> extends State<DataList<T>> {
  String searchQuery = '';
  

  @override
  void initState() {
    super.initState();
  }

  List<T> _applyFilters(List<T> itemsToFilter) {
    return itemsToFilter.where((T item) {
        // Apply both the search filter and each of the selected UI filters
        return widget.itemFilter(item, searchQuery) &&
               widget.selectedFilters.every((filter) => filter.testFunction(item));
      }).toList();
  }

  void _updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<T> items = _applyFilters(widget.items);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            onChanged: _updateSearchQuery,
            decoration: InputDecoration(
              labelText: 'Buscar',
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.grey[200], // Lighter gray background
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
          ),
        ),
        if (widget.filters != null) // Check if radio filters are provided
          Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), child: Row(
            children:
                widget.filters!,
          ),),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return widget.itemBuilder(context, items[index]);
            },
          ),
        ),
      ],
    );
  }
}
