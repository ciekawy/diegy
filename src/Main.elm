module Main exposing (..)

import Basics exposing (Never)
import Browser exposing
  ( sandbox
  , element
  , document)

import Html exposing (Html, div, h2, h4, p, img, text, node)
import Html.Keyed as HtmlKeyed
--import Html.Keyed exposing (node)
import Html.Lazy exposing (lazy)

import Html.Events exposing (onClick)
import Html.Attributes exposing (attribute)

import Json.Decode

import Ion

import Graphql.Document as Document
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.OptionalArgument exposing (fromMaybe)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)

import RemoteData exposing (RemoteData)

import YelpApi.Query as Query
import YelpApi.Object.Business as Business
import YelpApi.Object.Businesses as Businesses
import YelpApi.Object


type alias Response = Maybe BusinessesFragment

queryArgs : Maybe String -> Query.SearchOptionalArguments -> Query.SearchOptionalArguments
queryArgs searchTerm = (\args -> { args | term = fromMaybe searchTerm, location = Present "Guadalajara" })

query : Maybe String -> SelectionSet Response RootQuery
query searchTerm = (Query.search (queryArgs searchTerm)) businessesSelection
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


businessSelection : SelectionSet BusinessFragment YelpApi.Object.Business
businessSelection =
    SelectionSet.map2 BusinessFragment
        Business.name
        Business.rating

makeRequest : Maybe String -> Cmd Msg
makeRequest searchTerm =
    searchTerm
        |> query
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
    yelpData: Maybe BusinessesFragment -- TODO support response here to handle errors
    }


init : flags -> ( Model, Cmd Msg )
init _ =
  ( {
  counter = 0,
--  yelpData = RemoteData.Loading
  yelpData = Maybe.Nothing
  }, makeRequest Nothing )


---- UPDATE ----
keyedNode = Elm.Kernel.VirtualDom.keyedNode

type Msg
    = NoOp
    | Increment
    | Decrement
    | GotResponse YelpModel
    | Change String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Change value ->
            (model, makeRequest (Just value))
        NoOp ->
            (model, Cmd.none)

        Increment ->
            ({ model | counter = model.counter + 1 }, Cmd.batch [])

        Decrement ->
            ({ model | counter = model.counter - 1 }, Cmd.batch [])

        GotResponse remoteData ->
            case remoteData of
                RemoteData.Success response ->
                    ({ model | yelpData = response  }, Cmd.batch [])
                _ ->
                    ({ model | yelpData = Maybe.Nothing  }, Cmd.batch [])
-- ignore for a while

---- VIEW ----

viewCount : Int -> Html Msg
viewCount counter = keyedNode "h2" [] [ ("asdasd", text <| "Count is " ++ String.fromInt counter )]

emptyBusinessesFragment : BusinessesFragment
emptyBusinessesFragment = {
    business = Just [],
    total = Maybe.Just 0}

emptyBusiness : BusinessFragment
emptyBusiness = { name = Nothing, rating = Nothing }


yelpResultView : Maybe BusinessFragment -> (String, Html Msg)
yelpResultView business =
    ("", Ion.row [] [
        Ion.col [ Html.Attributes.style "text-align" "left"] [ text ("" ++ ((business |> Maybe.withDefault emptyBusiness).name |> Maybe.withDefault "")) ],
        Ion.col [] [ text ("" ++ String.fromFloat ((business |> Maybe.withDefault emptyBusiness).rating |> Maybe.withDefault 0)) ]
    ])

yelpResultsView : BusinessesFragment -> Html Msg
yelpResultsView yelp =
    Ion.grid []
        (List.map yelpResultView ((yelp.business |> Maybe.withDefault [Just emptyBusiness])))


--dbg : String -> Msg
--dbg str = Debug.log str, "asd"

view : Model -> Html Msg
view model =
--    div []
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
            Ion.searchbar [
                attribute "debounce" "1000",
                Ion.ionChange Change
            ] []
            , lazy yelpResultsView (model.yelpData |> Maybe.withDefault emptyBusinessesFragment)
            , div []
                [ Html.p [] [ text ("Elm is here! results:" ++ String.fromInt (
                    Maybe.withDefault 0 (
                        Maybe.withDefault emptyBusinessesFragment model.yelpData).total)) ]
                , Ion.button [ onClick Increment ] [ text "+" ]
                , Ion.button [ onClick Decrement ] [ text "-" ]
                , lazy viewCount model.counter
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