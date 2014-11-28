
class CreateOrderCtrl

    constructor: (@$log, @$location, @Order, @OrderService) ->
        @order = @Order.get()
        @$log.debug "constructing CreateOrderController"
        @$log.debug "prepared products #{@order.products}"

    createOrder: () ->
        @$log.debug "createOrder()"
        newOrder = {products:{}, email:'qwewq', timestamp:0}
        newOrder.timestamp = Date.now()
        newOrder.email = @order.email
        newOrder.products[name] = number for {name, number} in @order.products
        @OrderService.createOrder(newOrder)
        .then(
            (data) =>
                @$log.debug "Promise returned #{data} Order"
                newOrder = data
                @$location.path("/")
            ,
            (error) =>
                @$log.error "Unable to create Order: #{error}"
        )

controllersModule.controller('CreateOrderCtrl', CreateOrderCtrl)