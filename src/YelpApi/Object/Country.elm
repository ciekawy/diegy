-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module YelpApi.Object.Country exposing (code, locales)

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


{-| The ISO 3166-1 alpha-2 code for this country.
-}
code : SelectionSet (Maybe String) YelpApi.Object.Country
code =
    Object.selectionForField "(Maybe String)" "code" [] (Decode.string |> Decode.nullable)


{-| Supported locales with this country.
-}
locales : SelectionSet decodesTo YelpApi.Object.Locale -> SelectionSet (Maybe (List (Maybe decodesTo))) YelpApi.Object.Country
locales object_ =
    Object.selectionForCompositeField "locales" [] object_ (identity >> Decode.nullable >> Decode.list >> Decode.nullable)
