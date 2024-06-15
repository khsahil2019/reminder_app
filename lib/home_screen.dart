import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'component_form.dart';
import 'form_data.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formData = Provider.of<FormData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Web Form'),
        actions: [
          ElevatedButton(
            onPressed: () {
              formData.submitForm();
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Form Data'),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: formData.components.map((component) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: ListTile(
                                title: Text(
                                    'Label: ${component.labelController.text}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (component
                                        .infoController.text.isNotEmpty)
                                      Text(
                                          'Info-Text: ${component.infoController.text}'),
                                    if (component.isRequired)
                                      const Text('Settings: Required'),
                                    if (component.isReadonly)
                                      const Text('Settings: Readonly'),
                                    if (component.isHidden)
                                      const Text('Settings: Hidden'),
                                  ],
                                ),
                              ),
                            ));
                      }).toList(),
                    ),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue, // Text color
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10), // Button padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Button border radius
              ),
            ),
            child: const Text('Submit'), // Button text
          ),
        ],
      ),
      body: ComponentForm(),
    );
  }
}
