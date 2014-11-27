
class CreateOrderCtrl

    constructor: (@$log, @$location, @Order, @OrderService) ->
        @order = @Order.get()
        @$log.debug "constructing CreateOrderController"
        @$log.debug "prepared products #{@order.products}"

    createOrder: () ->
        @$log.debug "createOrder()"
        newOrder = {products:['nam1':1], email:'qwewq', timestamp:0}
        newOrder.timestamp = Date.now()
        newOrder.email = @order.email
        newOrder.products[name] = number for {name, number} in @order.products
        @OrderService.createOrder(newOrder)
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