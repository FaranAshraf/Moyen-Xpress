import '../resources/exports/index.dart';

typedef OnCardTap = Function(int productId);

class PaginatedListView extends StatefulWidget {
  final Function(int)? onTap1;
  final Function(int)? onLeftButtonTap;
  final List<ListViewModel>? dummyData;
 final OnCardTap? onSecondaryButtonTap;
 final OnCardTap? onPrimaryButtonTap;
  /// Setting this variable to [true] will make a horizontal list
  /// of provided [items].

  final bool isDataInGrid;

  /// [heightOfList] will define height of horizontal list view,
  /// this variable will only work if [isDataInGrid] is set to true.

  final double heightOfListViewItem;

  /// [widthOfListViewItem] will define width of each card inside horizontal
  ///  list view, this variable will only work if [isDataInGrid] is set
  /// to true.

  final double widthOfListViewItem;

  /// Use [onCardTap] to get the product id which you can use to get the product
  /// details from api.
  ///
  /// Note: If you pass [onDeleteIconTap] function then [onCardTap] will be ignored
  /// because user can either delete an item or go to the details page of specific item

  final OnCardTap? onCardTap;

  /// Set this variable [true]  to show and hide rating

  final bool showRating;

  /// Pass the [Api url] to get the list of items or products.

  final String apiUrl;

  /// [isGetApi] defines that weather the api is [Get Api] or [Post Api]
  ///
  /// By default [isGetApi] is set to [true]

  final bool isGetApi;

  /// [parameters] will be passed as [quaryParameters] by default it take [page]
  ///
  /// field which defines the [pagination] page index.

  final Map<String, dynamic>? parameters;

  final BoxFit? fit;

  final bool showPaddingHorizontally;

  final ScrollPhysics? physics;

  final bool showAllItems;

  final bool showOnlyImage;

  final double? borderRadius;

  final bool showTopSellerOrBrands;

  final String? buttonTitle;

  final bool showOnlyRightBtn;

  const PaginatedListView({
    Key? key,
    this.dummyData,
    this.isDataInGrid = true,
    this.heightOfListViewItem = Sizes.HEIGHT_250,
    this.widthOfListViewItem = Sizes.WIDTH_250,
    this.onCardTap,
    this.showRating = true,
    this.isGetApi = true,
    this.parameters,
    this.fit,
    this.showPaddingHorizontally = true,
    this.apiUrl = '',
    this.showAllItems = true,
    this.physics,
    this.showOnlyImage = false,
    this.borderRadius,
    this.showTopSellerOrBrands = false,
    this.buttonTitle,
    this.showOnlyRightBtn = false,
    this.onTap1,
    this.onLeftButtonTap, 
    this.onSecondaryButtonTap,
    this.onPrimaryButtonTap,
  }) : super(key: key);

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  static BaseApiServices baseApiService = NetworkApiServices();

  late final PagingController<int, ListViewModel> _pagingController;

  String covertIntoKFormat(double amount) {
    return NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '',
    ).format(amount);
  }

  getResponseModel() {
    return ListViewModel(id: 1, title: "");
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _getList(pageKey);
      final isLastPage = newItems.length < Urls.PAGESIZE;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey.toInt());
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  _getList(int pageIndex) async {
    if (widget.dummyData != null) {
      await Future.delayed(const Duration(seconds: 3));
      return widget.dummyData;
    }
    try {
      List<ListViewModel> itemsList = [];
      Map<String, dynamic> quaryParameters = {};
      if (widget.parameters != null) {
        quaryParameters.addAll(widget.parameters!);
      }
      quaryParameters["page"] = pageIndex.toString();
      quaryParameters["limit"] = Urls.PAGESIZE.toString();

      if (widget.isGetApi) {
        var apiResponse = await baseApiService.getApi(
          widget.apiUrl,
          quaryParameters: quaryParameters,
        );

        if (apiResponse is bool) return [];
        itemsList = ListViewModel.listFromJson(apiResponse);
      } else {
        var apiResponse = await baseApiService.postApi(
          widget.apiUrl,
          quaryParameters,
        );

        if (apiResponse is bool) return [];
        itemsList = ListViewModel.listFromJson(apiResponse);
      }
      return itemsList;
    } catch (e) {
      log.e(e.toString());
    }
  }

  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: 1);
    _pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isDataInGrid ? _buildGridView(context) : _buildListView();
  }

  Widget _buildListView() {
    return SizedBox(
      height: widget.heightOfListViewItem,
      child: PagedListView.separated(
        pagingController: _pagingController,
        padding: EdgeInsets.symmetric(
          horizontal: widget.showPaddingHorizontally ? Sizes.PADDING_16 : 0.0,
        ),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        builderDelegate: PagedChildBuilderDelegate<ListViewModel>(
          itemBuilder: (context, item, index) => Container(
            margin: const EdgeInsets.symmetric(vertical: Sizes.PADDING_20),
            width: widget.widthOfListViewItem,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.13),
                  offset: const Offset(2.0, 4.0),
                  blurRadius: 16.0,
                ),
              ],
            ),
            child: PaginatedListViewCardContent(
              item: item,
              showRating: widget.showRating,
              fit: widget.fit,
              onCardTap: widget.onCardTap,
              showOnlyImage: widget.showOnlyImage,
              borderRadius: widget.borderRadius,
              showTopSellerOrBrands: widget.showTopSellerOrBrands,
              buttonTitle: widget.buttonTitle,
            ),
          ),
          firstPageProgressIndicatorBuilder: (context) =>
              const HorizontalListViewShimmer(),
          newPageProgressIndicatorBuilder: (context) =>
              const HorizontalListViewShimmer(),
          firstPageErrorIndicatorBuilder: (context) =>  Align(
            alignment: Alignment.center,
            child: NoContent(
              title: Strings.CONTENT_NOT_FOUND.tr,
              subtitle: Strings.SOMETHING_WENT_WRONG.tr,
              img: Assets.NO_HISTORY,
              padding: 32,
              showBackground: false,
            ),
          ),
          noItemsFoundIndicatorBuilder: (context) =>  Align(
            alignment: Alignment.center,
            child: NoContent(
              img: Assets.NO_HISTORY,
              title: Strings.CONTENT_NOT_FOUND.tr,
              subtitle: Strings.SOMETHING_WENT_WRONG.tr,
              padding: 32,
              showBackground: false,
            ),
          ),
          newPageErrorIndicatorBuilder: (context) => Align(
            alignment: Alignment.center,
            child: CustomLoading.spinKitThreeBouncePrimary,
          ),
        ),
        separatorBuilder: (_, index) => const SpaceW20(),
      ),
    );
  }

  Widget _buildGridView(BuildContext context) {
    return PagedGridView(
      addAutomaticKeepAlives: true,
      pagingController: _pagingController,
      padding: const EdgeInsets.all(Sizes.PADDING_12),
      addRepaintBoundaries: true,
      shrinkWrap: true,
      physics: widget.physics ?? const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Sizes.WIDTH_18,
        mainAxisSpacing: Sizes.HEIGHT_20,
        childAspectRatio: 3 / 3.5,
      ),
      builderDelegate: PagedChildBuilderDelegate<ListViewModel>(
        firstPageProgressIndicatorBuilder: (context) => const GridViewShimmer(),
        newPageProgressIndicatorBuilder: (context) =>
            CustomLoading.spinKitThreeBouncePrimary,
        firstPageErrorIndicatorBuilder: (context) =>  Align(
          alignment: Alignment.center,
          child: NoContent(
            img: Assets.NO_HISTORY,
            title: Strings.CONTENT_NOT_FOUND.tr,
            subtitle: Strings.SOMETHING_WENT_WRONG.tr,
            padding: 32,
            showBackground: false,
          ),
        ),
        noItemsFoundIndicatorBuilder: (context) =>  Padding(
          padding: const EdgeInsets.only(top: 120),
          child: NoContent(
            img: Assets.NO_HISTORY,
            title: Strings.CONTENT_NOT_FOUND.tr,
            subtitle: Strings.NO_ITEMS_FOUND.tr,
            padding: 32,
            showBackground: false,
          ),
        ),
        newPageErrorIndicatorBuilder: (context) => Align(
          alignment: Alignment.center,
          child: CustomLoading.spinKitThreeBouncePrimary,
        ),
        itemBuilder: (context, item, index) => PaginatedListViewCardContent(
          item: item,
          onTap1: widget.onTap1,
          onLeftButtonTap: widget.onLeftButtonTap,
          showRating: widget.showRating,
          fit: widget.fit,
          onCardTap: widget.onCardTap,
          showOnlyImage: widget.showOnlyImage,
          borderRadius: widget.borderRadius,
          showTopSellerOrBrands: widget.showTopSellerOrBrands,
          buttonTitle: widget.buttonTitle,
          showOnlyRightBtn: widget.showOnlyRightBtn,
          onSecondaryButtonTap: widget.onSecondaryButtonTap,
          onPrimaryButtonTap: widget.onPrimaryButtonTap,
        ),
      ),
    );
  }
}
