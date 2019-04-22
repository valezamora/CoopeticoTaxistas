import 'package:CoopeticoTaxiApp/blocs/place_bloc.dart';
import 'package:CoopeticoTaxiApp/models/place_res.dart';
import 'package:flutter/material.dart';


/// Widget que un text field donde se coloca una palabra clave para buscar un lugar
/// de destino o de origen.
///
/// Autor: Paulo Barrantes
class RidePickerScreen extends StatefulWidget {
  final String selectedAddress;
  final Function(PlaceItemRes, bool) onSelected;
  final bool _isFromAddress;
  RidePickerScreen(this.selectedAddress, this.onSelected, this._isFromAddress);

  @override
  _RidePickerScreenState createState() => _RidePickerScreenState();
}

class _RidePickerScreenState extends State<RidePickerScreen> {
  var _addressController;
  var placeBloc = PlaceBloc();

  @override
  void initState() {
    _addressController = TextEditingController(text: widget.selectedAddress);
    super.initState();
  }

  @override
  void dispose() {
    placeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(0xfff8f8f8),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Icon(Icons.place),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        width: 40,
                        height: 60,
                        child: Center(
                            child: IconButton(icon: Icon(Icons.clear), onPressed: (){
                              _addressController.text = "";
                              placeBloc.searchPlace("");
                            })
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 40, right: 50),
                        child: TextField(
                          controller: _addressController,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (str) {
                            placeBloc.searchPlace(str);
                          },
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
              padding: EdgeInsets.only(top: 20),
              child: StreamBuilder(
                  stream: placeBloc.placeStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data.toString());
                      if (snapshot.data == "start") {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      print(snapshot.data.toString());
                      List<PlaceItemRes> places = snapshot.data;
                      return ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: places.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(places.elementAt(index).name),
                              subtitle: Text(places.elementAt(index).address),
                              onTap: () {
                                print("on tap");
                                Navigator.of(context).pop();
                                widget.onSelected(places.elementAt(index),
                                    widget._isFromAddress);
                              },
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            height: 1,
                            color: Color(0xfff5f5f5),
                          ),
                          );
                    } else {
                      return Container();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}