class CategoryModel{
  bool ? status;
  CategoryDataModel ? data;

  CategoryModel.fromJson(Map<String , dynamic> json){
    status = json['status'];
    data = CategoryDataModel.fromJsom(json['data']);
  }
}

class CategoryDataModel{
  int ? currentPage;
  List<Map<String , dynamic>> data = [];

  CategoryDataModel.fromJsom(Map<String , dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(element);
    });
  }

}

class DataModel{
  int ? id;
  String ? name;
  String ? image;

  DataModel.fromJson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}