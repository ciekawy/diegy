module Main exposing (..)

import Basics exposing (Never)
import Browser exposing
  ( sandbox
  , element
  , document)

import Html exposing (Html, div, h2, h4, p, img, text)
--import Html.Keyed as HtmlKeyed
import Html.Keyed exposing (node)
import Html.Lazy as Lazy

import Html.Events exposing (onClick)
import Html.Attributes exposing (attribute)

import Ion

import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)

import RemoteData exposing (RemoteData)

import YelpApi.Query as Query
import YelpApi.Object.Business as Business
import YelpApi.Object.Businesses as Businesses
import YelpApi.Object


type alias Response = Maybe BusinessesFragment

queryArgs : Query.SearchOptionalArguments -> Query.SearchOptionalArguments
queryArgs args = { args | location = Present "Guadalajara" }

query : SelectionSet Response RootQuery
query = (Query.search queryArgs) businessesSelection
--    SelectionSet.succeed BusinessFragment
--        |> with (Query.search (identity { location = "Guadalajara" })
--            |> with Business.name
--            |> with Business.rating)


--Query.search (identity { location = "Guadalajara" }) businessSelection

type alias BusinessFragment = {
    name : Maybe String,
    rating : Maybe Float
    }

type alias BusinessesFragment = {
   business: Maybe (List (Maybe BusinessFragment)),
   total : Maybe Int
   }

businessesSelection : SelectionSet BusinessesFragment YelpApi.Object.Businesses
businessesSelection =
    SelectionSet.map2 BusinessesFragment
        (Businesses.business businessSelection)
        Businesses.total
--    SelectionSet.succeed BusinessesFragment
--        |> with Businesses.total
--        |> with businessSelection


businessSelection : SelectionSet BusinessFragment YelpApi.Object.Business
businessSelection =
    SelectionSet.map2 BusinessFragment
        Business.name
        Business.rating

--    SelectionSet.succeed BusinessFragment
--        |> with Business.name
--        |> with Business.rating

makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphql.Http.queryRequest "https://cors-anywhere.herokuapp.com/https://api.yelp.com/v3/graphql"
        |> Graphql.Http.withHeader "Accept-Language" "en_US"
--        |> Graphql.Http.withCredentials
        |> Graphql.Http.withHeader "Authorization"
            "Bearer 3siexgIFYuO7pvr2qvCaVvjqS_23dEHjbfuWJ5eGpapEM-HCSeghF2YA6qeTlSd6yEWUfPwG3q7hZzlgI8za4NQy5HhJsdwMes8LVvVbUKkXynJPGcku89wEf_dIXHYx"
--        |> Graphql.Http.withHeader "Access-Control-Allow-Origin" "localhost:3333"
        |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)

type alias YelpModel =
    RemoteData (Graphql.Http.Error Response) Response

---- MODEL ----


type alias Model =
    {
    counter : Int,
    yelpData: RemoteData (Graphql.Http.Error Response) Response
    }


init : flags -> ( Model, Cmd Msg )
init _ =
  ( { counter = 0, yelpData = RemoteData.Loading }, makeRequest )


---- UPDATE ----


type Msg
    = NoOp
    | Increment
    | Decrement
    | GotResponse YelpModel


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            (model, Cmd.none)

        Increment ->
            ({ model | counter = model.counter + 1 }, Cmd.batch [])

        Decrement ->
            ({ model | counter = model.counter - 1 }, Cmd.batch [])

        GotResponse businessesFragment ->
            ({ model | counter = 0 }, Cmd.batch [])
-- ignore for a while

---- VIEW ----

viewCount : Int -> Html Msg
viewCount counter = node "h2" [] [ ("asdasd", text <| "Count is " ++ String.fromInt counter )]


view : Model -> Html Msg
view model =
--    Ion.app []
--        [ Ion.header []
--            [ Ion.toolbar [ Ion.color "primary" ]
--                [ Ion.title []
--                    [ text "Diegy" ]
--                ]
--            , Ion.toolbar []
--                [ Ion.searchbar []
--                    []
--                ]
--            ]
--        ,
        Ion.content [] [
            Ion.list []
                [ Ion.header [] [ text "results:" ]
                , Ion.item [] [ ("ii", node "ion-label" []
                    [ ("qwe", div []
                    [ Lazy.lazy viewCount model.counter
                    , h4 [] [ text "score: score" ]
                    , p [] [ text "description" ]
                    ])]
                )]
                ]
            , div []
                [ Html.p [] [ text "Elm is here!" ]
                , Ion.button [ onClick Increment ] [ text "+" ]
                , Ion.button [ onClick Decrement ] [ text "-" ]
                , Html.p [] [ text <| "Count is " ++ String.fromInt model.counter ]
                ]
        ]
--    ]
--    Ion.app []
--        [ Ion.header []
--            [ Ion.toolbar [ Ion.color "primary" ]
--                [ Ion.title []
--                    [ text "Diegy" ]
--                ]
--            , Ion.toolbar []
--                [ Ion.searchbar []
--                    []
--                ]
--            ]
--        , Ion.content [ attribute "padding" "" ]
--            [ Ion.list []
--                [ Ion.header []
--                    [ text "results:" ]
--                , Ion.item []
--                    [ h2 [] [ text <| "Count is " ++ String.fromInt model.counter ]
--                    , h4 [] [ text "score: {{score}}" ]
--                    , p [] [ text "{{description}}" ]
--                    ]
--                ]
--            ]
--            , Ion.button [ onClick Increment ] [ text "+" ]
--            , Ion.button [ onClick Decrement ] [ text "-" ]
--            , Html.p [] [ text <| "Count is " ++ String.fromInt model.counter ]
--        ]

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }