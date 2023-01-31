module Data.Gooey.Trait exposing (Trait)

import Data.Age exposing (Age, ageDecoder)
import Data.BodyType exposing (BodyType, bodyTypeDecoder)
import Data.Disposition exposing (Disposition, dispositionDecoder)
import Data.ParentID exposing (ParentID)
import Json.Decode
    exposing
        ( Decoder
        , bool
        , field
        , int
        , map
        , map2
        , oneOf
        , optional
        , string
        )


type Trait
    = AgeTrait Age
    | BodyTrait BodyType
    | DispositionTrait Disposition
    | Generation Int
    | Health Int
    | IsAwake Bool
    | IsBuried Bool
    | ParentIDTrait ParentID
    | MitosisCredits Int


traitDecoder : Decoder Trait
traitDecoder =
    map2 Trait
        (field "trait_type" string)
        (field "value"
            oneOf
            [ map Generation int
            , map Health int
            , map DispositionTrait (string |> dispositionDecoder)
            , map AgeTrait (string |> ageDecoder)
            , map IsAwake bool
            , map IsBuried bool
            , map MitosisCredits int
            , map ParentIDTrait (int |> optional ParentIDDecoder)
            , map BodyTrait (string |> bodyTypeDecoder)
            ]
        )



-- Gooey = { Gooey | attributes: [ Attribute ]}
