import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class RutaFormView extends StatefulWidget {
  const RutaFormView(
      {super.key,
      this.id,
      this.price,
      this.name,
      this.image,
      this.age,
      this.details,
      this.estado,
      this.location,
      this.raza,
      this.sexo,
      this.ubicacion});
  final String? id;
  final String? name;
  final List<dynamic>? image;
  final int? price;
  final String? age;
  final String? details;
  final String? estado;
  final String? location;
  final String? raza;
  final String? sexo;
  final String? ubicacion;

  @override
  State<RutaFormView> createState() => _RutaFormViewState();
}

class _RutaFormViewState extends State<RutaFormView> {
  TextEditingController nameControler = TextEditingController();
  TextEditingController priceControler = TextEditingController();
  TextEditingController ageControler = TextEditingController();
  TextEditingController detailsControler = TextEditingController();
  TextEditingController estadoControler = TextEditingController();
  TextEditingController locationControler = TextEditingController();
  TextEditingController razaControler = TextEditingController();
  String? sexoControler;
  TextEditingController ubicacionControler = TextEditingController();
  List<Map<String, dynamic>> images = [];

  String dropdownvalue = 'Hembra';

  final List<String> genderItems = [
    'Macho',
    'Hembra',
  ];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();

  List<String> searchResults = []; // To store search results

  void search(String query) {
    // Perform your search logic here
    // For example, you can query a database or an API
    // and update the searchResults list accordingly.
    // For now, let's use a dummy list.
    setState(() {
      searchResults = List.generate(5, (index) => 'Result $index for "$query"');
    });
  }

  Widget buildSearch() {
    return Column(
      children: [
        TextField(
          onChanged: search,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Buscar Recursos',
          ),
        ),
        Visibility(
          visible: searchResults.isNotEmpty,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(searchResults[index]),
                onTap: () {
                  setState(() {
                    images.add({
                      "uuid": const Uuid().v4(),
                      "value": searchResults[index]
                    });
                    searchResults.clear();
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    nameControler.text = widget.name ?? "";
    priceControler.text = "${widget.price ?? ""}";
    ageControler.text = widget.age ?? "";
    detailsControler.text = widget.details ?? "";
    estadoControler.text = widget.estado ?? "";
    locationControler.text = widget.location ?? "";
    razaControler.text = widget.raza ?? "";
    sexoControler = widget.sexo;
    ubicacionControler.text = widget.ubicacion ?? "";
    var temp = widget.image ?? [];

    images = temp.map((e) {
      return <String, dynamic>{"uuid": const Uuid().v4(), "value": e};
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.id == null ? "Nueva" : "Editar"} Ruta"),
        actions: [
          IconButton(
              onPressed: () {
                CollectionReference dogs =
                    FirebaseFirestore.instance.collection('dogs');
                Map<String, dynamic> data = {
                  'name': nameControler.text,
                  'image': images.map((e) => e['value']).toList(),
                  'raza': razaControler.text,
                  'ubicacion': ubicacionControler.text,
                  'price': int.parse(priceControler.text),
                  'age': ageControler.text,
                  'estado': estadoControler.text,
                  'sexo': sexoControler,
                  'location': locationControler.text,
                  'details': detailsControler.text,
                };
                if (widget.id == null) {
                  dogs.add(data);
                } else {
                  dogs.doc(widget.id).update(data);
                }
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      controller: nameControler,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nombre',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      controller: nameControler,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Descripcion',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: buildSearch(),
                  ),
                  ListView.builder(
                      itemCount: images.length,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      shrinkWrap: true,
                      addAutomaticKeepAlives: false,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        var image = images[index];
                        Key key = Key(image['uuid']);
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 5,
                                child: TextFormField(
                                  initialValue: image['value'],
                                  key: key,
                                  onChanged: (value) {
                                    setState(() {
                                      images[index]['value'] = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: 'Imagen ${index + 1}',
                                  ),
                                ),
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Center(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            images.removeAt(index);
                                          });
                                        },
                                        icon: const Icon(Icons.delete)),
                                  ))
                            ],
                          ),
                        );
                      }),
                  Center(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          images.add({"uuid": const Uuid().v4(), "value": ""});
                        });
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Flexible(
                      flex: 1,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        isExpanded: true,
                        value: sexoControler,
                        hint: const Text(
                          'Seleccione un genero',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 30,
                        itemHeight: 50,
                        borderRadius: BorderRadius.circular(20),
                        items: genderItems
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select gender.';
                          }
                        },
                        onChanged: (String? newValue) {
                          setState(() {
                            sexoControler = newValue;
                          });
                        },
                        onSaved: (value) {
                          sexoControler = value.toString();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      controller: locationControler,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                        labelText: 'Location',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
