
class CreateOrderCtrl

    constructor: (@$log, @$location,  @OrderService) ->
        @$log.debug "constructing CreateOrderController"
        @order = {}

    createOrder: () ->
        @$log.debug "createOrder()"
        @order.timestamp = 0
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

    prepareOrder: () ->
        @$log.debug "prepareOrder()"
        @order.timestamp = 0
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

controllersModule.controller('CreateOrderCtrl', CreateOrderCtrl)