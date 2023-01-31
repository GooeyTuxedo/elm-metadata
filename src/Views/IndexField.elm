import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

view : Model -> Html Msg
view model =
    div []
        [ text "Enter number of tokenIds:"
        , input [ onInput UpdateNumberOfTokenIds, value model.numberOfTokenIds ] []
        , button [ onClick GenerateTokenIds ] [ text "Generate tokenIds" ]
        , ul [] (List.map (\tokenId -> li [] [ text tokenId ]) model.tokenIds)
        ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        UpdateNumberOfTokenIds event ->
            ({ model | numberOfTokenIds = event.target.value }, Cmd.none)
        GenerateTokenIds ->
            let
                tokenIds =
                    List.range 1 (String.toInt model.numberOfTokenIds)
                    |> List.map (\i -> "tokenId" ++ (String.fromInt i))
            in
            ({ model | tokenIds = tokenIds }, FetchMetadata tokenIds)
        FetchMetadataSuccess (tokenId, metadata) ->
            ({ model | metadatas = List.append model.metadatas [(tokenId, metadata)] }, Cmd.none)
        FetchMetadataError _ ->
            (model, Cmd.none)
        FetchMetadata tokenIds ->
            (model, fetchMetadata tokenIds)