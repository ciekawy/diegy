-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module YelpApi.Object.Events exposing (events, total)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode
import YelpApi.InputObject
import YelpApi.Interface
import YelpApi.Object
import YelpApi.Scalar
import YelpApi.ScalarCodecs
import YelpApi.Union


{-| List of events found matching search criteria.
-}
events : SelectionSet decodesTo YelpApi.Object.Event -> SelectionSet (Maybe (List (Maybe decodesTo))) YelpApi.Object.Events
events object_ =
    Object.selectionForCompositeField "events" [] object_ (identity >> Decode.nullable >> Decode.list >> Decode.nullable)


{-| Total number of events found.
-}
total : SelectionSet (Maybe Int) YelpApi.Object.Events
total =
    Object.selectionForField "(Maybe Int)" "total" [] (Decode.int |> Decode.nullable)
