import 'package:flutter/material.dart';
import 'package:game_app/presentation/widgets/texts.dart';

class FilterChipWidget extends StatefulWidget {

  final String label;
  final List<String> genreList;
  final String slug;
  final List<String> alreadySelectedGenres;

  FilterChipWidget(this.label, this.genreList, this.slug, this.alreadySelectedGenres);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {

  var _isSelected;

  @override
  void initState() {
    _isSelected = widget.alreadySelectedGenres.contains(widget.slug);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: NormalText(text: widget.label, textColor: _isSelected ? Colors.white : Colors.black),
      onSelected: (bool){
        setState(() {
          _isSelected = bool;
          if(bool){
            setState(() {
              widget.genreList.add(widget.slug);
              print("From Genre Page: ${widget.genreList.toString()}");
            });
          }else{
            setState(() {
              widget.genreList.remove(widget.slug);
              print("From Genre Page: ${widget.genreList.toString()}");
            });
          }
        });
      },
      elevation: 5,
      labelStyle: TextStyle(color: _isSelected ? Colors.white : Colors.black, fontSize: 15, fontFamily: "Poppins" ),
      selectedColor: Colors.orange,
      selected: _isSelected,
      selectedShadowColor: Colors.orange,
      backgroundColor: Colors.white,
//                    labelPadding: EdgeInsets.all(10),
      checkmarkColor: Colors.white,

    );
  }
}