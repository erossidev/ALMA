import 'package:flutter/material.dart';

import '../../../core/ai/ai_resource.dart';
import '../../../core/ai/ai_task.dart';
import '../../../core/di/service_locator.dart';

import '../models/ai_routing_item.dart';
import '../widgets/routing_item_card.dart';


class AIRoutingPage extends StatefulWidget {
  const AIRoutingPage({
    super.key,
  });

  @override
  State<AIRoutingPage> createState() =>
      _AIRoutingPageState();
}


class _AIRoutingPageState extends State<AIRoutingPage> {

  bool _loading = true;

  List<AIResource> _resources = [];

  List<AIRoutingItem> _items = [];


  @override
  void initState() {
    super.initState();

    _load();
  }


  Future<void> _load() async {

    try {

      final service =
          ServiceLocator.backendAIService;


      final resources =
          await service.loadResources();


      final routing =
          await service.loadRouting();


      final items = AITask.values.map(
        (task) {

          final value =
              routing[task.name];


          return AIRoutingItem(
            task: task,
            resourceId:
                value ??
                (resources.isNotEmpty
                    ? resources.first.id
                    : ''),
          );
        },
      ).toList();


      setState(() {

        _resources = resources;

        _items = items;

        _loading = false;

      });


    } catch (e) {

      if (!mounted) return;


      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content:
              Text(e.toString()),
        ),
      );


      setState(() {

        _loading = false;

      });

    }
  }



  Future<void> _save() async {


    final routing =
        <String, dynamic>{};


    for (final item in _items) {

      routing[item.task.name] =
          item.resourceId;

    }


    await ServiceLocator
        .backendAIService
        .saveRouting(
          routing,
        );


    if (!mounted) return;


    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content:
            Text(
              'Routing salvato',
            ),
      ),
    );
  }



  @override
  Widget build(
    BuildContext context,
  ) {


    if (_loading) {

      return const Center(
        child:
            CircularProgressIndicator(),
      );

    }



    return Column(

      children: [


        Expanded(

          child:
              ListView.builder(

            padding:
                const EdgeInsets.all(16),


            itemCount:
                _items.length,


            itemBuilder:
                (context, index) {


              final item =
                  _items[index];


              return RoutingItemCard(

                item:
                    item,


                resources:
                    _resources,


                onChanged:
                    (resourceId) {


                  setState(() {

                    _items[index] =
                        item.copyWith(
                          resourceId:
                              resourceId,
                        );

                  });


                },

              );


            },

          ),

        ),



        Padding(

          padding:
              const EdgeInsets.all(16),


          child:
              FilledButton.icon(

            onPressed:
                _save,


            icon:
                const Icon(
                  Icons.save,
                ),


            label:
                const Text(
                  'Salva configurazione',
                ),

          ),

        ),

      ],

    );

  }

}