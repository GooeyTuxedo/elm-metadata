import Http
import Json.Decode as Decode

type Msg
    = FetchMetadata (List String)
    | FetchMetadataSuccess (List (String, Metadata))
    | FetchMetadataError Http.Error

type alias Metadata =
    { name : String
    , description : String
    }

tokenIds : List String
tokenIds = List.range 0 3366 
    |> List.map (/i -> String.fromInt i)

metadataDecoder : Decode.Decoder Metadata
metadataDecoder =
    Decode.map2 Metadata
        (Decode.field "name" Decode.string)
        (Decode.field "description" Decode.string)

fetchMetadata : List String -> Cmd Msg
fetchMetadata ids =
    List.map (\tokenId ->
        Http.get
            { url = "https://foo.com/metadata/" ++ tokenId
            , expect = Http.expectJson metadataDecoder
            }
            (FetchMetadataSuccess (tokenId,))
    ) ids
    |> Cmd.batch

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        FetchMetadata tokenIds ->
            ( model, fetchMetadata tokenIds )

        FetchMetadataSuccess (tokenId, metadata) ->
            ( { model | metadatas = List.append model.metadatas [(tokenId, metadata)] }, Cmd.none )

        FetchMetadataError _ ->
            ( model, Cmd.none )