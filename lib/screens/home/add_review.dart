import 'package:flutter/material.dart';

import '../../repositories/toilet_repository.dart';

class AddReviwe extends StatefulWidget {
  static const routeName = 'add_review';

  final int toiletId;

  const AddReviwe({super.key, required this.toiletId});

  @override
  State<AddReviwe> createState() => _AddReviweState();
}

class _AddReviweState extends State<AddReviwe> {
  var _isLoading = false;
  String? _errorMessage;

  final _toiletNameController = TextEditingController();
  final _distanceController = TextEditingController();

  validateForm() {
    return _toiletNameController.text.isNotEmpty &&
        _distanceController.text.isNotEmpty;
  }

  saveToilet() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));

    try {
      var review = _toiletNameController.text;
      var rating = int.parse(_distanceController.text);

      await ToiletRepository().addReview(review: review, rating: rating, toiletId: widget.toiletId);

      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    buildLoadingOverlay() => Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(child: CircularProgressIndicator()));

    handleClickSave() {
      if (validateForm()) {
        saveToilet();
      }
    }

    buildForm() => SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      controller: _toiletNameController,
                      decoration: InputDecoration(
                          hintText: 'review',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.greenAccent,
                              )))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      controller: _distanceController,
                      decoration: InputDecoration(
                          hintText: 'rating',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.greenAccent,
                              )))),
                ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: handleClickSave,
                      child: Text('SAVE'),
                    ))
              ],
            )));

    return Scaffold(
        appBar: AppBar(title: Text('ADD REVIEW')),
        body: Stack(
          children: [
            buildForm(),
            if (_isLoading) buildLoadingOverlay(),
          ],
        ));
  }
}
