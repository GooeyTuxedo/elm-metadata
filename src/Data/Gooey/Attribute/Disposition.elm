module Data.Gooey.Attribute.Disposition exposing (Disposition, dispositionDecoder)

import Json.Decode as Decode exposing (Decoder, andThen, fail, string, succeed)


type Disposition
    = Naughty
    | Nice


dispositionDecoder : Decoder Disposition
dispositionDecoder =
    Decode.oneOf
        [ Decode.map (always Naughty) (Decode.succeed "naughty")
        , Decode.map (always Nice) (Decode.succeed "nice")
        ]
