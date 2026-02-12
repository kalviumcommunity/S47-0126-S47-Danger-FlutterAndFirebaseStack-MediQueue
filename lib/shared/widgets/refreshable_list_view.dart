import 'package:flutter/material.dart';

class RefreshableListView extends StatefulWidget {
  final List<String> items;
  const RefreshableListView({Key? key, required this.items}) : super(key: key);

  @override
  State<RefreshableListView> createState() => _RefreshableListViewState();
}

class _RefreshableListViewState extends State<RefreshableListView> {
  late List<String> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _items.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) => ListTile(title: Text(_items[index])),
      ),
    );
  }
}
