module Main exposing (..)

import Basics exposing (Never)
import Browser exposing
  ( sandbox
  , element
  , document)

import Html exposing (Html, div, h1, img, node, text)
import Html.Events exposing (onClick)

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

makeRequest : Cmd YelpMsg
makeRequest =
    query
        |> Graphql.Http.queryRequest "https://api.yelp.com/v3/graphql"
        |> Graphql.Http.withHeader "Authorization"
            "Bearer 3siexgIFYuO7pvr2qvCaVvjqS_23dEHjbfuWJ5eGpapEM-HCSeghF2YA6qeTlSd6yEWUfPwG3q7hZzlgI8za4NQy5HhJsdwMes8LVvVbUKkXynJPGcku89wEf_dIXHYx"
        |> Graphql.Http.send (RemoteData.fromResult >> GotResponse)

type YelpMsg
    = GotResponse YelpModel

type alias YelpModel =
    RemoteData (Graphql.Http.Error Response) Response

---- MODEL ----


type alias Model =
    {
    counter : Int,
    businesses: Maybe BusinessesFragment
    }


init : flags -> ( Model, Cmd Msg )
init flags =
  ( { counter = 0, businesses = Nothing }, Cmd.none )


---- UPDATE ----


type Msg
    = NoOp
    | Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            (model, Cmd.none)

        Increment ->
            ({ model | counter = model.counter + 1 }, Cmd.batch [])

        Decrement ->
            ({ model | counter = model.counter - 1 }, Cmd.batch [])

---- VIEW ----

view : Model -> Html Msg
view model =
    div []
                [ Html.p [] [ text "Elm is here!" ]
                , Ion.button [ onClick Increment ] [ text "+" ]
                , Ion.button [ onClick Decrement ] [ text "-" ]
                , Html.p [] [ text <| "Count is " ++ String.fromInt model.counter ]
                ]


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }