package models

import scala.collection.mutable

case class Order( product: mutable.HashMap[Product, Int], email: String)

object OrderJsonFormats {
  import play.api.libs.json.Json

  implicit val orderFormat = Json.format[Order]
}