module Data.Gooey.TokenID exposing (TokenID, tokenIDDecoder)

import Json.Decode as Decode exposing (Decoder, int, map)


type TokenID
    = TokenID Int


tokenIDDecoder : Decoder TokenID
tokenIDDecoder =
    map TokenID int
