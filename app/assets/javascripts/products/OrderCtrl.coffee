class OrderCtrl

  constructor: (@$log, @OrderService) ->
    @$log.debug "constructing OrderController"
    @orders = []
    @getAllOrders()

  getAllOrders: () ->
    @$log.debug "getAllOrders()"

    @OrderService.listOrders()
    .then(
      (data) =>
        @$log.debug "Promise returned #{data.length} Orders"
        @orders = data
    ,
    (error) =>
      @$log.error "Unable to get Orders: #{error}"
    )


controllersModule.controller('OrderCtrl', OrderCtrl)