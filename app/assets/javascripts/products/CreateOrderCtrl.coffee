
class CreateOrderCtrl

    constructor: (@$log, @$location, @Order, @OrderService) ->
#        @test1 = @Test.get()
        @order = @Order.get()
#        @order = {products:[{name:'prod1',number:11}],email:'1@1.com',timestamp:0}
        @$log.debug "constructing CreateOrderController"
        @$log.debug "prepared products #{@order.products}"

    createOrder: () ->
        @$log.debug "createOrder()"
        @order.timestamp = Date.now()
        @OrderService.createOrder(@order)
        .then(
            (data) =>
                @$log.debug "Promise returned #{data} Order"
                @order = data
                @$location.path("/")
            ,
            (error) =>
                @$log.error "Unable to create Order: #{error}"
            )

#    prepareOrder: () ->
#        @$log.debug "prepareOrder()"
#        @products
#        @order.timestamp = Date.now()
#        @$location.path("/order/create")

controllersModule.controller('CreateOrderCtrl', CreateOrderCtrl)