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
 * The Products controllers encapsulates the Rest endpoints and the interaction with the MongoDB, via ReactiveMongo
 * play plugin. This provides a non-blocking driver for mongoDB as well as some useful additions for handling JSon.
 * @see https://github.com/ReactiveMongo/Play-ReactiveMongo
 */
@Singleton
class Products extends Controller with MongoController {

  private final val logger: Logger = LoggerFactory.getLogger(classOf[Products])

  /*
   * Get a JSONCollection (a Collection implementation that is designed to work
   * with JsObject, Reads and Writes.)
   * Note that the `collection` is not a `val`, but a `def`. We do _not_ store
   * the collection reference to avoid potential problems in development with
   * Play hot-reloading.
   */
  def collection: JSONCollection = db.collection[JSONCollection]("products")

  // ------------------------------------------ //
  // Using case classes + Json Writes and Reads //
  // ------------------------------------------ //

  import models._
  import models.ProductJsonFormats._

  def findProducts = Action.async {
    logger.info("findProducts1")
    logger.debug(s"findProducts2")
    logger.info(s"findProducts3")

    // let's do our query
    val cursor: Cursor[Product] = collection.
      // find all
      find(Json.obj("availability" -> true)).
      // sort them by creation date
//      sort(Json.obj("created" -> -1)).
      // perform the query and get a cursor of JsObject
      cursor[Product]

    // gather all the JsObjects in a list
    val futureProductsList: Future[List[Product]] = cursor.collect[List]()

    // transform the list into a JsArray
    val futureProductsJsonArray: Future[JsArray] = futureProductsList.map { products =>
      Json.arr(products)
    }
    // everything's ok! Let's reply with the array
    futureProductsJsonArray.map {
      products =>
        Ok(products(0))
    }
  }

  def createProduct = Action.async(parse.json) {
    logger.debug(s"createProduct")
    request =>
      logger.debug(s"createProduct r= $request")
      request.body.validate[Product].map {
        product =>
          logger.debug(s"createProduct p= $product")
          collection.insert[Product](product).map {
            lastError =>
              logger.debug(s"Successfully inserted with LastError: $lastError")
              Created(s"Product Created")
          }
      }.getOrElse(Future.successful(BadRequest("invalid json")))
  }

}
