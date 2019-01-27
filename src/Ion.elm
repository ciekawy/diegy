module Ion exposing (..)

import Html exposing (Attribute, Html)
--import Html.Keyed exposing (node)

import Json.Encode as Json

app : List (Attribute msg) -> List (Html msg) -> Html msg
app =
    Elm.Kernel.VirtualDom.node "ion-app"

button : List (Attribute msg) -> List (Html msg) -> Html msg
button =
    Elm.Kernel.VirtualDom.node "ion-button"

header : List (Attribute msg) -> List (Html msg) -> Html msg
header =
    Elm.Kernel.VirtualDom.node "ion-header"

title : List (Attribute msg) -> List (Html msg) -> Html msg
title =
    Elm.Kernel.VirtualDom.node "ion-title"

toolbar : List (Attribute msg) -> List (Html msg) -> Html msg
toolbar =
    Elm.Kernel.VirtualDom.node "ion-toolbar"

content : List (Attribute msg) -> List (Html msg) -> Html msg
content =
    Elm.Kernel.VirtualDom.node "ion-content"

searchbar : List (Attribute msg) -> List (Html msg) -> Html msg
searchbar =
    Elm.Kernel.VirtualDom.node "ion-searchbar"

list : List (Attribute msg) -> List (Html msg) -> Html msg
list =
    Elm.Kernel.VirtualDom.node "ion-list"

item : List (Attribute msg) -> List (String, Html msg) -> Html msg
item =
    Elm.Kernel.VirtualDom.keyedNode "ion-item"


-- attributes
stringProperty : String -> String -> Attribute msg
stringProperty key string =
  Elm.Kernel.VirtualDom.property key (Json.string string)

color : String -> Attribute msg
color =
  stringProperty "color"

