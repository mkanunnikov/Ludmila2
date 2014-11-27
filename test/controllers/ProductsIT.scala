package controllers

import scala.concurrent._
import duration._
import org.specs2.mutable._

import play.api.libs.json._
import play.api.test._
import play.api.test.Helpers._
import java.util.concurrent.TimeUnit

import scala.util.Random

/**
 * Created by Max on 11.11.2014.
 */
class ProductsIT extends Specification {

  val timeout: FiniteDuration = FiniteDuration(5, TimeUnit.SECONDS)

  "Products" should {

    "insert a valid json" in {
      running(FakeApplication()) {
        val productID = Random.nextString(4)
        val request = FakeRequest.apply(POST, "/createProduct").withJsonBody(Json.obj(
          "name" -> s"product name $productID",
          "description" -> "product description product description product description product description",
          "weight" -> 12,
          "availability" -> true,
          "price" -> 1))
        val response = route(request)
        response.isDefined mustEqual true
        val result = Await.result(response.get, timeout)
        result.header.status must equalTo(CREATED)
      }
    }

    "fail inserting a non valid json" in {
      running(FakeApplication()) {
        val request = FakeRequest.apply(POST, "/createProduct").withJsonBody(Json.obj(
          "name" -> 123,
          "description" -> "product description product description product description product description",
          "weight" -> 12,
          "availability" -> true,
          "price" -> 1))
        val response = route(request)
        response.isDefined mustEqual true
        val result = Await.result(response.get, timeout)
        contentAsString(response.get) mustEqual "invalid json"
        result.header.status mustEqual BAD_REQUEST
      }
    }

  }

}
