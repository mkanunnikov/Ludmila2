package models

import org.joda.time.DateTime

import scala.collection.mutable

case class Order( products: mutable.HashMap[Product, Int], email: String, timestamp: DateTime)

object OrderJsonFormats {
  import play.api.libs.json._
  import play.api.libs.functional.syntax._

  implicit val orderReads = (
      (__ \ "products").read(
        map[Product, Int]
      ) and
      (__ \ "email").read[String] and
      (__ \ "timestamp").read[DateTime]
    )(Order)

  implicit val orderWrites = (
      (__ \ "products").write[mutable.Map[Product, Int]] and
      (__ \ "email").write[String] and
      (__ \ "timestamp").write[DateTime]
    )(unlift(Order.unapply))

  implicit val orderFormat = Format(orderReads, orderWrites)
}