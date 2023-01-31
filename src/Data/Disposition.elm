module Data.Disposition exposing (Disposition, dispositionDecoder)

import Json.Decode as Decode exposing (Decoder, string, andThen, succeed, fail)


type Disposition
    = Naughty
    | Nice


dispositionDecoder : Decoder Disposition
dispositionDecoder =
    Decode.oneOf
        [ Decode.map (always Naughty) (Decode.succeed "naughty")
        , Decode.map (always Nice) (Decode.succeed "nice")
        ]