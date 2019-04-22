import 'package:CoopeticoTaxiApp/models/place_res.dart';
import 'package:CoopeticoTaxiApp/screens/ride_picker_screen.dart';
import 'package:flutter/material.dart';

/// Widget para la elección del lugar de origen y destino.
///
/// Autor: Paulo Barrantes
class RidePicker extends StatefulWidget {
  final Function(PlaceItemRes, bool) onSelected;
  final Function(bool) clear;

  RidePicker(this.onSelected, this.clear);

  @override
  _RidePickerState createState() => _RidePickerState();
}

class _RidePickerState extends State<RidePicker> {
  PlaceItemRes fromAddress;
  PlaceItemRes toAddress;
  var fromAddressKey = new Key('fromAddress');
  var toAddressKey = new Key('toAddress');

  @override
  Widget build(BuildContext context) {
    print(fromAddress);
    print(toAddress);

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color(0x88999999),
              offset: Offset(0, 5),
              blurRadius: 5.0,
            ),
          ]),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 50,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RidePickerScreen(
                        fromAddress == null ? "" : fromAddress.name,
                            (place, isFrom) {
                          widget.onSelected(place, isFrom);
                          fromAddress = place;
                          setState(() {});
                        }, true)));
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Center(
                        child: Icon(Icons.person_pin_circle),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      width: 40,
                      height: 50,
                      child: IconButton(icon: Icon(Icons.clear), onPressed: () {
                        print('gg');
                        widget.clear(true);
                        setState(() {
                          fromAddress = null;
                        });

                        
                      })
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 50),
                      child: Text(
                        fromAddress == null ? "¿De dónde salimos?" : fromAddress.name,
                        key: fromAddressKey,
                        overflow: TextOverflow.ellipsis,
                        style:
                        TextStyle(fontSize: 16, color: Color(0xff323643)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        RidePickerScreen(toAddress == null ? "" : toAddress.name,
                                (place, isFrom) {
                              widget.onSelected(place, isFrom);
                              toAddress = place;
                              setState(() {});
                            }, false)));
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Center(
                        child: Icon(Icons.place),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      width: 40,
                      height: 50,
                      child: IconButton(icon: Icon(Icons.clear), onPressed: () {
                        widget.clear(false);
                        setState(() {
                          toAddress = null;
                        });

                      })
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 50),
                      child: Text(
                        toAddress == null ? "¿A dónde vamos?" : toAddress.name,
                        key: toAddressKey,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16, color: Color(0xff323643)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}