import 'package:downloadfile/MVVM/View%20models/society_model_view.dart';
import 'package:downloadfile/Widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/user_data_provider.dart';
import 'custom_loader.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({Key? key}) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String selectedCity = "Select";

  @override
  Widget build(BuildContext context) {
    SocietyModelView societyModelView = context.watch<SocietyModelView>();
    return dropDownView(societyModelView);
  }

  Widget dropDownView(SocietyModelView societyModelView) {
    if (societyModelView.loading) {
      return const CustomLoader();
    }
    if (societyModelView.modelError != null) {
      return InkWell(
        onTap: () {
          societyModelView.setModelError(null);
          context.read<SocietyModelView>().getSocieties();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(Icons.rotate_90_degrees_ccw),
            CustomText(text: "Retry")
          ],
        ),
      );
    }
    return DropdownButton(
      hint: CustomText(text: selectedCity),
      items: societyModelView.societyModel!.data!.societies!
          .map((value) => DropdownMenuItem(
                value: "${value.title}@${value.id}",
                child: CustomText(
                  text: value.title.toString(),
                  textAlign: TextAlign.center,
                ),
              ))
          .toList(),
      onChanged: (dynamic value) {
        setState(() {
          selectedCity =
              value.toString().substring(0, value.toString().indexOf('@'));
          var id =
              value.toString().substring(value.toString().indexOf("@") + 1);

          Provider.of<SelectedSoceityProvider>(context, listen: false)
              .updateSelectedSociety(value, id);
        });
      },
      // ...
    );
  }
}
