package models

case class Product( price: Int,
                 name: String,
                 weight: Int,
                 availability: Boolean)

object ProductJsonFormats {
  import play.api.libs.json.Json

  // Generates Writes and Reads for Feed and User thanks to Json Macros
  implicit val productFormat = Json.format[Product]
}