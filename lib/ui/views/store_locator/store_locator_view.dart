import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:siakap/ui/common/app_colors.dart';
import 'package:siakap/ui/common/app_widgets.dart';
import 'store_locator_viewmodel.dart';

class StoreLocatorView extends StackedView<StoreLocatorViewModel> {
  const StoreLocatorView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StoreLocatorViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Locator'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RoundedTextField(
                hintText: 'Search for stores',
                prefixIcon: Icons.search,
                controller: viewModel.searchController,
                onChanged: (value) => viewModel.searchStores(value),
              ),
            ),
            Expanded(
              child: viewModel.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: viewModel.stores.length,
                      itemBuilder: (context, index) {
                        final store = viewModel.stores[index];
                        return ListTile(
                          leading: const Icon(Icons.store),
                          title: Text(store.name),
                          subtitle: Text(store.address),
                          trailing: Text('${store.distance} km'),
                          onTap: () => viewModel.selectStore(store),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  StoreLocatorViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StoreLocatorViewModel();
}
