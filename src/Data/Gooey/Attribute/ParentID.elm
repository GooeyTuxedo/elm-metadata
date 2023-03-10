module Data.Gooey.Attribute.ParentID exposing (ParentID, parentIDDecoder)

import Data.Gooey.TokenID exposing (TokenID, tokenIDDecoder)
import Json.Decode as Decode exposing (Decoder, int)


type ParentID
    = ParentID TokenID
    | NoParent


parentIDDecoder : Decoder ParentID
parentIDDecoder =
    Decode.oneOf
        [ Decode.map TokenID int
        , Decode.succeed NoParent
        ]
