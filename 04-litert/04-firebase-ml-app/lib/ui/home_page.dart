import 'package:flutter/material.dart';
import 'package:house_price_predictor_app/controller/house_detail_controller.dart';
import 'package:house_price_predictor_app/controller/lite_rt_controller.dart';
import 'package:house_price_predictor_app/model/house_detail.dart';
import 'package:house_price_predictor_app/service/firebase_ml_service.dart';
import 'package:house_price_predictor_app/service/lite_rt_service.dart';
import 'package:house_price_predictor_app/widget/form_field_counter.dart';
import 'package:house_price_predictor_app/widget/form_field_free_number.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => BedroomsController()),
              ChangeNotifierProvider(
                create: (context) => BathroomsController(),
              ),
              ChangeNotifierProvider(create: (context) => FloorsController()),
              // todo-06: add and inject FirebaseMlService to LiteRtService
              Provider(
                create: (context) => FirebaseMlService(),
              ),
              Provider(
                create: (context) => LiteRtService(
                  context.read(),
                )..initModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => LiteRtController(context.read()),
              ),
            ],
            child: _HomeBody(),
          ),
        ),
      ),
    );
  }
}

class _HomeBody extends StatefulWidget {
  const _HomeBody();

  @override
  State<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  late final sqftController = TextEditingController();
  late final liteRtController = context.read<LiteRtController>();

  @override
  void dispose() {
    sqftController.dispose();
    liteRtController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        Text(
          'House Price Predictor',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 8),
        FormFieldCounter(
          titleField: "Floors",
          number: context.select<FloorsController, double>(
            (provider) => provider.value,
          ),
          onIncrement: () => context.read<FloorsController>().increment(),
          onDecrement: () => context.read<FloorsController>().decrement(),
        ),
        FormFieldCounter(
          titleField: "Bedrooms",
          number: context.select<BedroomsController, double>(
            (provider) => provider.value,
          ),
          onIncrement: () => context.read<BedroomsController>().increment(),
          onDecrement: () => context.read<BedroomsController>().decrement(),
        ),
        FormFieldCounter(
          titleField: "Bathrooms",
          number: context.select<BathroomsController, double>(
            (provider) => provider.value,
          ),
          onIncrement: () => context.read<BathroomsController>().increment(),
          onDecrement: () => context.read<BathroomsController>().decrement(),
        ),
        FormFieldFreeNumber(
          titleField: "Square Feet Lot",
          controller: sqftController,
        ),
        SizedBox(height: 8),
        FilledButton(
          onPressed: () {
            final houseDetail = HouseDetail(
              floors: context.read<FloorsController>().value,
              bedrooms: context.read<BedroomsController>().value,
              bathrooms: context.read<BathroomsController>().value,
              sqftLot: double.tryParse(sqftController.text) ?? 0,
            );

            liteRtController.runInference(houseDetail);
          },
          child: Text("Prediksi Harga Rumah"),
        ),
        SizedBox(height: 8),
        Consumer<LiteRtController>(
          builder: (_, value, __) {
            final price = NumberFormat().format(value.number);
            return Text(
              "\$$price",
              style: Theme.of(context).textTheme.displaySmall,
            );
          },
        ),
      ],
    );
  }
}
