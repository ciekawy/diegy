-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module YelpApi.Query exposing (BusinessMatchOptionalArguments, BusinessMatchRequiredArguments, BusinessOptionalArguments, CategoriesOptionalArguments, EventOptionalArguments, EventSearchOptionalArguments, PhoneSearchOptionalArguments, ReviewsOptionalArguments, SearchOptionalArguments, business, business_match, categories, event, event_search, phone_search, reviews, search)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)
import YelpApi.Enum.MatchThreshold
import YelpApi.InputObject
import YelpApi.Interface
import YelpApi.Object
import YelpApi.Scalar
import YelpApi.ScalarCodecs
import YelpApi.Union


type alias BusinessOptionalArguments =
    { id : OptionalArgument String }


{-| Load information about a specific business.

  - id - The Yelp ID for the business you want to load.

-}
business : (BusinessOptionalArguments -> BusinessOptionalArguments) -> SelectionSet decodesTo YelpApi.Object.Business -> SelectionSet (Maybe decodesTo) RootQuery
business fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { id = Absent }

        optionalArgs =
            [ Argument.optional "id" filledInOptionals.id Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "business" optionalArgs object_ (identity >> Decode.nullable)


type alias BusinessMatchOptionalArguments =
    { address2 : OptionalArgument String
    , address3 : OptionalArgument String
    , latitude : OptionalArgument Float
    , longitude : OptionalArgument Float
    , phone : OptionalArgument String
    , postal_code : OptionalArgument String
    , limit : OptionalArgument Int
    , match_threshold : OptionalArgument YelpApi.Enum.MatchThreshold.MatchThreshold
    }


type alias BusinessMatchRequiredArguments =
    { name : String
    , address1 : String
    , city : String
    , state : String
    , country : String
    }


{-| Match detailed business location data to businesses on Yelp.

  - name - Required. The name of the business. Maximum length is 64; only digits, letters, spaces, and !#$%&+,­./:?@'are allowed.
  - address1 - Required. The first line of the business’s address. Maximum length is 64; only digits, letters, spaces, and ­’/#&,.: are allowed. Note that the empty string is allowed; this will specifically match certain service businesses that have no street address.
  - address2 - Optional. The second line of the business’s address. Maximum length is 64; only digits, letters, spaces, and ­’/#&,.: are allowed.
  - address3 - Optional. The third line of the business’s address. Maximum length is 64; only digits, letters, spaces, and ­’/#&,.: are allowed.
  - city - Required. The city of the business. Maximum length is 64; only digits, letters, spaces, and ­’.() are allowed.
  - state - Required. The ISO 3166­-2 code for the region/province of the business. Maximum length is 3.
  - country - Required. The ISO 3166­-1 alpha­2 country code of the business. Maximum length is 2.
  - latitude - Optional. The WGS84 latitude of the business in decimal degrees. Must be between ­-90 and +90.
  - longitude - Optional. The WGS84 longitude of the business in decimal degrees. Must be between ­-180 and +180.
  - phone - Optional. The phone number of the business which can be submitted as (a) locally ­formatted with digits only (e.g., 016703080) or (b) internationally­ formatted with a leading + sign and digits only after (+35316703080). Maximum length is 32.
  - postal\_code - Optional. The postal code of the business. Maximum length is 12.
  - limit - Optional. The maximum number of businesses to return.
  - match\_threshold - Optional. A match quality threshold that will determine how closely businesses must match the input to be returned. Defaults to DEFAULT.

-}
business_match : (BusinessMatchOptionalArguments -> BusinessMatchOptionalArguments) -> BusinessMatchRequiredArguments -> SelectionSet decodesTo YelpApi.Object.Businesses -> SelectionSet (Maybe decodesTo) RootQuery
business_match fillInOptionals requiredArgs object_ =
    let
        filledInOptionals =
            fillInOptionals { address2 = Absent, address3 = Absent, latitude = Absent, longitude = Absent, phone = Absent, postal_code = Absent, limit = Absent, match_threshold = Absent }

        optionalArgs =
            [ Argument.optional "address2" filledInOptionals.address2 Encode.string, Argument.optional "address3" filledInOptionals.address3 Encode.string, Argument.optional "latitude" filledInOptionals.latitude Encode.float, Argument.optional "longitude" filledInOptionals.longitude Encode.float, Argument.optional "phone" filledInOptionals.phone Encode.string, Argument.optional "postal_code" filledInOptionals.postal_code Encode.string, Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "match_threshold" filledInOptionals.match_threshold (Encode.enum YelpApi.Enum.MatchThreshold.toString) ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "business_match" (optionalArgs ++ [ Argument.required "name" requiredArgs.name Encode.string, Argument.required "address1" requiredArgs.address1 Encode.string, Argument.required "city" requiredArgs.city Encode.string, Argument.required "state" requiredArgs.state Encode.string, Argument.required "country" requiredArgs.country Encode.string ]) object_ (identity >> Decode.nullable)


type alias ReviewsOptionalArguments =
    { business : OptionalArgument String
    , locale : OptionalArgument String
    , limit : OptionalArgument Int
    , offset : OptionalArgument Int
    }


{-| Load reviews for a specific business.

  - business - The Yelp ID for the business you want to load.
  - locale - Output locale. Show reviews in the same language. See the list of supported locales.

-}
reviews : (ReviewsOptionalArguments -> ReviewsOptionalArguments) -> SelectionSet decodesTo YelpApi.Object.Reviews -> SelectionSet (Maybe decodesTo) RootQuery
reviews fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { business = Absent, locale = Absent, limit = Absent, offset = Absent }

        optionalArgs =
            [ Argument.optional "business" filledInOptionals.business Encode.string, Argument.optional "locale" filledInOptionals.locale Encode.string, Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "offset" filledInOptionals.offset Encode.int ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "reviews" optionalArgs object_ (identity >> Decode.nullable)


type alias PhoneSearchOptionalArguments =
    { phone : OptionalArgument String }


{-| Search for businesses on Yelp by their phone number.

  - phone - Required. Phone number of the business you want to search for. It must start with + and include the country code, like +14159083801.

-}
phone_search : (PhoneSearchOptionalArguments -> PhoneSearchOptionalArguments) -> SelectionSet decodesTo YelpApi.Object.Businesses -> SelectionSet (Maybe decodesTo) RootQuery
phone_search fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { phone = Absent }

        optionalArgs =
            [ Argument.optional "phone" filledInOptionals.phone Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "phone_search" optionalArgs object_ (identity >> Decode.nullable)


type alias SearchOptionalArguments =
    { term : OptionalArgument String
    , location : OptionalArgument String
    , country : OptionalArgument String
    , offset : OptionalArgument Int
    , limit : OptionalArgument Int
    , sort_by : OptionalArgument String
    , locale : OptionalArgument String
    , longitude : OptionalArgument Float
    , latitude : OptionalArgument Float
    , categories : OptionalArgument String
    , open_now : OptionalArgument Bool
    , open_at : OptionalArgument Int
    , price : OptionalArgument String
    , attributes : OptionalArgument (List (Maybe String))
    , radius : OptionalArgument Float
    }


{-| Search for businesses on Yelp.

  - term - Optional. Search term (e.g. "food", "restaurants"). If term isn't included we search everything. The term keyword also accepts business names such as "Starbucks".
  - location - Required. Specifies the combination of "address, neighborhood, city, state or zip, optional country" to be used when searching for businesses.
  - offset - Optional. Offset the list of returned business results by this amount.
  - limit - Optional. Number of business results to return. By default, it will return 20. Maximum is 50.
  - sort\_by - Sort the results by one of the these modes: best\_match, rating, review\_count or distance. By default it's best\_match. The rating sort is not strictly sorted by the rating value, but by an adjusted rating value that takes into account the number of ratings, similar to a Bayesian average. This is so a business with 1 rating of 5 stars doesn't immediately jump to the top.
  - locale - Optional. Specify the locale to return the event information in. See the list of supported locales.
  - longitude - Required if location is not provided. Longitude of the location you want to search nearby.
  - latitude - Required if location is not provided. Latitude of the location you want to search nearby.
  - categories - Optional. Categories to filter the search results with. See the list of supported categories. The category filter can be a list of comma delimited categories. For example, "bars,french" will filter by Bars OR French. The category identifier should be used (for example "discgolf", not "Disc Golf").
  - open\_now - Optional. Default to false. When set to true, only return the businesses open now. Notice that open\_at and open\_now cannot be used together.
  - open\_at - Optional. An integer representing the Unix time in the same timezone of the search location. If specified, it will return business open at the given time. Notice that open\_at and open\_now cannot be used together.
  - price - Optional. Pricing levels to filter the search result with: 1 = $, 2 = $$, 3 = $$$, 4 = $$$$. The price filter can be a list of comma delimited pricing levels. For example, "1, 2, 3" will filter the results to show the ones that are $, $$, or $$$.
  - attributes - Additional filters to restrict search results.
  - radius - Optional. Search radius in meters. If the value is too large, a AREA\_TOO\_LARGE error may be returned. The max value is 40000 meters (25 miles).

-}
search : (SearchOptionalArguments -> SearchOptionalArguments) -> SelectionSet decodesTo YelpApi.Object.Businesses -> SelectionSet (Maybe decodesTo) RootQuery
search fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { term = Absent, location = Absent, country = Absent, offset = Absent, limit = Absent, sort_by = Absent, locale = Absent, longitude = Absent, latitude = Absent, categories = Absent, open_now = Absent, open_at = Absent, price = Absent, attributes = Absent, radius = Absent }

        optionalArgs =
            [ Argument.optional "term" filledInOptionals.term Encode.string, Argument.optional "location" filledInOptionals.location Encode.string, Argument.optional "country" filledInOptionals.country Encode.string, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "sort_by" filledInOptionals.sort_by Encode.string, Argument.optional "locale" filledInOptionals.locale Encode.string, Argument.optional "longitude" filledInOptionals.longitude Encode.float, Argument.optional "latitude" filledInOptionals.latitude Encode.float, Argument.optional "categories" filledInOptionals.categories Encode.string, Argument.optional "open_now" filledInOptionals.open_now Encode.bool, Argument.optional "open_at" filledInOptionals.open_at Encode.int, Argument.optional "price" filledInOptionals.price Encode.string, Argument.optional "attributes" filledInOptionals.attributes (Encode.string |> Encode.maybe |> Encode.list), Argument.optional "radius" filledInOptionals.radius Encode.float ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "search" optionalArgs object_ (identity >> Decode.nullable)


type alias EventOptionalArguments =
    { id : OptionalArgument String }


{-| Load information about a specific event.

  - id - The Yelp ID for the event you want to load.

-}
event : (EventOptionalArguments -> EventOptionalArguments) -> SelectionSet decodesTo YelpApi.Object.Event -> SelectionSet (Maybe decodesTo) RootQuery
event fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { id = Absent }

        optionalArgs =
            [ Argument.optional "id" filledInOptionals.id Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "event" optionalArgs object_ (identity >> Decode.nullable)


type alias EventSearchOptionalArguments =
    { locale : OptionalArgument String
    , offset : OptionalArgument Int
    , limit : OptionalArgument Int
    , sort_by : OptionalArgument String
    , sort_on : OptionalArgument String
    , start_date : OptionalArgument Int
    , end_date : OptionalArgument Int
    , categories : OptionalArgument (List (Maybe String))
    , is_free : OptionalArgument Bool
    , location : OptionalArgument String
    , latitude : OptionalArgument Float
    , longitude : OptionalArgument Float
    , radius : OptionalArgument Float
    }


{-| Search for events based on search parameters.

  - locale - Optional. Specify the locale to return the event information in. See the list of supported locales.
  - offset - Optional. Offset the list of returned events results by this amount.
  - limit - Optional. Number of events results to return. By default, it will return 3. Maximum is 50.
  - sort\_by - Optional. Sort by either descending or ascending order. By default, it returns results in descending order.
  - sort\_on - Optional. Sort on popularity or time start. By default, sorts on popularity.
  - start\_date - Optional. Unix timestamp of the event start time. Will return events that only begin at or after the specified time.
  - end\_date - Optional. Unix timestamp of the event end time. Will return events that only end at or before the specified time.
  - categories - Optional. The category filter can be a list of comma delimited categories to get OR'd results that include the categories provided. See the list of categories.
  - is\_free - Optional. Filter whether the events are free to attend. By default no filter is applied so both free and paid events will be returned.
  - location - Optional. Specifies the combination of "address, neighborhood, city, state or zip, optional country" to be used when searching for events.
  - latitude - Optional. Latitude of the location you want to search nearby. If latitude is provided, longitude is required too.
  - longitude - Optional. Longitude of the location you want to search nearby. If longitude is provided, latitude is required too.
  - radius - Optional. Search radius in meters. If the value is too large, a AREA\_TOO\_LARGE error may be returned. The max value is 40000 meters (25 miles).

-}
event_search : (EventSearchOptionalArguments -> EventSearchOptionalArguments) -> SelectionSet decodesTo YelpApi.Object.Events -> SelectionSet (Maybe decodesTo) RootQuery
event_search fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { locale = Absent, offset = Absent, limit = Absent, sort_by = Absent, sort_on = Absent, start_date = Absent, end_date = Absent, categories = Absent, is_free = Absent, location = Absent, latitude = Absent, longitude = Absent, radius = Absent }

        optionalArgs =
            [ Argument.optional "locale" filledInOptionals.locale Encode.string, Argument.optional "offset" filledInOptionals.offset Encode.int, Argument.optional "limit" filledInOptionals.limit Encode.int, Argument.optional "sort_by" filledInOptionals.sort_by Encode.string, Argument.optional "sort_on" filledInOptionals.sort_on Encode.string, Argument.optional "start_date" filledInOptionals.start_date Encode.int, Argument.optional "end_date" filledInOptionals.end_date Encode.int, Argument.optional "categories" filledInOptionals.categories (Encode.string |> Encode.maybe |> Encode.list), Argument.optional "is_free" filledInOptionals.is_free Encode.bool, Argument.optional "location" filledInOptionals.location Encode.string, Argument.optional "latitude" filledInOptionals.latitude Encode.float, Argument.optional "longitude" filledInOptionals.longitude Encode.float, Argument.optional "radius" filledInOptionals.radius Encode.float ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "event_search" optionalArgs object_ (identity >> Decode.nullable)


type alias CategoriesOptionalArguments =
    { lias : OptionalArgument String
    , country : OptionalArgument String
    , locale : OptionalArgument String
    }


{-|

  - alias - Optional. Alias of the category to search for. If alias is provided, up to one result will be returned.
  - country - Optional. Country code used to filter categories available in a given country.
  - locale - Optional. Locale used to localize the title of the category. By default, this is set to en\_US.

-}
categories : (CategoriesOptionalArguments -> CategoriesOptionalArguments) -> SelectionSet decodesTo YelpApi.Object.Categories -> SelectionSet (Maybe decodesTo) RootQuery
categories fillInOptionals object_ =
    let
        filledInOptionals =
            fillInOptionals { lias = Absent, country = Absent, locale = Absent }

        optionalArgs =
            [ Argument.optional "alias" filledInOptionals.lias Encode.string, Argument.optional "country" filledInOptionals.country Encode.string, Argument.optional "locale" filledInOptionals.locale Encode.string ]
                |> List.filterMap identity
    in
    Object.selectionForCompositeField "categories" optionalArgs object_ (identity >> Decode.nullable)
