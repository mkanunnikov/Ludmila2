
class OrderService

  @headers = {'Accept': 'application/json', 'Content-Type': 'application/json'}
  @defaultConfig = { headers: @headers }

  constructor: (@$log, @$http, @$q) ->
    @$log.debug "constructing OrderService"

  createOrder: (order) ->
    @$log.debug "createOrder #{angular.toJson(order, true)}"
    deferred = @$q.defer()

    @$http.post('/createOrder', order)
    .success((data, status, headers) =>
      @$log.info("Successfully created Order - status #{status}")
      deferred.resolve(data)
    )
    .error((data, status, headers) =>
      @$log.error("Failed to create order - status #{status}")
      deferred.reject(data);
    )
    deferred.promise

servicesModule.service('OrderService', OrderService)