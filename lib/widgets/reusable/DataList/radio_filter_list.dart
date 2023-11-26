import 'package:app/models/user.dart';
import 'package:app/utils/filter.dart';
import 'package:flutter/material.dart';

class RadioFilterList<T> extends StatefulWidget {
  final List<UIFilter<T>> filters;
  final String title;
  final String groupName;

  final Function(UIFilter<T>) onSelectedFilterChanged; // Callback function

  RadioFilterList(
      {Key? key,
      required this.filters,
      required this.title,
      required this.groupName,
      required this.onSelectedFilterChanged})
      : super(key: key);

  @override
  _RadioFilterListState<T> createState() => _RadioFilterListState<T>();
}

class _RadioFilterListState<T> extends State<RadioFilterList<T>> {
  UIFilter<T>? selectedFilter;

  @override
  void initState() {
    super.initState();
    _ensureAnyFilter();
    selectedFilter = widget.filters.first as UIFilter<T>;
  }

  _ensureAnyFilter() {
    List<UIFilter<T>> anyFilters = widget.filters
        .where((element) => element.description == 'Cualquiera')
        .toList();

    if (anyFilters.isEmpty) {
      widget.filters.insert(
        0,
        UIFilter<T>(
          groupName: widget.groupName,
          description: 'Cualquiera',
          testFunction: (_) => true,
        ),
      );
    }
  }

  onFilterSelected(UIFilter<T>? value) {
    setState(() {
      selectedFilter = value;
    });
    widget.onSelectedFilterChanged(value!);
    Navigator.of(context).pop();
  }

  get hasFilterSelected =>
      selectedFilter == null || selectedFilter?.description != 'Cualquiera';

  @override
  Widget build(BuildContext context) {
    _ensureAnyFilter();

    return PopupMenuButton<UIFilter<T>>(
      itemBuilder: (BuildContext context) {
        return widget.filters.map((UIFilter<T> uiFilter) {
          return PopupMenuItem<UIFilter<T>>(
            value: uiFilter,
            child: RadioListTile<UIFilter<T>>(
              title: Text(uiFilter.description),
              value: uiFilter,
              groupValue: selectedFilter,
              onChanged: onFilterSelected,
            ),
          );
        }).toList();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded borders for the menu
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: hasFilterSelected
              ? Colors.blue
              : Colors.grey[200], // Change color based on selection
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              !hasFilterSelected
                  ? widget.title
                  : (selectedFilter?.description)!,
              style: TextStyle(
                  color: hasFilterSelected ? Colors.white : Colors.black),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_drop_down,
                color: hasFilterSelected
                    ? Colors.white
                    : Colors.black), // Dropdown arrow icon
          ],
        ),
      ),
    );
  }
}
