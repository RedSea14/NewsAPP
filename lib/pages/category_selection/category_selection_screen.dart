import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newapp/model/category_model.dart';
import 'package:newapp/provider/category_provider.dart';
import 'package:newapp/router/app_route_constants.dart';
import 'package:provider/provider.dart';

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({super.key});

  @override
  State<CategorySelectionScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  bool valueCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: FutureBuilder(
          future: context.read<CategoryProvider>().getListCate(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<CategoryModel> data = snapshot.data as List<CategoryModel>;
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 6 / 2,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      valueCheck =
                          Provider.of<CategoryProvider>(context, listen: false)
                              .checkIndex(data[index]);
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.primaries[index],
                        ),
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return CheckboxListTile(
                              onChanged: (value) {
                                setState(() {
                                  valueCheck = value!;
                                  if (valueCheck == true) {
                                    Provider.of<CategoryProvider>(context,
                                            listen: false)
                                        .getListCateByIdStream(data[index].id);
                                  } else {
                                    Provider.of<CategoryProvider>(context,
                                            listen: false)
                                        .deleteCateById(data[index].id);
                                  }
                                });
                              },
                              value: valueCheck,
                              title: Text(
                                data[index].name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepPurple),
                    child: const Text(
                      'Go Home',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
