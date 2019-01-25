module Ion exposing (..)

import Html exposing (Attribute, Html, node)

button : List (Attribute msg) -> List (Html msg) -> Html msg
button =
    Elm.Kernel.VirtualDom.node "ion-button"

content : List (Attribute msg) -> List (Html msg) -> Html msg
content =
    Elm.Kernel.VirtualDom.node "ion-content"


