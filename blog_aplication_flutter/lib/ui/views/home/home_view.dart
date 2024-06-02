import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:blog_aplication_flutter/ui/views/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewmodel) => viewmodel.init(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Blogify",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        body: Center(
          child: viewModel.isBusy
              ? CircularProgressIndicator()
              : viewModel.blogs.isEmpty
                  ? Text('No blogs found')
                  : ListView.builder(
                      itemCount: viewModel.blogs.length,
                      itemBuilder: (context, index) {
                        var blog = viewModel.blogs[index];
                        return ListTile(
                          title: Text(blog['title']),
                          subtitle: Text(blog['body']),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
