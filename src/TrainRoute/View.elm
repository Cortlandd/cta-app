module TrainRoute.View exposing (view)

import String
import Html exposing (..)
import Html.CssHelpers
import Api.Train exposing (TrainStop)
import TrainRoute.Model as Model exposing (Model)
import TrainRoute.Update as Update exposing (Msg(..))
import TrainRoute.Classes exposing (..)
import Components.SearchBar as SearchBar
import Icons


filterStops : String -> List TrainStop -> List TrainStop
filterStops searchText stops =
    let
        lowerSearchText =
            String.toLower searchText
    in
        stops
            |> List.filter (\stop -> String.contains lowerSearchText (String.toLower stop.name))


viewStop : String -> TrainStop -> Html Msg
viewStop routeId stop =
    a [ class [ StopItem ] ]
        [ div [ class [ StopName ] ] [ text stop.name ]
        , div [ class [ Chevron ] ] [ Icons.chevronRight ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ div [ class [ ControlsContainer ] ]
            [ SearchBar.view model.searchModel SearchBarMsg
            ]
        , div []
            <| (model.stops
                    |> filterStops (SearchBar.getSearchValue model.searchModel)
                    |> List.sortBy .name
                    |> List.map (viewStop model.route.id)
               )
        ]


{ class, classList } =
    Html.CssHelpers.withNamespace cssNamespace