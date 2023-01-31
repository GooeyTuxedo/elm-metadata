module Data.BodyType exposing (BodyType, bodyTypeDecoder)

import Json.Decode as Decode exposing (Decoder, field, map, oneOf, string, succeed)


type BodyType
    = Body String
    | Unrevealed


bodyTypeDecoder : Decode.Decoder BodyType
bodyTypeDecoder =
    Decode.oneOf
        [ Decode.map Body string
        , Decode.succeed Unrevealed
        ]
