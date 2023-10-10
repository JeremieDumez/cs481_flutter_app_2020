import 'package:app/Networking/APIRequest.dart';
import 'package:app/Networking/classes.dart';
import 'package:app/Widget/flipped_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/localization.dart';
import 'package:app/globals.dart' as global;

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.visible}) : super(key: key);

  final bool visible;
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _researchController;
  List<GalleryImage> _items;
  bool _isLoading = false;
  int _searchPage = 1;
  int _selected = 0;
  SearchWindowType _window = SearchWindowType.all;

  @override
  void initState() {
    _researchController = TextEditingController();
    _items = List<GalleryImage>();
    getResearchData(
        getGallerySearch("top", _window, _searchPage, "", global.accessToken));
    super.initState();
  }

  //dump results
  @override
  void dispose() {
    _researchController.dispose();
    super.dispose();
  }

  //populate search data
  void getResearchData(Future research) async {
    research.then((result) {
      if (mounted) {
        setState(() {
          for (int i = 0; i != result.data.length; i++)
            if (!_items.contains(result.data[i])) _items.add(result.data[i]);
          _isLoading = false;
        });
      }
    });
  }

  //clear and repopulate search data
  void getNewResearchData(Future research) async {
    research.then((result) {
      if (mounted) {
        setState(() {
          _items.clear();
          _searchPage = 1;
          for (int i = 0; i != result.data.length; i++)
            if (!_items.contains(result.data[i])) _items.add(result.data[i]);
          _isLoading = false;
        });
      }
    });
  }

  //Build results
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _researchController,
            onChanged: (text) {
              getNewResearchData(getGallerySearch(
                  "top", _window, _searchPage, text, global.accessToken));
            },
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context).hintSearch,
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                    onPressed: () => {
                      _researchController.clear(),
                      setState(() => _items.clear())
                    },
                    icon: Icon(Icons.clear))),
          ),
        ),
        Container(
          height: 70,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: SearchWindowType.values.map<Widget>((SearchWindowType value) {
              return DropdownMenuItem<SearchWindowType>(
                  value: value,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: FilterChip(
                        selected: windowTypeIndex(value) == _selected ? true : false,
                        selectedColor: Colors.greenAccent,
                        checkmarkColor: Theme.of(context).primaryColor,
                        label: Text(windowTypeName(value),
                            style: TextStyle(
                                color: windowTypeIndex(value) == _selected
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).accentColor)),
                        onSelected: (selected) {
                          setState(() {
                            _selected = windowTypeIndex(value);
                            _items.clear();
                          });
                          getNewResearchData(getGallerySearch(
                            "top", _window, _searchPage, _researchController.text, global.accessToken));
                        },
                      )));
            }).toList(),
          ),
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!_isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                setState(() {
                  _searchPage += 1;
                });
                getResearchData(getGallerySearch("top", _window, _searchPage,
                    _researchController.text, global.accessToken));
                setState(() {
                  _isLoading = true;
                });
              }
              return true;
            },
            child: _items.length == 0 && _researchController.text.isNotEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return FlippedImage(
                          opacity: widget.visible ? 1.0 : 0.0,
                          image: _items[index]);
                    },
                  ),
          ),
        ),
        Container(
          height: _isLoading ? 50.0 : 0,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
