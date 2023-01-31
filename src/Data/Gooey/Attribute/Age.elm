module Data.Gooey.Attribute.Age exposing (Age, ageDecoder)

import Json.Decode as Decode exposing (Decoder, andThen, string, succeed)


type Age
    = Alive String
    | Dead


ageDecoder : Decode.Decoder Age
ageDecoder =
    Decode.oneOf
        [ Decode.map Dead (Decode.succeed "deceased")
        , Decode.map Alive Decode.string
        ]
