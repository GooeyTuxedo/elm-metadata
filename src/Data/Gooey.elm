module Data.Gooey exposing (Gooey)

import Data.Gooey.Attribute.Age exposing (Age)
import Data.Gooey.Attribute.BodyType exposing (BodyType)
import Data.Gooey.Attribute.Disposition exposing (Disposition)
import Data.Gooey.Attribute.Generation exposing (Generation)
import Data.Gooey.Attribute.Health exposing (Health)
import Data.Gooey.Attribute.IsAwake exposing (IsAwake)
import Data.Gooey.Attribute.IsBuried exposing (IsBuried)
import Data.Gooey.Attribute.MitosisCredits exposing (MitosisCredits)
import Data.Gooey.Attribute.ParentID exposing (ParentID)
import Data.Gooey.TokenID exposing (TokenID, tokenIDDecoder)
import Data.Gooey.Trait exposing (Trait, traitDecoder)
import Json.Decode as Decode exposing (Decoder, string)
import Json.Decode.Pipeline exposing (required)



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
    , generation : Generation
    , health : Health
    , disposition : Disposition
    , age : Age
    , isAwake : IsAwake
    , isBuried : IsBuried
    , mitosisCredits : MitosisCredits
    , parentID : ParentID
    , body : BodyType
    }



--  Decoders


decodeGooeyIntermediate : Decoder GooeyIntermediate
decodeGooeyIntermediate =
    Decode.succeed GooeyIntermediate
        |> required "tokenID" tokenIDDecoder
        |> required "name" string
        |> required "description" string
        |> required "image" string
        |> required "attributes" (Decode.list traitDecoder)


mapIntermediateToGooey : GooeyIntermediate -> Gooey
