import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sinventors/app_color.dart';
import 'package:sinventors/widget_background.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends StatefulWidget {
  final bool isEdit;
  final String documentId;
  final String name;
  final String jenis;
  final String ruangan;
  final String sn;
  final String date;

  CreateTaskScreen({
    @required this.isEdit,
    this.documentId = '',
    this.name = '',
    this.jenis = '',
    this.ruangan = '',
    this.sn = '',
    this.date = '',
  });

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final Firestore firestore = Firestore.instance;
  final AppColor appColor = AppColor();
  final TextEditingController controllerName = TextEditingController();
  TextEditingController controllerJenis = TextEditingController();
  final TextEditingController controllerRuangan = TextEditingController();
  final TextEditingController controllerSN = TextEditingController();
  final TextEditingController controllerDate = TextEditingController();

  double widthScreen;
  double heightScreen;
  DateTime date = DateTime.now().add(Duration(days: 1));
  bool isLoading = false;

  List _jenisBarang = [
    "Komputer",
    "Laptop",
    "Printer",
    "Scanner"
  ];

  @override
  void initState() {
    if (widget.isEdit) {
      date = DateFormat('dd MMMM yyyy').parse(widget.date);
      controllerName.text = widget.name;
      controllerJenis.text = widget.jenis;
      controllerRuangan.text = widget.ruangan;
      controllerSN.text = widget.sn;
      controllerDate.text = widget.date;
    } else {
      controllerDate.text = DateFormat('dd MMMM yyyy').format(date);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    widthScreen = mediaQueryData.size.width;
    heightScreen = mediaQueryData.size.height;

    return Scaffold(
      key: scaffoldState,
      backgroundColor: appColor.colorPrimary,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WidgetBackground(),
            Container(
              width: widthScreen,
              height: heightScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildWidgetFormPrimary(),
                  SizedBox(height: 16.0),
                  _buildWidgetFormSecondary(),
                  isLoading
                      ? Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  appColor.colorTertiary),
                            ),
                          ),
                        )
                      : _buildWidgetButtonCreateTask(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetFormPrimary() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            widget.isEdit ? 'Edit\nTask' : 'Tambah\nBarang',
            style: Theme.of(context).textTheme.display1.merge(
                  TextStyle(color: Colors.grey[800]),
                ),
          ),
          SizedBox(height: 18.0),
          TextField(
            controller: controllerName,
            decoration: InputDecoration(
              labelText: 'Nama Barang :',
            ),
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetFormSecondary() {

        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: <Widget>[
               
            TextField(
              controller: controllerJenis,
              decoration: InputDecoration(
                labelText: 'Jenis :',
                suffixIcon: PopupMenuButton<String>(
                  icon: const Icon(Icons.arrow_drop_down),
                  onSelected: (value) {
                    controllerJenis.text = value;
                  },
                  itemBuilder: (BuildContext context) {
                    return _jenisBarang
                      .map<PopupMenuItem<String>>((value) {
                        return new PopupMenuItem(
                          child: new Text(value), value: value);
                      }).toList();
                  },
                  )
              ),
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 18.0),
            TextField(
              controller: controllerDate,
              decoration: InputDecoration(
                labelText: 'Date  :',
                suffixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.today),
                  ],
                ),
              ),
              style: TextStyle(fontSize: 18.0),
              readOnly: true,
              onTap: () async {
                DateTime today = DateTime.now();
                DateTime datePicker = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: today,
                  lastDate: DateTime(2021),
                );
                if (datePicker != null) {
                  date = datePicker;
                  controllerDate.text = DateFormat('dd MMMM yyyy').format(date);
                }
              },
            ),
            SizedBox(height: 18.0),
            TextField(
              controller: controllerSN,
              decoration: InputDecoration(
                labelText: 'Serial Number :',
              ),
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 18.0),
            TextField(
              controller: controllerRuangan,
              decoration: InputDecoration(
                labelText: 'Ruangan :',
              ),
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetButtonCreateTask() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: RaisedButton(
        color: appColor.colorTertiary,
        child: Text(widget.isEdit ? 'UPDATE THINGS' : 'INSERT'),
        textColor: Colors.brown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        onPressed: () async {
          String name = controllerName.text;
          String jenis = controllerJenis.text;
          String ruangan = controllerRuangan.text;
          String sn = controllerSN.text;
          String date = controllerDate.text;
          if (name.isEmpty) {
            _showSnackBarMessage('Name is required');
            return;
          } else if (jenis.isEmpty) {
            _showSnackBarMessage('Jenis is required');
            return;
          } else if (sn.isEmpty) {
            _showSnackBarMessage('Serial Number is required');
          }
          setState(() => isLoading = true);
          if (widget.isEdit) {
            DocumentReference documentTask =
                firestore.document('barang/${widget.documentId}');
            firestore.runTransaction((transaction) async {
              DocumentSnapshot task = await transaction.get(documentTask);
              if (task.exists) {
                await transaction.update(
                  documentTask,
                  <String, dynamic>{
                    'nama': name,
                    'jenis': jenis,
                    'ruangan': ruangan,
                    'sn': sn,
                    'date': date,
                  },
                );
                Navigator.pop(context, true);
              }
            });
          } else {
            CollectionReference tasks = firestore.collection('barang');
            DocumentReference result = await tasks.add(<String, dynamic>{
              'name': name,
              'jenis': jenis,
              'ruangan': ruangan,
              'sn': sn,
              'date': date,
            });
            if (result.documentID != null) {
              Navigator.pop(context, true);
            }
          }
        },
      ),
    );
  }

  void _showSnackBarMessage(String message) {
    scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
