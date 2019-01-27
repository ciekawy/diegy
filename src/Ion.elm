module Ion exposing (..)

import Html exposing (Attribute, Html, node)
import Html.Events exposing (stopPropagationOn, targetValue)
import Json.Decode
--import Html.Keyed exposing (node)

import Json.Encode as Json

app : List (Attribute msg) -> List (Html msg) -> Html msg
app =
    node "ion-app"

button : List (Attribute msg) -> List (Html msg) -> Html msg
button =
    node "ion-button"

header : List (Attribute msg) -> List (Html msg) -> Html msg
header =
    node "ion-header"

title : List (Attribute msg) -> List (Html msg) -> Html msg
title =
    node "ion-title"

toolbar : List (Attribute msg) -> List (Html msg) -> Html msg
toolbar =
    node "ion-toolbar"

content : List (Attribute msg) -> List (Html msg) -> Html msg
content =
    node "ion-content"

grid : List (Attribute msg) -> List (String, Html msg) -> Html msg
grid =
    Elm.Kernel.VirtualDom.keyedNode "ion-grid"

row : List (Attribute msg) -> List (Html msg) -> Html msg
row =
    node "ion-row"

col : List (Attribute msg) -> List (Html msg) -> Html msg
col =
    node "ion-col"

label : List (Attribute msg) -> List (Html msg) -> Html msg
label =
    node "ion-label"

list : List (Attribute msg) -> List (Html msg) -> Html msg
list =
    node "ion-list"

item : List (Attribute msg) -> List (String, Html msg) -> Html msg
item =
    Elm.Kernel.VirtualDom.keyedNode "ion-item"

searchbar : List (Attribute msg) -> List (Html msg) -> Html msg
searchbar =
    node "ion-searchbar"


-- attributes
stringProperty : String -> String -> Attribute msg
stringProperty key string =
  Elm.Kernel.VirtualDom.property key (Json.string string)

color : String -> Attribute msg
color =
  stringProperty "color"

ionChange : (String -> msg) -> Attribute msg
ionChange tagger =
  stopPropagationOn "ionChange" (Json.Decode.map alwaysStop (Json.Decode.map tagger targetValue))

alwaysStop : a -> (a, Bool)
alwaysStop x =
  (x, True)
