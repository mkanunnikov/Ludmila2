package controllers

import play.modules.reactivemongo.MongoController
import play.modules.reactivemongo.json.collection.JSONCollection
import scala.concurrent.Future
import reactivemongo.api.Cursor
import play.api.libs.concurrent.Execution.Implicits.defaultContext
import org.slf4j.{LoggerFactory, Logger}
import javax.inject.Singleton
import play.api.mvc._
import play.api.libs.json._

/**
 * The Orders controllers encapsulates the Rest endpoints and the interaction with the MongoDB, via ReactiveMongo
 * play plugin. This provides a non-blocking driver for mongoDB as well as some useful additions for handling JSon.
 * @see https://github.com/ReactiveMongo/Play-ReactiveMongo
 */
@Singleton
class Orders extends Controller with MongoController {

  private final val logger: Logger = LoggerFactory.getLogger(classOf[Orders])

  /*
   * Get a JSONCollection (a Collection implementation that is designed to work
   * with JsObject, Reads and Writes.)
   * Note that the `collection` is not a `val`, but a `def`. We do _not_ store
   * the collection reference to avoid potential problems in development with
   * Play hot-reloading.
   */
  def collection: JSONCollection = db.collection[JSONCollection]("orders")

  // ------------------------------------------ //
  // Using case classes + Json Writes and Reads //
  // ------------------------------------------ //

  import models._
  import models.OrderJsonFormats._

  def findOrders = Action.async {
    // let's do our query
    val cursor: Cursor[Order] = collection.
      // find all
      find(Json.obj("availability" -> true)).
      // sort them by creation date
      //      sort(Json.obj("created" -> -1)).
      // perform the query and get a cursor of JsObject
      cursor[Order]

    // gather all the JsObjects in a list
    val futureOrdersList: Future[List[Order]] = cursor.collect[List]()

    // transform the list into a JsArray
    val futureOrdersJsonArray: Future[JsArray] = futureOrdersList.map { orders =>
      Json.arr(orders)
    }
    // everything's ok! Let's reply with the array
    futureOrdersJsonArray.map {
      orders =>
        Ok(orders(0))
    }
  }

  def createOrder = Action.async(parse.json) {
    request =>
    /*
     * request.body is a JsValue.
     * There is an implicit Writes that turns this JsValue as a JsObject,
     * so you can call insert() with this JsValue.
     * (insert() takes a JsObject as parameter, or anything that can be
     * turned into a JsObject using a Writes.)
     */
      request.body.validate[Order].map {
        order =>
        // `order` is an instance of the case class `models.Order`
          collection.insert[Order](order).map {
            lastError =>
              logger.debug(s"Successfully inserted with LastError: $lastError")
              Created(s"Order Created")
          }
      }.getOrElse(Future.successful(BadRequest("invalid json")))
  }


}
