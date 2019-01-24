module Main exposing (..)

import Basics exposing (Never)
import Browser exposing
  ( sandbox
  , element
  , document)

import Html exposing (Html, div, h1, img, node, text)
import Html.Events exposing (onClick)


---- MODEL ----


type alias Model =
    { counter : Int
    }


init : flags -> ( Model, Cmd Msg )
init flags =
  ( { counter = 0 }, Cmd.none )



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
        , node "ion-button" [ onClick Increment ] [ text "+" ]
        , node "ion-button" [ onClick Decrement ] [ text "-" ]
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