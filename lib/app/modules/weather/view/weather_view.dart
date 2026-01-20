import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_man/app/modules/weather/controller/weather_controller.dart';
import 'package:vehicle_man/widgets/common/custom_text_field.dart';

class WeatherView extends GetView<WeatherController> {
  WeatherView({super.key});

  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // controller.loadWeather('gandhinagar');

    return Scaffold(
      appBar: AppBar(title: const Text('Weather')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                hintText: "Enter city",
                controller: cityController,
                onChanged: controller.onCityChanged,
              ),
            ),
            Obx(() {
              if (controller.citySuggestions.isEmpty) {
                return const SizedBox();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.citySuggestions.length,
                itemBuilder: (context, index) {
                  final city = controller.citySuggestions[index];
                  return ListTile(
                    title: Text('${city.name},${city.region},${city.country}'),
                    onTap: () {
                      cityController.text = city.name;
                      controller.selectCity(city.name);
                    },
                  );
                },
              );
            }),

            Obx(() {
              if (controller.loading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.error.isNotEmpty) {
                return Center(child: Text(controller.error.value));
              }

              final data = controller.weather.value;
              if (data == null) {
                return const Center(child: Text('No Data'));
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: Image.network('https:${data.icon}'),
                    title: Text(
                      data.city,
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      '${data.temp} °C',
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: Text(
                      data.condition,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
