
class CreateOrderCtrl

    constructor: (@$log, @$location, @Order, @OrderService) ->
        @order = @Order.get()
        @$log.debug "constructing CreateOrderController"
        @$log.debug "prepared products #{@order.products}"

    createOrder: () ->
        @$log.debug "createOrder()"
        newOrder = {products:{}, email:'qwewq', timestamp:0}
#        newOrder = {email:'qwewq', timestamp:0}
        newOrder.timestamp = Date.now()
        newOrder.email = @order.email
        newOrder.products[name] = number for {name, number} in @order.products
#        products = [{
#            "price": 1,
#            "description": "product description product description product description product description",
#            "name": "product_name1",
#            "weight": 12,
#            "availability": true,
#            "number": 2
#        },{
#            "price": 2,
#            "description": "product description product description product description product description",
#            "name": "product_name2",
#            "weight": 12,
#            "availability": true,
#            "number": 5
#        }]
#        newProducts = {}
#        newProducts[name] = number for {name, number} in products
#        newOrder.products = newProducts
#        @$log.debug "Test: #{key}-#{value}" for key,value of newProducts
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