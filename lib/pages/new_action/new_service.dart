import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profinder/models/post/picture.dart';
import 'package:profinder/models/post/price_creation_request.dart';
import 'package:profinder/models/post/service_creation_request.dart';
import 'package:profinder/models/subcategory/subcategory.dart';
import 'package:profinder/services/category/category.dart';
import 'package:profinder/services/post/professional.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/inputs/dropdown.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';
import 'package:profinder/widgets/inputs/text_area.dart';
import 'package:profinder/widgets/progress/loader.dart';

class NewService extends StatefulWidget {
  const NewService({Key? key}) : super(key: key);

  @override
  State<NewService> createState() => _NewServiceState();
}

class _NewServiceState extends State<NewService> {
  late Future<List<SubCategoryEntity>> _subcategoriesFuture;
  final CategoryService category = CategoryService();
  final ProfessionalService service = ProfessionalService();

  String? _selectedCategoryId;
  List<PriceCreationRequest> prices = [];
  List<Picture> pictures = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceDescriptionController =
      TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  ServiceCreationRequest buildRequest() {
    return ServiceCreationRequest(
      title: _nameController.text,
      description: _descriptionController.text,
      subCategoryId: int.parse(_selectedCategoryId ?? '0'),
      pictures: pictures,
      prices: prices,
    );
  }

  void addPrice() {
    PriceCreationRequest price = PriceCreationRequest(
      value: int.parse(_valueController.text),
      description: _priceDescriptionController.text,
      rate: _rateController.text,
    );

    setState(() {
      prices.add(price);
    });
  }

  void addPicture(String link) {
    Picture picture = Picture(link: link);

    setState(() {
      pictures.add(picture);
    });
  }

  void deletePrice(int index) {
    setState(() {
      prices.removeAt(index);
    });
  }

  void _uploadPicture() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);

      Reference storageReference = FirebaseStorage.instance.ref().child(
          'profile_pictures/${DateTime.now().millisecondsSinceEpoch}.jpg');

      UploadTask uploadTask = storageReference.putFile(imageFile);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title:
                Text("Chargement d'image...", style: TextStyle(fontSize: 15)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                StreamBuilder<TaskSnapshot>(
                  stream: uploadTask.snapshotEvents,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      double progress = snapshot.data!.bytesTransferred /
                          snapshot.data!.totalBytes;
                      return LinearProgressIndicator(
                        value: progress,
                        color: AppTheme.primaryColor,
                      );
                    } else {
                      return SizedBox(); // Placeholder
                    }
                  },
                ),
              ],
            ),
          );
        },
      );

      try {
        TaskSnapshot snapshot = await uploadTask;
        String downloadURL = await snapshot.ref.getDownloadURL();

        addPicture(downloadURL);

        print('Profile picture URL updated: $downloadURL');

        Navigator.of(context).pop(); // Dismiss dialog
      } catch (error) {
        print('Error uploading image: $error');
        Navigator.of(context).pop(); // Dismiss dialog
        // Optionally show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $error')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    _subcategoriesFuture = category.fetchSubcategories(1);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Créer un service",
                    style: AppTheme.headingTextStyle,
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            RoundedTextField(
              controller: _nameController,
              hintText: "Nom",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez entrer un nom";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            RoundedTextArea(
              controller: _descriptionController,
              hintText: "Description",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez entrer une description";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            FutureBuilder<List<SubCategoryEntity>>(
              future: _subcategoriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return AppLoading();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Check if the fetched list is not null
                  if (snapshot.data != null) {
                    print(snapshot.data);
                    return RoundedDropdownButton<String>(
                      value: _selectedCategoryId,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategoryId = newValue!;
                        });
                      },
                      hintText: 'Choisir une catégorie',
                      items: snapshot.data!.map<DropdownMenuItem<String>>(
                        (SubCategoryEntity subcategory) {
                          return DropdownMenuItem<String>(
                            value: subcategory.subCategoryId.toString(),
                            child: Text(subcategory.subCategoryName),
                          );
                        },
                      ).toList(),
                    );
                  } else {
                    return Text('No subcategories available');
                  }
                }
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  child: RoundedTextField(
                    controller: _priceDescriptionController,
                    hintText: "Tache",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer une tâche";
                      }
                      return null;
                    },
                  ),
                ),
                Flexible(
                  child: RoundedTextField(
                    controller: _valueController,
                    hintText: "Prix",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer un prix";
                      }
                      return null;
                    },
                  ),
                ),
                Text('/'),
                Flexible(
                  child: RoundedTextField(
                    controller: _rateController,
                    hintText: "",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer une valeur de taux";
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(FluentIcons.add_12_filled),
                  color: AppTheme.primaryColor,
                  onPressed: addPrice,
                ),
              ],
            ),
            SizedBox(height: 10),
            if (!prices.isEmpty)
              Container(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: prices.length,
                  itemBuilder: (context, index) {
                    final price = prices[index];
                    return Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15),
                          margin: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey[200],
                          ),
                          child: Row(
                            children: [
                              Text(price.description),
                              SizedBox(width: 10),
                              Text('Prix: ${price.value}DA / ${price.rate}'),
                              SizedBox(width: 10),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => deletePrice(index),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            Container(
              padding: EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Photos",
                  )
                ],
              ),
            ),
            Container(
              child: FilledAppButton(
                icon: FluentIcons.add_12_filled,
                text: "Ajouter une photo",
                onPressed: () async {
                  _uploadPicture();
                },
              ),
              margin: EdgeInsets.all(18),
            ),
            if (!pictures.isEmpty)
              Container(
                margin: EdgeInsets.only(left: 18),
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pictures.length,
                  itemBuilder: (context, index) {
                    final picture = pictures[index];
                    return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          width: 150,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              picture.link,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          left: 4,
                          child: GestureDetector(
                            onTap: () {
                              // Handle deletion of the picture here
                              setState(() {
                                pictures.removeAt(index);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: FilledAppButton(
                icon: FluentIcons.add_12_filled,
                text: "Publier",
                onPressed: () async {
                  if (_nameController.text.isEmpty ||
                      _descriptionController.text.isEmpty ||
                      _selectedCategoryId == null ||
                      prices.isEmpty ||
                      pictures.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Veuillez remplir tous les champs',
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    ServiceCreationRequest newService = buildRequest();
                    try {
                      print(newService.toJson());
                      await service.post(newService);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Service publié avec succès!',
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      ); // Assuming postService is an instance of your PostService class
                      service.fetch(); // Refresh data // Trigger data refresh
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Veuillez vérifier vos coordonnées',
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
