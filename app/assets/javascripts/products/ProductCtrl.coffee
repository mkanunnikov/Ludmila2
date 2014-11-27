class ProductCtrl

  constructor: (@$log, @$location, @Order, @ProductService) ->
#    @test1 = @Test.get()
    @order = @Order.get()
    @$log.debug "constructing ProductController"
    @products = []
#    @order = {products:[],email:'',timestamp:0}
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
    @$log.debug "all Products(#{@products})"
    @order.products = (product for product in @products when product.number > 0)
    @$log.debug "prepared products #{@order.products}"
    @$log.debug "prepared products #{@order.products.length}"
    @Order.set(@order)
#    @Test.set(@test1)
    @$location.path("/order/create")

controllersModule.controller('ProductCtrl', ProductCtrl)