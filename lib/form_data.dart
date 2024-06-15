import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FormData with ChangeNotifier {
  List<ComponentData> components = [ComponentData()];

  void addComponent() {
    components.add(ComponentData());
    notifyListeners();
  }

  void removeComponent(ComponentData component) {
    if (components.length > 1) {
      components.remove(component);
      notifyListeners();
    }
  }

  void submitForm() async {
    var box = await Hive.openBox('formDataBox');
    await box.put('formData', components.map((c) => c.toMap()).toList());
    notifyListeners();
  }

  Future<void> loadForm() async {
    var box = await Hive.openBox('formDataBox');
    var data = box.get('formData');

    if (data != null) {
      components = List<Map<dynamic, dynamic>>.from(data)
          .map((map) => ComponentData.fromMap(Map<String, dynamic>.from(map)))
          .toList();
    }
    notifyListeners();
  }
}

class ComponentData extends ChangeNotifier {
  TextEditingController labelController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  bool isRequired = false;
  bool isReadonly = false;
  bool isHidden = false;

  void selectRequired() {
    isRequired = true;
    isReadonly = false;
    isHidden = false;
    notifyListeners();
  }

  void selectReadonly() {
    isRequired = false;
    isReadonly = true;
    isHidden = false;
    notifyListeners();
  }

  void selectHidden() {
    isRequired = false;
    isReadonly = false;
    isHidden = true;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'label': labelController.text,
      'info': infoController.text,
      'isRequired': isRequired,
      'isReadonly': isReadonly,
      'isHidden': isHidden,
    };
  }

  ComponentData.fromMap(Map<String, dynamic> map) {
    labelController.text = map['label'];
    infoController.text = map['info'];
    isRequired = map['isRequired'];
    isReadonly = map['isReadonly'];
    isHidden = map['isHidden'];
  }

  ComponentData();
}
