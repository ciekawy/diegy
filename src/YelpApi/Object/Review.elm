-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module YelpApi.Object.Review exposing (id, rating, text, time_created, url, user)

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


{-| Yelp ID of this review.
-}
id : SelectionSet (Maybe String) YelpApi.Object.Review
id =
    Object.selectionForField "(Maybe String)" "id" [] (Decode.string |> Decode.nullable)


{-| Rating of this review.
-}
rating : SelectionSet (Maybe Int) YelpApi.Object.Review
rating =
    Object.selectionForField "(Maybe Int)" "rating" [] (Decode.int |> Decode.nullable)


{-| The user who wrote the review.
-}
user : SelectionSet decodesTo YelpApi.Object.User -> SelectionSet (Maybe decodesTo) YelpApi.Object.Review
user object_ =
    Object.selectionForCompositeField "user" [] object_ (identity >> Decode.nullable)


{-| Text excerpt of this review.
-}
text : SelectionSet (Maybe String) YelpApi.Object.Review
text =
    Object.selectionForField "(Maybe String)" "text" [] (Decode.string |> Decode.nullable)


{-| The time that the review was created in PST.
-}
time_created : SelectionSet (Maybe String) YelpApi.Object.Review
time_created =
    Object.selectionForField "(Maybe String)" "time_created" [] (Decode.string |> Decode.nullable)


{-| URL of this review.
-}
url : SelectionSet (Maybe String) YelpApi.Object.Review
url =
    Object.selectionForField "(Maybe String)" "url" [] (Decode.string |> Decode.nullable)
