import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hirehustle/Model/Registration/hr.dart';
import 'package:hirehustle/ViewModel/APIs/DioHelper.dart';
import 'package:hirehustle/ViewModel/StateManagement/Login/login_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitial());

  GlobalKey<FormState> formKey = new GlobalKey();

  List fieldsData = [
    {
      'labelText': 'First Name',
      'controller': new TextEditingController(),
      'onChanged': () {},
    },
    {
      'labelText': 'Last Name',
      'controller': new TextEditingController(),
      'onChanged': () {},
    },
    {
      'labelText': 'Username',
      'controller': new TextEditingController(),
      'onChanged': () {},
    },
    {
      'labelText': 'Email',
      'controller': new TextEditingController(),
      'onChanged': () {},
    },
    {
      'labelText': 'Password',
      'controller': new TextEditingController(),
      'onChanged': () {},
    },
    {
      'labelText': 'Mobile Number',
      'controller': new TextEditingController(),
      'onChanged': () {},
    },
    {
      'labelText': 'National Id',
      'controller': new TextEditingController(),
      'onChanged': () {},
    },
    {
      'labelText': 'Address Line',
      'controller': new TextEditingController(),
      'onChanged': () {},
    },
    {
      'labelText': 'Age',
      'controller': new TextEditingController(),
      'onChanged': () {},
    },
  ];

  bool obsecure = true;

  void triggerVisibility() {
    obsecure = !obsecure;
    emit(TriggerVisibility());
  }

  bool get obsecureValue => obsecure;


  File? imageFile;
  var imageXFile;

  Future pickImage({
    fromGallery = false,
    fromCamera = false,
  }) async {
    try {
      imageXFile = await ImagePicker().pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
      );
      if(imageXFile == null) return;
      print(imageXFile.path);
      imageFile = File(imageXFile.path);
      emit(ImageChanged());
    } on Exception catch (exception) {
      print('Failed to pick image: $exception');
    }
  }

  // Convert image to string to can store it in database.
  String convertFileToBase64EncodedString(File file){
    List<int> imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  // Convert string coming from database to its original image.
  ImageProvider convertBase64EncodedStringToImage(String image){
    List<int> imageBytes = base64Decode(image);
    Uint8List uint8list = Uint8List.fromList(imageBytes);
    ImageProvider imageProvider = MemoryImage(uint8list);
    return imageProvider;
  }

  void validateRegistration() {
    if (formKey.currentState!.validate()) {
      HR hr = new HR(
          convertFileToBase64EncodedString(imageFile!),
          fieldsData[0]['controller'].text,
          fieldsData[1]['controller'].text,
          fieldsData[2]['controller'].text,
          fieldsData[3]['controller'].text,
          fieldsData[4]['controller'].text,
          fieldsData[5]['controller'].text,
          fieldsData[6]['controller'].text,
          fieldsData[7]['controller'].text,
          int.parse(fieldsData[8]['controller'].text)
      );
      String hrJson = jsonEncode(hr.toMap());
      register(hrJson);
    }
  }

  void clearAllControllers(List data){
    imageFile = null;
    for(Map object in data){
      object['controller'].clear();
    }
  }

  void register(String jsonData) async{
    Response response = await DioHelper.postAPI(endpoint: 'hr/register', data: jsonData);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.data);
      if (jsonResponse['status'] == 'success') {
        String successMessage = jsonResponse['data'];
        clearAllControllers(fieldsData);
        emit(RegistrationSuccess(successMessage));
      }
      else if (jsonResponse['status'] == 'failed'){
        String failureMessage = jsonResponse['message'];
        emit(RegistrationFailed(failureMessage));
      }
    }
    else{
      String apiRequestErrorMessage = 'Sorry, There is a server request error.';
      emit(ApiRequestFailed(apiRequestErrorMessage));
    }
  }

}
