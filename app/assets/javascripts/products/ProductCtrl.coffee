class ProductCtrl

  constructor: (@$log, @$location, @$scope, @ProductService) ->
    @$log.debug "constructing ProductController"
    @products = []
    @order = {products:[],email:'',timestamp:0}
    @$scope.test1 = 'test'
    @getAllProducts()

  getAllProducts: () ->
    @$log.debug "getAllProducts()"

    @ProductService.listProducts()
    .then(
      (data) =>
        @$log.debug "Promise returned #{data.length} Products"
        @products = data
    ,
    (error) =>
      @$log.error "Unable to get Products: #{error}"
    )

  prepareOrder: () ->
    @$log.debug "prepareOrder(#{@products})"
    @order.products = for name, number of @products #when number > 0
      name: number
    @$log.debug "prepared order #{@order.products}"
    @order.timestamp = Date.now()
    @$location.path("/order/create")

controllersModule.controller('ProductCtrl', ProductCtrl)