module Main exposing (..)

import Basics exposing (Never)
import Browser exposing
  ( sandbox
  , element
  , document)

import Html exposing (Html, div, h2, h4, p, img, text, node)
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

type alias QueryParams = {
    term: Maybe String,
    location: Geolocation}

locationFallback : Geolocation -> OptionalArgument String
locationFallback location =
    case location of
        Nothing ->
            Present "Guadalajara"
        _ ->
            Absent

locationToOptionalArg : Geolocation -> { longitude: OptionalArgument Float, latitude: OptionalArgument Float }
locationToOptionalArg location =
    case location of
        Nothing ->
            { longitude = Absent, latitude = Absent }
        Just { longitude, latitude } ->
            { longitude = Present longitude, latitude = Present latitude }

queryArgs : QueryParams -> Query.SearchOptionalArguments -> Query.SearchOptionalArguments
queryArgs params = (\args -> { args |
    term = fromMaybe params.term,
    sort_by = Present "rating",
    longitude = (locationToOptionalArg params.location).longitude,
    latitude = (locationToOptionalArg params.location).latitude,
    location = locationFallback params.location })

query : QueryParams -> SelectionSet Response RootQuery
query params = (Query.search (queryArgs params)) businessesSelection

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

makeRequest : QueryParams -> Cmd Msg
makeRequest params =
    params
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

type alias Geolocation = Maybe { longitude: Float, latitude: Float }

type alias Model =
    {
    location: Geolocation,
    counter : Int,
    yelpData: Maybe BusinessesFragment -- TODO support response here to handle errors
    }


init : Geolocation -> ( Model, Cmd Msg )
init flags =
  ( {
  location = flags,
  counter = 0,
--  yelpData = RemoteData.Loading
  yelpData = Maybe.Nothing
  }, makeRequest { term = Nothing, location = flags })


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
            (model, makeRequest ({ term = Just value, location = model.location }))
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
        div [] [
            Ion.searchbar [
                attribute "debounce" "600",
                Ion.ionChange Change
            ] []
            , Html.div [] [ text ("results near you (total " ++ String.fromInt (
                Maybe.withDefault 0 (
                    Maybe.withDefault emptyBusinessesFragment model.yelpData).total) ++ "):")]
            , lazy yelpResultsView (model.yelpData |> Maybe.withDefault emptyBusinessesFragment)
        ]

main : Program Geolocation Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }