import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class RecursoFormView extends StatefulWidget {
  const RecursoFormView(
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
  State<RecursoFormView> createState() => _RecursoFormViewState();
}

class _RecursoFormViewState extends State<RecursoFormView> {
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

  List<String> activities = [];

  List<String> searchResults = [];

  void search(String query) {
    setState(() {
      searchResults = List.generate(5, (index) => 'Result $index for "$query"');
    });
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
        title: Text("${widget.id == null ? "Nuevo" : "Editar"} Recurso"),
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
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: razaControler,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Departamento',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: ubicacionControler,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.my_location),
                              labelText: 'Provincia',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: priceControler,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.money_off),
                              labelText: 'Distrito',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: ageControler,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.location_on),
                              labelText: 'Ubicacion',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: priceControler,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Latitud',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: ageControler,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Longitud',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: estadoControler,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Estado',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: priceControler,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Categoria',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: TextField(
                            controller: ageControler,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Tipo de Categoria',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      controller: locationControler,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Sub Tipo de Categoria',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      controller: locationControler,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Estado',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      controller: detailsControler,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Particularidades',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          onChanged: search,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Actividades',
                          ),
                        ),
                        Visibility(
                          visible: searchResults.isNotEmpty,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: searchResults.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(searchResults[index]),
                                      onTap: () {
                                        setState(() {
                                          activities.add(searchResults[index]);
                                          searchResults.clear();
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: activities.map((activity) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  Text(activity),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        activities.remove(activity);
                                      });
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
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
