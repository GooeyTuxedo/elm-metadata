type alias Firefly =
    { name : String
    , dropID : String
    , description : String
    , image : String
    , attributes : AttributeRecord
    }

type alias AttributeRecord =
    { Item : String
    , Type : String
    , Equippable : String
    , Consumable : String
    }

fireflyDecoder : Json.Decode.Decoder Firefly
fireflyDecoder =
    Json.Decode.map4 Firefly
        (Json.Decode.field "name" Json.Decode.string)
        (Json.Decode.field "dropID" Json.Decode.string)
        (Json.Decode.field "description" Json.Decode.string)
        (Json.Decode.field "image" Json.Decode.string)
        (Json.Decode.field "attributes" (Json.Decode.list attributeDecoder) |> Json.Decode.map createAttributeRecord)

createAttributeRecord : List Attribute -> AttributeRecord
createAttributeRecord attributes =
    List.foldl (\attribute record -> { record | attribute.trait_type = attribute.value }) defaultAttributeRecord attributes

defaultAttributeRecord : AttributeRecord
defaultAttributeRecord =
    { Item = ""
    , Type = ""
    , Equippable = ""
    , Consumable = ""
    }

attributeDecoder : Json.Decode.Decoder Attribute
attributeDecoder =
    Json.Decode.map2 Attribute
        (Json.Decode.field "trait_type" Json.Decode.string)
        (Json.Decode.field "value" Json.Decode.string)