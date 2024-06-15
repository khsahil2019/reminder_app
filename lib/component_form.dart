import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'form_data.dart';
import 'component_widget.dart';

class ComponentForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formData = Provider.of<FormData>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Ensure the list of components is properly handled
            ...formData.components
                .map((component) => ComponentWidget(component: component))
                .toList(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: formData.addComponent,
              child: Text('ADD'),
            ),
          ],
        ),
      ),
    );
  }
}
