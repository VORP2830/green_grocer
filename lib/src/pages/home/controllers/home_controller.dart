import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:green_grocer/src/models/category_model.dart';
import 'package:green_grocer/src/models/item_model.dart';
import 'package:green_grocer/src/pages/home/repositories/home_repository.dart';
import 'package:green_grocer/src/services/utils_services.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  final UtilsServices _utilsServices = UtilsServices();
  List<CategoryModel> categories = [];
  List<ItemModel> get products => currentCategory?.items ?? [];
  CategoryModel? currentCategory;
  bool isCategoryLoading = false;
  bool isProductLoading = true;

  RxString searchTitle = ''.obs;

  bool get isLastPage {
    if (currentCategory!.items.length < itemsPerPage) return true;
    return currentCategory!.pagination * itemsPerPage > products.length;
  }

  void setLoading(bool value, {bool isProduct = false}) {
    if (!isProduct) {
      isCategoryLoading = value;
    } else {
      isProductLoading = value;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    debounce(
      searchTitle,
      (_) => filterByTitle(),
      time: const Duration(milliseconds: 600),
    );
    getAllCategories();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();
    if (currentCategory!.items.isNotEmpty) return;
    getAllProducts();
  }

  Future<void> getAllCategories() async {
    try {
      setLoading(true);
      categories = await _homeRepository.getAllCategories();
      if (categories.isEmpty) return;
      selectCategory(categories.first);
    } catch (e) {
      _utilsServices.showToast(message: e.toString(), isError: true);
    } finally {
      setLoading(false);
    }
  }

  Future<void> getAllProducts({bool canLoad = true}) async {
    try {
      if (canLoad) {
        setLoading(true, isProduct: true);
      }
      Map<String, dynamic> body = {
        'page': currentCategory!.pagination,
        'categoryId': currentCategory!.id,
        'itemsPerPage': itemsPerPage,
      };
      if (searchTitle.value.isNotEmpty) {
        body['title'] = searchTitle.value;
        if (currentCategory!.id == '') {
          body.remove('categoryId');
        }
      }
      currentCategory!.items.addAll(await _homeRepository.getAllProducts(body));
    } catch (e) {
      _utilsServices.showToast(message: e.toString(), isError: true);
    } finally {
      setLoading(false, isProduct: true);
    }
  }

  Future<void> loadMoreProducts() async {
    currentCategory!.pagination++;
    getAllProducts(canLoad: false);
  }

  void filterByTitle() {
    for (var category in categories) {
      category.items.clear();
      category.pagination = 0;
    }
    if (searchTitle.value.isEmpty) {
      categories.removeAt(0);
    } else {
      CategoryModel? c = categories.firstWhereOrNull((cat) => cat.id == '');
      if (c == null) {
        final allProductsCategory = CategoryModel(
          id: '',
          title: 'Todos',
          pagination: 0,
          items: [],
        );
        categories.insert(0, allProductsCategory);
      } else {
        c.items.clear();
        c.pagination = 0;
      }
    }
    currentCategory = categories.first;
    update();
    getAllProducts();
  }
}
