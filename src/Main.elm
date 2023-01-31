import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

view : Model -> Html Msg
view model =
    div []
        [ text "Enter search text:"
        , input [ onInput Search, value model.searchText ] []
        , ul [] (List.map (\(tokenId, metadata) ->
            if (String.contains metadata.name model.searchText) || (String.contains metadata.description model.searchText) then
              li [] [ text (metadata.name ++ " - " ++ metadata.description) ]
            else
              text ""
            ) model.metadatas)
        ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Search event ->
            ({ model | searchText = event.target.value }, Cmd.none)
        FetchMetadataSuccess (tokenId, metadata) ->
            ({ model | metadatas = List.append model.metadatas [(tokenId, metadata)] }, Cmd.none)
        FetchMetadataError _ ->
            (model, Cmd.none)
        FetchMetadata tokenIds ->
            (model, fetchMetadata tokenIds)