import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:women_safety_app/Utils/constants.dart';
import 'package:women_safety_app/Widgets/Custom-Widgets/progress_indicator.dart';

class RatingAppScreen extends StatefulWidget {
  const RatingAppScreen({Key? key}) : super(key: key);

  @override
  State<RatingAppScreen> createState() => _RatingAppScreenState();
}

class _RatingAppScreenState extends State<RatingAppScreen> {
  TextEditingController locationController = TextEditingController();
  TextEditingController ratingController = TextEditingController();

  ///Dispose
  @override
  void dispose() {
    locationController.clear();
    locationController.dispose();
    ratingController.clear();
    ratingController.dispose();
    super.dispose();
  }

  bool isSaving = false;
  final _formKey = GlobalKey<FormState>();
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: const Text("Give Us Rating"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              ///Rating Button
              MaterialButton(
                elevation: 5,
                height: 60,
                minWidth: MediaQuerySize(context).width / 2,
                color: AppColors.primaryColor,
                onPressed: () {
                  ///Show Dialog Fields
                  showDialogMethod(context);
                },
                child: const Text(
                  "Press Here to give Your Rating",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),

              ///SizedBox
              const SizedBox(height: 20),

              ///Here We're showing the reviews
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("reviews")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.connectionState == ConnectionState.none ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CustomProgessIndicator.indicator(context));
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                          child: Text(
                        "Please Give us Rating!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ));
                    }
                    if (!snapshot.hasData) {
                      return Center(
                          child: CustomProgressIndicator(
                              title: "Loading Data..."));
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shadowColor: Colors.grey[500],
                          elevation: 5,
                          child: ListTile(
                            textColor: Colors.black,
                            leading: Icon(Icons.feedback_outlined),
                            title: Text(
                                "Location: ${snapshot.data!.docs[index]["title"]}"),
                            subtitle: Text(
                                "Rating: ${snapshot.data!.docs[index]['detail']}"),
                            trailing: const Icon(FontAwesomeIcons.star),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Dialog To show TextFields
  ///For Review
  Future<dynamic> showDialogMethod(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Give Us Rating*",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      controller: locationController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field Should not be empty";
                        } else if (value.length <= 3) {
                          return "Length should be more than 3";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
                        labelText: "Enter Location",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      controller: ratingController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp("^(1[0-0]|[1-9])\$")),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the Overall Rating';
                        } else if (int.parse(value) < 1 ||
                            int.parse(value) > 10) {
                          return 'The rating must be between 1 and 10';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.always,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.reviews),
                        labelText: "Enter Rating",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 50,
                minWidth: MediaQuerySize(context).width,
                color: AppColors.primaryColor,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveRatingReview();
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          );
        });
  }

  saveRatingReview() async {
    setState(() {
      isSaving = true;
    });
    await FirebaseFirestore.instance.collection('reviews').add({
      "title": locationController.text.trim(),
      "detail": ratingController.text.trim(),
    }).whenComplete(() {
      setState(() {
        isSaving = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Succesfully Added")));
      });
    });
  }

  clearTextField() {
    setState(() {
      locationController.clear();
      ratingController.clear();
    });
  }
}
