package models

case class Product( price: Int,
                    description: String,
                    name: String,
                    weight: Int,
                    availability: Boolean)

object ProductJsonFormats {
  import play.api.libs.json._
  import play.api.libs.functional.syntax._

  implicit val productReads = (
      (__ \ "price").read[Int] and
      (__ \ "description").read[String] and
      (__ \ "name").read[String] and
      (__ \ "weight").read[Int] and
      (__ \ "availability").read[Boolean]
    )(Product)

  implicit val productWrites = (
      (__ \ "price").write[Int] and
      (__ \ "description").write[String] and
      (__ \ "name").write[String] and
      (__ \ "weight").write[Int] and
      (__ \ "availability").write[Boolean]
    )(unlift(Product.unapply))

//  implicit val productFormat = Format(productReads, productWrites)
}