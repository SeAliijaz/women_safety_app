import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_app/Utils/constants.dart';

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
          backgroundColor: primaryColor,
          title: const Text("Give Us Rating"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ///Rating Button
              MaterialButton(
                height: 60,
                minWidth: MediaQuery.of(context).size.width / 2,
                color: primaryColor,
                onPressed: () {
                  ///Show Dialog Fields
                  showDialogMethod(context);
                },
                child: const Text(
                  "Press Here to give Your Rating",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
                    if (!snapshot.hasData) {
                      return Center(child: customProgressIndicator(context));
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shadowColor: Colors.grey[500],
                          elevation: 5,
                          child: ListTile(
                            textColor: Colors.black,
                            title: Text(
                                "Location: ${snapshot.data!.docs[index]["title"]}"),
                            subtitle: Text(
                                "Review: ${snapshot.data!.docs[index]['detail']}"),
                            trailing: const Icon(Icons.reviews_sharp),
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
            title: const Text("Give Us Rating"),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      controller: locationController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Field Should not be empty";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
                        hintText: "Enter Location",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      controller: ratingController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Field Should not be empty";
                        } else if (v.length < 0 && v.length > 10) {
                          return "Must be between 1 & 10";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.reviews),
                        hintText: "Enter Rating",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              MaterialButton(
                color: primaryColor,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveRatingReview();
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
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
