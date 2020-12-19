
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:global_gym/classes/media_query_helper.dart';

class CustomDropDownList extends StatefulWidget
{
  final String hint;
  final String initialValue;
  final double height;
  final double width;
  final List<String> itemsList;
  final List<int> itemsListIndex;
  final Function(String, int) onChanged;
  CustomDropDownList({this.hint,this.width, this.height, this.initialValue, this.itemsList, this.itemsListIndex, this.onChanged});

  createState() => _CustomDropDownListWithTopLabelState();
}

class _CustomDropDownListWithTopLabelState extends State<CustomDropDownList> {


  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selected;

  @override
  void initState() {
    if(widget.initialValue != null) _selected = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _dropDownMenuItems = buildAndGetDropDownMenuItems(context, widget.itemsList);

    return Container(
      width: widget.width,
      height: widget.height ?? getPercentsOfHeight(context, 10),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      margin: EdgeInsets.all(0),
      child: Container(
        height: getPercentsOfHeight(context, 5),
        padding: const EdgeInsets.only(right: 5.0),
        decoration: BoxDecoration(
//            color: Colors.green,//Color(0xFFFBFBFB),
          borderRadius: BorderRadius.circular(0),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey,size: 20,),
            isExpanded: true,
            hint: Text(widget.hint!=null ? widget.hint : "Please Select", style: TextStyle(
              color: Colors.grey,
              fontFamily: 'CircularStd',
              fontSize: getTextScaleFactor(context) * 11.0,
            ),),
            value: widget.itemsList.contains(_selected) ? _selected : null,
            items: _dropDownMenuItems,
            onChanged: (v){
              changedDropDownItem(v);
              var index;

              if (widget.itemsListIndex != null)
                index = widget.itemsListIndex[widget.itemsList.indexOf(v)];
              else
                index = widget.itemsList.indexOf(v);

              return widget.onChanged(v, index);
            },
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(BuildContext context, List<String> itemsList) {
    List<DropdownMenuItem<String>> items = List();

    for (String item in itemsList) {
      items.add(DropdownMenuItem(value: item, child: Center(child: Text(item, style: TextStyle(
        color: Colors.black,
        fontFamily: 'CircularStd',
        fontSize:
        getTextScaleFactor(context) * 13.0,
      ),))));
    }
    return items;
  }

  void changedDropDownItem(String selected) {
    setState(() {
      _selected = selected;
    });
  }
}
