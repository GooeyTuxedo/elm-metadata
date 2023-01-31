module Data.Gooey exposing (Gooey)

import Data.Age exposing (Age, ageDecoder)
import Data.BodyType exposing (BodyType, bodyTypeDecoder)
import Data.Disposition exposing (Disposition, dispositionDecoder)
import Data.ParentID exposing (ParentID)
import Data.TokenID exposing (TokenID, tokenIDDecoder)
import Json.Decode as Decode
    exposing
        ( Decoder
        , bool
        , int
        , string
        )
import Json.Decode.Pipeline exposing (optional, required)



-- Type definitions


type alias GooeyIntermediate =
    { tokenID : TokenID
    , name : String
    , description : String
    , image : String
    , traits : List Trait
    }


type alias Gooey =
    { tokenID : TokenID
    , name : String
    , description : String
    , image : String
    , generation : Int
    , health : Int
    , disposition : Disposition
    , age : Age
    , isAwake : Bool
    , isBuried : Bool
    , mitosisCredits : Int
    , parentID : ParentID
    , body : BodyType
    }



--  Decoders


decodeGooey : Decoder Gooey
decodeGooey =
    Decode.succeed Gooey
        |> required "tokenID" tokenIDDecoder
        |> required "name" string
        |> required "description" string
        |> required "image" string
        |> required "generation" (customDecoder int)
        |> required "health" (customDecoder int)
        |> required "disposition" (customDecoder dispositionDecoder)
        |> required "age" (customDecoder ageDecoder)
        |> required "isAwake" (customDecoder bool)
        |> required "isBuried" (customDecoder bool)
        |> required "mitosisCredits" (customDecoder int)
        |> required "parentID" (customDecoder parentIDDecoder)
        |> optional "body" (customDecoder bodyDecoder) Unrevealed



-- Helper function to retrieve an attribute's value from a list of attributes
-- getAttribute : List (String, Value) -> String -> Result String Value
-- getAttribute attributes name =
--     attributes
--         |> List.filter ((n, _) -> n == name)
--         |> List.head
--         |> Result.fromMaybe (Err ("Attribute " ++ name ++ " not found"))
-- Custom decoder to retrieve the value of a specific attribute


customDecoder : (List ( String, Value ) -> Result String a) -> Decoder a
customDecoder decoder =
    field "attributes" (list (tuple2 string value))
        |> andThen
            (\attributes ->
                decoder attributes
                    |> Result.mapError (\err -> "attribute error: " ++ err)
            )
