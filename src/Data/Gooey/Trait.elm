module Data.Gooey.Trait exposing (Trait, traitDecoder)

import Data.Gooey.Attribute.Age exposing (Age)
import Data.Gooey.Attribute.BodyType exposing (BodyType)
import Data.Gooey.Attribute.Disposition exposing (Disposition)
import Data.Gooey.Attribute.ParentID exposing (ParentID)
import Json.Decode
    exposing
        ( Decoder
        , field
        , int
        , map2
        , string
        )


type Trait
    = AgeTrait String
    | BodyTrait String
    | DispositionTrait String
    | GenTrait Int
    | HealthTrait Int
    | IsAwakeTrait Bool
    | IsBuriedTrait Bool
    | ParentIDTrait (Maybe Int)
    | MitosisCreditsTrait Int


traitDecoder : Decoder Trait
traitDecoder =
    map2
        (\traitType value ->
            case traitType of
                "age" ->
                    AgeTrait value

                "body" ->
                    BodyTrait value

                "disposition" ->
                    DispositionTrait value

                "generation" ->
                    GenTrait (value |> toInt)

                "health" ->
                    HealthTrait (value |> toInt)

                "isAwake" ->
                    IsAwakeTrait (value |> toBool)

                "isBuried" ->
                    IsBuriedTrait (value |> toBool)

                "parentID" ->
                    ParentIDTrait (value |> String.toInt)

                "mitosisCredits" ->
                    MitosisCreditsTrait (value |> toInt)

                _ ->
                    AgeTrait ""
        )
        (field "trait_type" string)
        (field "value" string)


toInt : String -> Int
toInt string =
    case String.toInt string of
        Just int ->
            int

        Nothing ->
            0


toBool : String -> Bool
toBool string =
    case string of
        "true" ->
            True

        _ ->
            False



-- Gooey = { Gooey | attributes: [ Attribute ]}
